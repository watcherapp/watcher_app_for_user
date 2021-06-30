import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/BottomNavigationBarCustom.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/ComplainComponent.dart';

class ComplainsScreen extends StatefulWidget {
  @override
  _ComplainsScreenState createState() => _ComplainsScreenState();
}

class _ComplainsScreenState extends State<ComplainsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  bool isLoading = false;
  List getAllComplaintList = [];

  @override
  void initState() {
    _getAllComplains();
  }

  _getAllComplains() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
          "memberId": sharedPrefs.memberId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/member/getAllComplain", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            getAllComplaintList = responseData.Data;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Complaints",
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
      body: RefreshIndicator(
        onRefresh: () {
          return _getAllComplains();
        },
        color: appPrimaryMaterialColor,
        child: Stack(
          children: [
            isLoading == true
                ? Center(
                child: CircularProgressIndicator(
                  //backgroundColor: Color(0xFFFF4F4F),
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
                ))
                : getAllComplaintList.length == 0
                ? Center(
              child: Text("No Complaints Found"),
            )
                : ListView.builder(
                padding: EdgeInsets.only(top: 5, bottom: 18),
                scrollDirection: Axis.vertical,
                itemCount: getAllComplaintList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ComplainComponent(
                    getAllComplain: getAllComplaintList[index],
                    getComplaindApi: () {
                      _getAllComplains();
                    },
                  );
                }),
            Positioned(
              bottom: 30,
              right: 30,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: AddNewComplainScreen(
                            getAllComplainsApi: (){
                              _getAllComplains();
                            },
                          ),
                          type: PageTransitionType.fade));
                },
                icon: Icon(Icons.add),
                label: Text("Add Complain"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}

class AddNewComplainScreen extends StatefulWidget {
  Function getAllComplainsApi;

  AddNewComplainScreen({
    this.getAllComplainsApi,
  });

  @override
  _AddNewComplainScreenState createState() => _AddNewComplainScreenState();
}

class _AddNewComplainScreenState extends State<AddNewComplainScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  File _image;

  TextEditingController txtTitle = new TextEditingController();
  TextEditingController txtDiscription = new TextEditingController();


  //complainCategory is static........................
  _addNewComplain() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        String fileName = _image.path.split('/').last;

        FormData formData = FormData.fromMap({
          "societyId": sharedPrefs.societyId,
          "memberId": sharedPrefs.memberId,
          "subject": txtTitle.text,
          "discription": txtDiscription.text,
          "wingId": sharedPrefs.wingId,
          "flatId": sharedPrefs.flatId,
          "complainCategory": "6045e4db09e1991010527d88",
          "attachment": await MultipartFile.fromFile(
            _image.path,
            filename: fileName,
          ),
        });
        print("$formData");
        Services.responseHandler(apiName: "api/member/addComplain", body: formData)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            widget.getAllComplainsApi();
            Fluttertoast.showToast(
              msg: "Your Complain added Successfully.",
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity:ToastGravity.TOP,
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
          "Add New Complain",
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
                    lable: "Complain Title",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Complain Title";
                      }
                      return null;
                    },
                    hintText: "Type Complain Title",
                  ),
                  MyTextFormField(
                    controller: txtDiscription,
                    lable: "Complain Description",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Complain Description";
                      }
                      return null;
                    },
                    hintText: "Type Complain Description",
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
                        if (_image != null) {
                          _addNewComplain();
                        }else{
                          Fluttertoast.showToast(
                            gravity: ToastGravity.TOP,
                            textColor: Colors.white,
                           backgroundColor: Color(0xFFFF4F4F),
                            msg: "Please Attach Complain Photo",
                          );
                        }
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
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}


