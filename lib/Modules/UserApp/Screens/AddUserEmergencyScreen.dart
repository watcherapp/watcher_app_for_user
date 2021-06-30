import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/BottomNavigationBarCustom.dart';

class AddUserEmergencyScreen extends StatefulWidget {
  Function getAllEmergency;

  AddUserEmergencyScreen({
    this.getAllEmergency,
  });

  @override
  _AddUserEmergencyScreenState createState() => _AddUserEmergencyScreenState();
}

class _AddUserEmergencyScreenState extends State<AddUserEmergencyScreen> {
  File imagePath;
  File _image;
  bool isLoading = false;
  List addEmergencyList = [];

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtNumber = new TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  // Future getFromCamera() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   if (image != null) {
  //     setState(() {
  //       _image = image;
  //     });
  //   }
  // }
  //
  // Future getFromGallery() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       _image = image;
  //     });
  //   }
  // }

  Future<File> getImageFileFromAssets(String path) async {
    print(path);
    final byteData = await rootBundle.load('$path');
    print("s");
    var tempfile = File('${(await getTemporaryDirectory()).path}/$path');
    print("--->${tempfile}");
    print("ss");
    var file = await tempfile.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );

    print("sss");
    print("--->${file}");
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
    // _addEmergency();
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _addEmergency() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        // String fileName = imagePath.path.split('/').last;
        String fileName = _image.path.split('/').last;

        FormData formData = FormData.fromMap({
          "societyId": sharedPrefs.societyId,
          "contactName": txtName.text,
          "contactNo": txtNumber.text,
          "image": await MultipartFile.fromFile(
            // imagePath.path,
            _image.path,
            filename: fileName,
          ),
        });
        print("${formData.fields}");
        Services.responseHandler(
                apiName: "api/admin/addEmergencyNumber", body: formData)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            addEmergencyList = responseData.Data;
            setState(() {
              isLoading = false;
            });
            widget.getAllEmergency();
            Fluttertoast.showToast(
              msg: "Your Emergency added Successfully.",
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity: ToastGravity.TOP,
            );
            Navigator.pop(context);
          } else {
            print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
            msg: "Error $error",
            backgroundColor: Colors.white,
            textColor: appPrimaryMaterialColor,
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "You aren't connected to the Internet !",
        backgroundColor: Colors.white,
        textColor: appPrimaryMaterialColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Emergency",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingConstant.authScreenContentPadding,
          child: Form(
            key: _formKey,
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
                  hintText: "Enter Emergency number",
                ),
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
                            _showPicker(context);
                          },
                          child: Center(
                            child: _image != null
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
                                            _image,
                                          ),
                                          fit: BoxFit.contain),
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("images/id-card.png",
                                          color: Colors.grey[300],
                                          width: 40.0,
                                          height: 40.0),
                                      Text(
                                        "Choose Image",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                          ),
                        )),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 12.0),
                //   child: Container(
                //     height: 200,
                //     child: DottedBorder(
                //         color: Colors.grey,
                //         dashPattern: [4],
                //         padding: EdgeInsets.all(6.0),
                //         child: GestureDetector(
                //           onTap: () {
                //             _settingModalBottomSheet();
                //           },
                //           child: Center(
                //             child: imagePath != null
                //                 ? Container(
                //                     height: 200.0,
                //                     decoration: BoxDecoration(
                //                       // borderRadius: BorderRadius.circular(30),
                //                       shape: BoxShape.rectangle,
                //                       /* border: Border.all(
                //                           width: 0.2,
                //                           color: appPrimaryMaterialColor),*/
                //                       image: DecorationImage(
                //                           image: FileImage(
                //                             imagePath,
                //                           ),
                //                           fit: BoxFit.contain),
                //                     ),
                //                   )
                //                 : Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       Image.asset("images/id-card.png",
                //                           color: Colors.grey[300],
                //                           width: 40.0,
                //                           height: 40.0),
                //                       Text(
                //                         "Choose Image",
                //                         style: TextStyle(
                //                             color: Colors.grey,
                //                             fontWeight: FontWeight.w500),
                //                       )
                //                     ],
                //                   ),
                //           ),
                //         )),
                //   ),
                // ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: MyButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        if (_image != null) {
                          _addEmergency();
                        } else {
                          Fluttertoast.showToast(
                            gravity: ToastGravity.TOP,
                            textColor: Colors.white,
                            backgroundColor: Color(0xFFFF4F4F),
                            msg: "Please Attach Emergency Photo",
                          );
                        }
                      }
                    },
                    title: "Add",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}

//Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.add,
//                             color: Colors.black38,
//                           ),
//                           Text(
//                             "Add Photo",
//                             style: TextStyle(
//                                 color: Colors.black38,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),

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
            print(Fields[index]["img"].toString());
            widget.setImagePath(
              Fields[index]["img"].toString(),
            );
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
