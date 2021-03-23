import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';

class UpdateEmergencyScreen extends StatefulWidget {
  var emergencyData;
  Function GetData;

  UpdateEmergencyScreen({
    this.emergencyData,
    this.GetData,
  });

  @override
  _UpdateEmergencyScreenState createState() => _UpdateEmergencyScreenState();
}

class _UpdateEmergencyScreenState extends State<UpdateEmergencyScreen> {
  File imagePath;
  File _image;
  bool isLoading = false;
  List addEmergencyList = [];

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtNumber = new TextEditingController();

  Future getFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Future getFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('$path');

    var file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );

    print(file.toString());
  }

  void _settingModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return EmergencyBottomSheet(
          setImagePath: getImageFileFromAssets,
        );
      },
    );
  }

  @override
  void initState() {
    txtName.text = widget.emergencyData["contactName"];
    txtNumber.text = widget.emergencyData["contactNo"];
  }

  _updateEmergency() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "emergencyContactId": widget.emergencyData["_id"],
          "contactName": txtName.text,
          "contactNo": txtNumber.text,
        };
        Services.responseHandler(
                apiName: "api/admin/updateEmergencyContacts", body: body)
            .then((responseData) {
          if (responseData.Data != 0) {
            print(responseData.Data);
            widget.GetData();
            Fluttertoast.showToast(msg: "Your Emergency Updated Successfully");
            setState(() {
              isLoading = false;
            });
          } else {
            print(responseData);

            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Emergency",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingConstant.authScreenContentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextFormField(
                controller: txtName,
                lable: "Emergency Name",
                hintText: "Enter Emergency name",
              ),
              MyTextFormField(
                  controller: txtNumber,
                  lable: "Emergency Number",
                  hintText: "Enter Emergency number"),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Image",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  height: 200,
                  child: DottedBorder(
                      color: Colors.grey,
                      dashPattern: [4],
                      padding: EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          _settingModalBottomSheet();
                        },
                        child: Center(
                          child: imagePath != null
                              ? Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(30),
                                    shape: BoxShape.rectangle,
                                    /* border: Border.all(
                                        width: 0.2,
                                        color: appPrimaryMaterialColor),*/
                                    image: DecorationImage(
                                        image: FileImage(
                                          imagePath,
                                        ),
                                        fit: BoxFit.contain),
                                  ),
                                )
                              : Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(30),
                                    shape: BoxShape.rectangle,
                                    /* border: Border.all(
                                        width: 0.2,
                                        color: appPrimaryMaterialColor),*/
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          widget.emergencyData["image"],
                                        ),
                                        fit: BoxFit.contain),
                                  ),
                                ),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: MyButton(
                  onPressed: () {
                    _updateEmergency();
                    Navigator.pop(context);
                  },
                  title: "Update",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyBottomSheet extends StatefulWidget {
  Function setImagePath;

  EmergencyBottomSheet({this.setImagePath});

  @override
  _EmergencyBottomSheetState createState() => _EmergencyBottomSheetState();
}

class _EmergencyBottomSheetState extends State<EmergencyBottomSheet> {
  int currentIndex = 0;
  List Fields = [
    {
      "label": "Ambulance",
      "img": "images/ambulance.png",
    },
    {
      "label": "Blood",
      "img": "images/Blood.png",
    },
    {
      "label": "Fire Truck",
      "img": "images/fire-truck.png",
    },
    {
      "label": "Hospital",
      "img": "images/hospital.png",
    },
    {
      "label": "Petdoctor",
      "img": "images/petdoctor.png",
    },
    {
      "label": "Policeman",
      "img": "images/policeman.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 20, left: 11, right: 11, bottom: 15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 3.0),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            widget.setImagePath(Fields[index]["img"].toString());
            Navigator.of(context).pop();
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 5.0, bottom: 5, right: 3, left: 3),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                /*  boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                    offset: Offset(3.0, 5.0))]*/
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Fields[index]["img"],
                    width: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: FittedBox(
                      // fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "${Fields[index]["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: Fields.length,
    );
  }

/*Widget bottomBox(
    String label,
    String img,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5, right: 3, left: 3),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
          */ /*  boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  offset: Offset(3.0, 5.0))]*/ /*
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: FittedBox(
                // fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/
}
