import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:watcher_app_for_user/CommonWidgets/DialogOpenFormField.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Dialogs/MyDropdown.dart';

class UpdateMemberProfile extends StatefulWidget {
  List profileData;
  Function myProfileFun;

  UpdateMemberProfile({this.profileData, this.myProfileFun});

  @override
  _UpdateMemberProfileState createState() => _UpdateMemberProfileState();
}

class _UpdateMemberProfileState extends State<UpdateMemberProfile> {
  TextEditingController txtFName;
  TextEditingController txtMName = new TextEditingController();
  TextEditingController txtLName;
  TextEditingController txtAlterMoNo = new TextEditingController();
  DateTime txtDob;
  var fromDate = DateFormat('dd / MM / yyyy');
  var fromDate2 = DateFormat('dd/MM/yyyy');

  showToDatePickerG(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget.profileData[0]["dateOfBirth"] == null
            ? DateTime.now()
            : txtDob,
        firstDate: DateTime(1910),
        lastDate: DateTime(2121));

    if (picked != null && picked != txtDob)
      setState(() {
        txtDob = picked;
      });
  }

  String dateData;
  String mydate;

  String funDateI() {
    dateData = "${widget.profileData[0]["dateOfBirth"]}";
    print(dateData);
    var date_date = dateData.split('/');

    mydate = date_date[2] + "-" + date_date[1] + "-" + date_date[0];
    print("I-->${mydate}");
    txtDob = DateTime.parse(mydate);
  }

  bool isLoading = false;
  String img;
  List bloodGroupList = [
    "A+",
    "B+",
    "AB+",
    "O+",
    "A-",
    "B-",
    "AB-",
    "O-",
  ];
  String bloodGroup;
  var today = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    txtFName = new TextEditingController(
        text: "${widget.profileData[0]["firstName"]}");
    txtLName =
        new TextEditingController(text: "${widget.profileData[0]["lastName"]}");
    bloodGroup = "${widget.profileData[0]["bloodGroup"]}";
    if (widget.profileData[0]["dateOfBirth"] != null) {
      funDateI();
    }
    // txtDob = DateTime.parse("${widget.profileData[0]["dateOfBirth"]}");
    // var fromDate3 = DateFormat('yyyy-MM-dd');
    // var date = fromDate3.format(widget.profileData[0]["dateOfBirth"]);
    // txtDob = DateTime.parse("2020-01-02 03:04:05");
  }

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

  void _settingModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15, bottom: 10),
                      child: Text(
                        "Add Photo",
                        style: TextStyle(
                            fontSize: 22,
                            color: appPrimaryMaterialColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getFromCamera();
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 15),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "images/photo.png",
                                color: appPrimaryMaterialColor,
                              )),
                        ),
                        title: Text(
                          "Take Photo",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () {
                        getFromGallery();
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 15),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "images/gallery.png",
                                color: appPrimaryMaterialColor,
                              )),
                        ),
                        title: Text(
                          "Choose from Gallery",
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0, bottom: 5),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 18,
                              color: appPrimaryMaterialColor,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  _updateMemberProfile() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(sharedPrefs.memberId);
        print(txtFName.text);
        print(txtMName.text);
        print(txtLName.text);
        print(txtAlterMoNo.text);

        String filename = "";
        String filePath = "";
        File compressedFile;
        if (_image != null) {
          ImageProperties properties =
              await FlutterNativeImage.getImageProperties(_image.path);

          compressedFile = await FlutterNativeImage.compressImage(
            _image.path,
            quality: 80,
            targetWidth: 600,
            targetHeight: (properties.height * 600 / properties.width).round(),
          );

          filename = _image.path.split('/').last;
          filePath = compressedFile.path;
        }
        FormData formData = FormData.fromMap({
          "memberId": sharedPrefs.memberId,
          "firstName": txtFName.text,
          "middleName": txtMName.text,
          "lastName": txtLName.text,
          "mobileNo2": txtAlterMoNo.text,
          "bloodGroup": bloodGroup,
          "dateOfBirth": fromDate2.format(txtDob),
          "memberImage": (filePath != null && filePath != '')
              ? await MultipartFile.fromFile(filePath,
                  filename: filename.toString())
              : null,
        });
        print("${formData.fields}");

        Services.responseHandler(
                apiName: "api/member/updateMemberDetails", body: formData)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            widget.myProfileFun();
            Fluttertoast.showToast(
              msg: "Your Profile Updated Successfully.",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Update Profile",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _image != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Container(
                          height: 150.0,
                          width: MediaQuery.of(context).size.width / 1,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 0.2, color: appPrimaryMaterialColor),
                            image: DecorationImage(
                              image: FileImage(
                                _image,
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : widget.profileData[0]["memberImage"] == ""
                        ? Image.asset(
                            "images/perso-outline.png",
                            color: Colors.white,
                            width: 160,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Container(
                              height: 150.0,
                              width: MediaQuery.of(context).size.width / 1,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0.2, color: appPrimaryMaterialColor),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    API_URL +
                                        widget.profileData[0]["memberImage"],
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                Padding(
                  padding: const EdgeInsets.only(top: 17.0),
                  child: Divider(
                    height: 0.1,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    _settingModalBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "Choose Image",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            color: appPrimaryMaterialColor,
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: paddingConstant.authScreenContentPadding,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: MyTextFormField(
                      controller: txtFName,
                      lable: "First Name",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter First Name";
                        }
                        return "";
                      },
                      hintText: "Enter first name"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MyTextFormField(
                      controller: txtMName,
                      lable: "middle Name",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Last Name";
                        }
                        return "";
                      },
                      hintText: "Enter last name"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MyTextFormField(
                      controller: txtLName,
                      lable: "Last Name",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Last Name";
                        }
                        return "";
                      },
                      hintText: "Enter last name"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MyTextFormField(
                      controller: txtAlterMoNo,
                      lable: "Alternative Mobile Number",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Alternative Mobile Number";
                        }
                        return "";
                      },
                      hintText: "Enter Alternative Mobile Number"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0, top: 20),
                  child: DialogOpenFormField(
                      lable: "Blood Group",
                      hintLable: "Select Blood Group",
                      value: bloodGroup,
                      onTap: () {
                        // print("click");
                        FocusScope.of(context).unfocus();
                        showDialog(
                          context: context,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: MyDropDown(
                              dropDownTitle: "Blood Group",
                              dropDownData: bloodGroupList,
                              isSearchable: false,
                              onSelectValue: (value) {
                                setState(() {
                                  bloodGroup = value;
                                });
                              },
                              // onSelectValue: ,
                            ),
                          ),
                        );
                      }),
                ),
                // GestureDetector(
                //   onTap: (){
                //     showModalBottomSheet(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //         ),
                //         context: context,
                //         builder: (builder) {
                //           return Padding(
                //             padding: const EdgeInsets.all(10.0),
                //             child: CupertinoDatePicker(
                //               minimumDate: today,
                //               mode: CupertinoDatePickerMode.date,
                //               // initialDateTime: DateTime(1969, 1, 1),
                //               onDateTimeChanged: (DateTime newDateTime) {
                //                 print("dateTime: ${newDateTime}");
                //                 txtDob = newDateTime as TextEditingController;
                //               },
                //             ),
                //           );
                //         });
                //     // Container(
                //     //   height: 200,
                //     //   child:
                //     // );
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 10.0),
                //     child: MyTextFormField(
                //         controller: txtDob,
                //         lable: "Date of Birth",
                //         validator: (val) {
                //           if (val.isEmpty) {
                //             return "Please Enter Date of Birth";
                //           }
                //           return "";
                //         },
                //         hintText: "Enter last name"),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date of Birth",
                        style: fontConstants.formFieldLabel,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            showToDatePickerG(context);
                            // showModalBottomSheet(
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(10.0),
                            //             ),
                            //             context: context,
                            //             builder: (builder) {
                            //               return Padding(
                            //                 padding: const EdgeInsets.all(10.0),
                            //                 child: CupertinoDatePicker(
                            //                   // minimumDate: today,
                            //                   mode: CupertinoDatePickerMode.date,
                            //                   initialDateTime: DateTime(1969, 1, 1),
                            //                   onDateTimeChanged: (DateTime newDateTime) {
                            //                     txtDob = newDateTime;
                            //                     print("dateTime: ${txtDob}");
                            //                   },
                            //                 ),
                            //               );
                            //             });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[200]),
                            height: 48,
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: txtDob != null
                                    ? Text(
                                        fromDate.format(txtDob),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      )
                                    : Text(
                                        "Please Select Your Date of Birth",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )

                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         flex: 1,
                //         child: Column(
                //           children: [
                //             Container(
                //               width: 100,
                //               child: MyTextFormField(
                //                   lable: "Code",
                //                   // validator: (val) {
                //                   //   if (val.isEmpty) {
                //                   //     return "Code";
                //                   //   }
                //                   //   return "";
                //                   // },
                //                   hintText: "Code"),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Expanded(
                //         flex: 2,
                //         child: Padding(
                //           padding: const EdgeInsets.only(left: 4.0),
                //           child: Container(
                //             width: 200,
                //             child: MyTextFormField(
                //                 lable: "Mobile Number",
                //                 // validator: (val) {
                //                 //   if (val.isEmpty) {
                //                 //     return "Please Enter Mobile Number";
                //                 //   }
                //                 //   return "";
                //                 // },
                //                 hintText: "Enter mobile number"),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                //   child: MyTextFormField(
                //     controller: txtEmailAdress,
                //       lable: "Email ( Optional )",
                //       // validator: (val) {
                //       //   if (val.isEmpty) {
                //       //     return "Please Enter Email";
                //       //   }
                //       //   return "";
                //       // },
                //       hintText: "Enter email"),
                // ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12.0),
        child: SizedBox(
          height: 45,
          child: RaisedButton(
            onPressed: () {
              _updateMemberProfile();
            },
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: appPrimaryMaterialColor,
            child: Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ),
    );
  }
}
