import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/ClassList/Gender.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/ChooseCreateOrJoin.dart';

class SignUp3 extends StatefulWidget {
  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  int selectedIndex = 0;
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtMiddleName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  List<Gender> genderList = [
    Gender(icon: "images/male.png", name: "Male", isSelected: false),
    Gender(icon: "images/female.png", name: "Female", isSelected: false),
    Gender(icon: "images/other.png", name: "Other", isSelected: false),
  ];
  String selectedGender = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      genderList.forEach((gender) => gender.isSelected = false);
      genderList[0].isSelected = true;
      selectedGender = genderList[0].name;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appPrimaryMaterialColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleDesign(title: "Create account", backbutton: true),
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: paddingConstant.authScreenContentPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${selectedIndex > 1 ? "Create Password" : "Tell us more about you !"}",
                          style: fontConstants.bigTitleBlack),
                      Text("Sign Up to Continue",
                          style: fontConstants.subTitleText),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 3,
                            width: 30,
                            decoration: BoxDecoration(
                                color: selectedIndex == 0
                                    ? appPrimaryMaterialColor
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 3,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: selectedIndex == 1
                                      ? appPrimaryMaterialColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(6.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 3,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: selectedIndex == 2
                                      ? appPrimaryMaterialColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(6.0)),
                            ),
                          )
                        ],
                      ),
                      if (selectedIndex == 0) ...[
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                MyTextFormField(
                                    lable: "First Name",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter First Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter first name"),
                                MyTextFormField(
                                    lable: "Middle Name",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Middle Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter middle name"),
                                MyTextFormField(
                                    lable: "Last Name",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Last Name";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter last name"),
                                MyTextFormField(
                                    lable: "Email",
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please Enter Email";
                                      }
                                      return "";
                                    },
                                    hintText: "Enter email"),
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, bottom: 4.0),
                                  child: Text("Gender",
                                      style: fontConstants.formFieldLabel),
                                ),
                                Row(
                                  children: genderList.map((value) {
                                    int index = genderList.indexOf(value);
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: SizedBox(
                                        width: 90,
                                        child: OutlinedButton(
                                            style: ButtonStyle(),
                                            onPressed: () {
                                              setState(() {
                                                genderList.forEach((gender) =>
                                                    gender.isSelected = false);
                                                genderList[index].isSelected =
                                                    true;
                                                selectedGender =
                                                    genderList[index].name;
                                              });
                                              print(selectedGender);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    genderList[index].icon,
                                                    color: genderList[index]
                                                            .isSelected
                                                        ? appPrimaryMaterialColor
                                                        : Colors.grey,
                                                    width: 18,
                                                  ),
                                                  Text(genderList[index].name,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: genderList[
                                                                      index]
                                                                  .isSelected
                                                              ? appPrimaryMaterialColor
                                                              : Colors.grey)),
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  }).toList(),
                                )

                                /* MyButton(
                                    title: "Next",
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: SignUp3(),
                                              type: PageTransitionType
                                                  .bottomToTop));
                                    }),*/
                              ],
                            ),
                          ),
                        )
                      ] else if (selectedIndex == 1) ...[
                        Expanded(
                            child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              Container(
                                width: 130.0,
                                height: 130.0,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 110,
                                ),
                                decoration: new BoxDecoration(
                                  color: Color(0x22888888),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(90.0)),
                                  border: new Border.all(
                                    color: appPrimaryMaterialColor[700],
                                    width: 3,
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                              Text("Click or Select Profile Photo",
                                  style: fontConstants.smallText),
                              SizedBox(height: 40),
                              containerdash,
                              SizedBox(height: 24),
                              Text("Select Identity Proof",
                                  style: fontConstants.smallText),
                            ],
                          ),
                        ))
                      ] else ...[
                        Expanded(
                            child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              MyTextFormField(
                                  lable: "Create Password",
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Please Enter Password";
                                    }
                                    return "";
                                  },
                                  hintText: "Enter Password"),
                              MyTextFormField(
                                  lable: "Confirm Password",
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Pasword does not match";
                                    }
                                    return "";
                                  },
                                  hintText: "Re-enter Password"),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.lock,
                                      size: 13,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      "  Password must contain :",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "○ at least 8 characters",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black87),
                                  ),
                                  Text(
                                    "○ at least 1 symbol like ( ! , \$ , # , & )",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black87),
                                  ),
                                  Text(
                                    "○ both uppercase and lowercase",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              MyButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageTransition(
                                          child: ChooseCreateOrJoin(),
                                          type: PageTransitionType.rightToLeft),
                                      (route) => false);
                                },
                                title: "Sign Up",
                              )
                            ],
                          ),
                        ))
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: keyboardIsOpened
            ? null
            : Stack(
                children: <Widget>[
                  selectedIndex == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                    },
                                    heroTag: null,
                                    child: Icon(Icons.arrow_back_ios_rounded)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 2;
                                      });
                                    },
                                    heroTag: null,
                                    child:
                                        Icon(Icons.arrow_forward_ios_rounded)),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  selectedIndex == 0
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: appPrimaryMaterialColor,
                            onPressed: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            mini: true,
                            heroTag: null,
                            child: Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        )
                      : SizedBox(),
                  selectedIndex == 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 1;
                                      });
                                    },
                                    heroTag: null,
                                    child: Icon(Icons.arrow_back_ios_rounded)),
                              ),
                            ),
                            /*Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                    },
                                    heroTag: null,
                                    child:
                                        Icon(Icons.arrow_forward_ios_rounded)),
                              ),
                            ),*/
                          ],
                        )
                      : SizedBox(),
                ],
              ));
  }

  Widget get containerdash {
    return Center(
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [5, 5, 5, 5],
        color: Colors.grey[400],
        child: Container(
          height: 129,
          width: 220,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Color(0x22888888),
          ),
          child: Center(
            child: Container(
              width: 80.0,
              height: 80.0,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 70,
              ),
              decoration: new BoxDecoration(
                color: Colors.grey[300],
                borderRadius: new BorderRadius.all(new Radius.circular(90.0)),
                border: new Border.all(color: Colors.grey[300], width: 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _saveDataToSession(var sessionData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Session.memberId, sessionData[0]["_id"] ?? "");
    prefs.setString(Session.memberNo, sessionData[0]["memberNo"] ?? "");
    prefs.setString(
        Session.userRole, sessionData[0]["userRole"].toString() ?? "");
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: ChooseCreateOrJoin(), type: PageTransitionType.leftToRight));
  }

  _userSignUp() async {
    try {
      LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = FormData.fromMap({
          "firstName": txtFirstName.text,
          "lastName": txtLastName.text,
          "mobileNo1": "1234567890",
          "emailId": txtEmail.text,
          "password": txtPassword.text,
          "userRole": "",
          "fcmToken": "d5dff5d5d5s5d",
          "refferBy": "",
          "deviceType": Platform.isAndroid ? "android" : "ios",
          "gender": selectedGender,
          "identityProof": "6038e235eecaca08c8744d57"
        });
        Services.responseHandler(apiName: "api/member/memberSignIn", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            LoadingIndicator.close(context);
            _saveDataToSession(responseData.Data);
          } else {
            print(responseData);
            LoadingIndicator.close(context);
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          LoadingIndicator.close(context);
          Fluttertoast.showToast(msg: "$error");
        });
      }
    } catch (e) {
      LoadingIndicator.close(context);
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }
}
