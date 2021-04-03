import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/Authentication/SignIn.dart';
import 'package:watcher_app_for_user/Modules/UserApp/UserDashboard.dart';

class PasswordScreen extends StatefulWidget {
  String phoneNumber;

  PasswordScreen({
    this.phoneNumber,
  });

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController txtCreatePass = TextEditingController();
  TextEditingController txtConfirmPass = TextEditingController();
  bool isLoading = false;

  _setForgotPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "mobileNo1": widget.phoneNumber,
          "password": txtCreatePass.text,
        };
        print("$body");
        Services.responseHandler(
            apiName: "api/member/forgetPassword", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "Your Password changed Successfully",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
            Navigator.push(
              context,
              PageTransition(
                  child: SignIn(),
                  type: PageTransitionType.rightToLeft),
                  // (route) => false,
            );
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

  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8}$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Password can't be empty";
    } else if (!regExp.hasMatch(value)) {
      return "Password must contain";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
        children: [
          CircleDesign(title: "Change Password"),
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
                    SizedBox(
                      height: 15,
                    ),
                    MyTextFormField(
                        controller: txtCreatePass,
                        lable: "Create Password",
                        validator: validatePassword,
                        hintText: "Enter Password"),
                    MyTextFormField(
                        controller: txtConfirmPass,
                        lable: "Confirm Password",
                        validator: (val) {
                          if (txtCreatePass.text != val) {
                            return "Pasword does not match";
                          }
                          return null;
                        },
                        hintText: "Re-enter Password"),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),
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
                            style:
                            TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "○ at least 8 characters",
                          style: TextStyle(fontSize: 11, color: Colors.black87),
                        ),
                        Text(
                          "○ at least 1 symbol like ( ! , \$ , # , & )",
                          style: TextStyle(fontSize: 11, color: Colors.black87),
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
                        _setForgotPassword();
                      },
                      title: "Change Password",
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
