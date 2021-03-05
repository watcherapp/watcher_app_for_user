import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';

class AddEmergencyScreen extends StatefulWidget {
  @override
  _AddEmergencyScreenState createState() => _AddEmergencyScreenState();
}

class _AddEmergencyScreenState extends State<AddEmergencyScreen> {
  String stringImagepath;
  File _image;

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

  setImage(var image) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        stringImagepath = image;
      });
    });
    print(stringImagepath);
  }

  void _settingModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return EmergencyBottomSheet(setImagePath: setImage);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Emergency",
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
                  lable: "Emergency Name", hintText: "Enter Emergency name"),
              MyTextFormField(
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
                          child: stringImagepath != null
                              ? Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(30),
                                    shape: BoxShape.rectangle,
                                    /* border: Border.all(
                                        width: 0.2,
                                        color: appPrimaryMaterialColor),*/
                                    image: DecorationImage(
                                        image: AssetImage(
                                          stringImagepath,
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
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: MyButton(
                  onPressed: () {},
                  title: "Add",
                ),
              )
            ],
          ),
        ),
      ),
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
