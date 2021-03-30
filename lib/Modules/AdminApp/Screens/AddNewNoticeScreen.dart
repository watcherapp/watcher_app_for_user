import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watcher_app_for_user/CommonWidgets/DialogOpenFormField.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Dialogs/MyDropdown.dart';

class AddNewNoticeScreen extends StatefulWidget {
  Function getAllNoticeApi;

  AddNewNoticeScreen({
    this.getAllNoticeApi,
  });

  @override
  _AddNewNoticeScreenState createState() => _AddNewNoticeScreenState();
}

class _AddNewNoticeScreenState extends State<AddNewNoticeScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  var selctedWing;
  List wingList = [];
  File _image;

  TextEditingController txtTitle = new TextEditingController();
  TextEditingController txtDiscription = new TextEditingController();

  _addNewNotice() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        String fileName = _image.path.split('/').last;

        FormData formData = FormData.fromMap({
          "societyId": societyId,
          "noticeTitle": txtTitle.text,
          "noticeDescription": txtDiscription.text,
          "wingId": selctedWing,
          "noticeImage": await MultipartFile.fromFile(
            _image.path,
            filename: fileName,
          ),
        });
        print("$formData");
        Services.responseHandler(apiName: "api/admin/addNotice", body: formData)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            widget.getAllNoticeApi();
            Fluttertoast.showToast(
              msg: "Your Notice added Successfully.",
            );
            Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
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

  _getAllwings() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": societyId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/getAllWingsOfSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            wingList = responseData.Data;
            print("------------------------>${wingList}");
            // List myList = responseData.Data;
            // for (int i = 0; i < responseData.Data.length; i++) {
            //   wingList.add(myList[i]);
            // }
            setState(() {
              isLoading = false;
            });
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

  @override
  void initState() {
    _getAllwings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Add New Notice",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFormField(
                    controller: txtTitle,
                    lable: "Notice Title",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Notice Title";
                      }
                      return null;
                    },
                    hintText: "Type Notice Title",
                  ),
                  MyTextFormField(
                    controller: txtDiscription,
                    lable: "Notice Description",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Notice Description";
                      }
                      return null;
                    },
                    hintText: "Type Notice Description",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Text(
                      "Select Wing",
                      style: fontConstants.formFieldLabel,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selctedWing,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                            hint: Text(
                              'Select Wing',
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                var locality = '';
                                selctedWing = newValue;
                                locality = newValue.toString();
                                print(selctedWing);
                              });
                            },
                            items: wingList?.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item["wingName"]),
                                    value: item["_id"].toString(),
                                  );
                                })?.toList() ??
                                [],
                          ),
                        ),
                      ),
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
                            child: _image != null
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.file(
                                      _image,
                                    ),
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                  MyButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _addNewNotice();
                      }
                    },
                    title:
                        // isLoading
                        //     ? CircularProgressIndicator(
                        //       valueColor: new AlwaysStoppedAnimation<Color>(
                        //           appPrimaryMaterialColor),
                        //       //backgroundColor: Colors.white54,
                        //     )
                        //     :
                        "Add New",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
