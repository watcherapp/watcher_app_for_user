import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watcher_app_for_user/CommonWidgets/DialogOpenFormField.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class AddMyStaff extends StatefulWidget {
  Function staffDataApi;

  AddMyStaff({
    this.staffDataApi,
  });

  @override
  _AddMyStaffState createState() => _AddMyStaffState();
}

class _AddMyStaffState extends State<AddMyStaff> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String idProofData;
  String selctedCategory;
  String selctedId;
  List categoryList = [];
  List idCategoryList = [];
  List images = [];
  bool isLoading = false;
  File _staffProfile;
  File _image;
  File _imageId1;
  File _imageId2;

  TextEditingController txtFname = new TextEditingController();
  TextEditingController txtLname = new TextEditingController();
  TextEditingController txtMoNo = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtAdress = new TextEditingController();

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

  void _showPicker1(context) {
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
                        _imgFromGallery1();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera1();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showPicker2(context) {
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
                        _imgFromGallery2();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera2();
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

  _imgFromCamera1() async {
    File imageId1 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imageId1 = imageId1;
    });
  }

  _imgFromCamera2() async {
    File imageId2 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imageId2 = imageId2;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery1() async {
    File imageId1 = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imageId1 = imageId1;
    });
  }

  _imgFromGallery2() async {
    File imageId2 = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imageId2 = imageId2;
    });
  }

  @override
  void initState() {
    _getAllStaffCategory();
    _getAllIdentityCategory();
  }

  //functions...............
  _addMyStaff() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        String fileName = _image.path.split('/').last;
        String fileName1 = _imageId1.path.split('/').last;

        FormData formData = FormData.fromMap({
          "wingId": sharedPrefs.wingId,
          "flatId": sharedPrefs.flatId,
          "firstName": txtFname.text,
          "lastName": txtLname.text,
          "mobileNo1": txtMoNo.text,
          "emailId": txtEmail.text,
          "completeAddress": txtAdress.text,
          "staffCategoryId": selctedCategory,
          "identityProof": selctedId,
          "identityImage": await MultipartFile.fromFile(
            _imageId1.path,
            filename: fileName1,
          ),
          "staffImage": await MultipartFile.fromFile(
            _image.path,
            filename: fileName,
          ),
        });
        print("$formData");
        Services.responseHandler(apiName: "api/member/addStaff", body: formData)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            widget.staffDataApi();
            Fluttertoast.showToast(
              msg: "Your Staff added Successfully.",
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

  _getAllStaffCategory() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        Services.responseHandler(
          apiName: "api/staff/getAllStaffCategory",
        ).then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            categoryList = responseData.Data;
            print("------------------------>${categoryList}");
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

  _getAllIdentityCategory() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        Services.responseHandler(
          apiName: "api/staff/getAllidentityCategory",
        ).then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            idCategoryList = responseData.Data;
            print("------------------------>${idCategoryList}");
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("Add Staff"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 11.0, right: 11),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          child: _image != null
                              ? Container(
                                  decoration: new BoxDecoration(
                                    color: Color(0x22888888),
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(90.0)),
                                    border: new Border.all(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                    image: DecorationImage(
                                      image: FileImage(
                                        _image,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 95,
                                ),
                          decoration: new BoxDecoration(
                            color: Color(0x22888888),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(90.0)),
                            border: new Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7.0),
                          child: Column(
                            children: [
                              MyTextFormField(
                                  controller: txtFname,
                                  lable: "First Name",
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Please Enter first name";
                                    }
                                    return null;
                                  },
                                  hintText: "Enter first name"),
                              MyTextFormField(
                                  controller: txtLname,
                                  lable: "Last Name",
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Please Enter last name";
                                    }
                                    return null;
                                  },
                                  hintText: "Enter last name"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MyTextFormField(
                    controller: txtMoNo,
                    lable: "Mobile No",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please enter mobile number";
                      }
                      return null;
                    },
                    hintText: "Enter mobile number"),
                MyTextFormField(
                    controller: txtEmail,
                    lable: "Email   ( optional )",
                    // validator: (val) {
                    //   if (val.isEmpty) {
                    //     return "Please Enter email";
                    //   }
                    //   return "";
                    // },
                    hintText: "Enter email"),
                MyTextFormField(
                    controller: txtAdress,
                    lable: "Address",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Address";
                      }
                      return null;
                    },
                    hintText: "Enter address"),
                /* Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text("",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ),*/
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: DialogOpenFormField(
                //       lable: "Staff Identity",
                //       value: idProofData,
                //       onTap: () {
                //         // print("click");
                //         FocusScope.of(context).unfocus();
                //         showDialog(
                //             context: context,
                //             builder: (context) {
                //               return Padding(
                //                 padding: const EdgeInsets.only(top: 4.0),
                //                 child: MyDropDown(
                //                     dropDownTitle: "Identity",
                //                     dropDownData: idProof,
                //                     onSelectValue: (value) {
                //                       setState(() {
                //                         idProofData = value;
                //                       });
                //                     }),
                //               );
                //             });
                //       }),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 6.0),
                  child: Text(
                    "Staff Category",
                    style: fontConstants.formFieldLabel,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0)),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selctedCategory,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                          hint: Text(
                            'Select Staff Category',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              var locality = '';
                              selctedCategory = newValue;
                              locality = newValue.toString();
                              print(selctedCategory);
                            });
                          },
                          items: categoryList?.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item["staffCategoryName"]),
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
                  padding: const EdgeInsets.only(top: 10.0, bottom: 6.0),
                  child: Text(
                    "Staff Identity Proof",
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
                          value: selctedId,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                          hint: Text(
                            'Select Staff Identity Proof',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              var locality = '';
                              selctedId = newValue;
                              locality = newValue.toString();
                              print(selctedId);
                            });
                          },
                          items: idCategoryList?.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item["identityProofName"]),
                                  value: item["_id"].toString(),
                                );
                              })?.toList() ??
                              [],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 4.0),
                  child: Text("Select ID Proof",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: containerdash1),
                    Container(
                      width: 10,
                    ),
                    Expanded(child: containerdash2),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: MyButton(
                      title: "Add Staff",
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _addMyStaff();
                        }
                        /*  Navigator.push(
                            context,
                            PageTransition(
                                child: (),
                                type: PageTransitionType.rightToLeft));*/
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get containerdash1 {
    return Center(
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [5, 5, 5, 5],
        color: Colors.grey[400],
        child: GestureDetector(
          onTap: () {
            _showPicker1(context);
          },
          child: Container(
            height: 110,
            // width: MediaQuery.of(context).size.width / 2.2,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: Color(0x22888888),
            ),
            child: _imageId1 != null
                ? Center(
                    child: Image.file(
                      _imageId1,
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32.0,
                          height: 32.0,
                          child: Icon(
                            Icons.add,
                            color: Colors.black54,
                            size: 25,
                          ),
                          decoration: new BoxDecoration(
                            // color: Colors.grey[300],
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(90.0)),
                            border:
                                new Border.all(color: Colors.grey, width: 1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text("Front",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget get containerdash2 {
    return Center(
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [5, 5, 5, 5],
        color: Colors.grey[400],
        child: GestureDetector(
          onTap: () {
            _showPicker2(context);
          },
          child: Container(
            height: 110,
            // width: MediaQuery.of(context).size.width / 2.2,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: Color(0x22888888),
            ),
            child: _imageId2 != null
                ? Center(
                    child: Image.file(
                      _imageId2,
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32.0,
                          height: 32.0,
                          child: Icon(
                            Icons.add,
                            color: Colors.black54,
                            size: 25,
                          ),
                          decoration: new BoxDecoration(
                            // color: Colors.grey[300],
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(90.0)),
                            border:
                                new Border.all(color: Colors.grey, width: 1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text("Back",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
