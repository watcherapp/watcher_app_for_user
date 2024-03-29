import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Data/ValidationClass.dart';
import 'package:watcher_app_for_user/Modules/Authentication/Registration/SignUp1.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/MyProperties.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/MasterAdminDashboard.dart';

class SignIn extends StatefulWidget {
  var playerId;

  SignIn({
    this.playerId,
  });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool password = true;
  bool isLoading = false;
  String fromWhere = "fromForgotPassword";
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  bool isVerify = true;
  TextEditingController txtEmailOrMobile = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CircleDesign(title: "Sign In"),
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
                      Text("Welcome Back", style: fontConstants.bigTitleBlack),
                      Text("Sign In to Continue",
                          style: fontConstants.subTitleText),
                      SizedBox(
                        height: 20,
                      ),
                      // Email or Mobile Number
                      MyTextFormField(
                        controller: txtEmailOrMobile,
                        lable: "Mobile No or email",
                        validator: validateEmail,
                        hintText: "Enter mobile or email",
                      ),
                      //Password FormField
                      MyTextFormField(
                        controller: txtPassword,
                        lable: "Password",
                        hintText: "Enter Password",
                        isPassword: password,
                        validator: validatePassword,
                        maxLines: 1,
                        hideShowText: InkWell(
                          onTap: () {
                            setState(() {
                              password = !password;
                            });
                          },
                          child: Text("${!password ? "Hide" : "Show"}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: appPrimaryMaterialColor)),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: SignUp1(
                                      fromWhere: fromWhere,
                                      playerId: widget.playerId,
                                    ),
                                    type: PageTransitionType.rightToLeft));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Forgot Password ?"),
                              ],
                            ),
                          )),
                      // Sign In Button
                      MyButton(
                          title: "Sign In",
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _userLogin();
                            }
                            //_userLogin();
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: SignUp1(
                                          playerId: widget.playerId,
                                        ),
                                        type: PageTransitionType.rightToLeft));
                              },
                              child: RichText(
                                  text: TextSpan(
                                      text: "Don't have an account ? ",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: 'Montserrat',
                                          fontSize: 16),
                                      children: [
                                    TextSpan(
                                        text: "Sign Up",
                                        style: TextStyle(
                                            color: appPrimaryMaterialColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            fontSize: 17))
                                  ])),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveDataToSession(var sessionData) async {
    sharedPrefs.memberId = "${sessionData[0]["_id"]}";
    sharedPrefs.userRole = "${sessionData[0]["userRole"]}";
    sharedPrefs.memberNo = "${sessionData[0]["memberNo"]}";
    sharedPrefs.mobileNo = "${sessionData[0]["mobileNo1"]}";
    if (sessionData[0]["mobileNo1"] == "9876543210") {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: MasterAdminDashboard(),
              type: PageTransitionType.leftToRight));
    }
    //smit.................................

    // else if (sessionData[0]["society"][0]["userRole"] == 0) {
    //   print("---->${sessionData[0]["society"][0]["userRole"]}");
    //   Navigator.pushReplacement(
    //       context,
    //       PageTransition(
    //           child: MasterAdminDashboard(),
    //           type: PageTransitionType.leftToRight));
    // } else if (sessionData[0]["society"][0]["userRole"] == 1) {
    //   print("---->${sessionData[0]["society"][0]["userRole"]}");
    //   Navigator.pushReplacement(
    //       context,
    //       PageTransition(
    //           child: MyProperties(), type: PageTransitionType.leftToRight));
    // }

    //..........................................
    else {
      // print("---->${sessionData[0]["society"][0]["userRole"]}");
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: MyProperties(), type: PageTransitionType.leftToRight));
    }
  }

  _userLogin() async {
    try {
      LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var key;
        isNumeric(txtEmailOrMobile.text) ? key = "mobileNo1" : key = "emailId";
        var body = {
          "$key": txtEmailOrMobile.text,
          "password": txtPassword.text,
          "deviceType": Platform.isAndroid ? "Android" : "IOS",
          "playerId": "${widget.playerId}"
        };
        print("$body");
        Services.responseHandler(apiName: "api/member/memberSignIn", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print("---------------->${responseData.Data}");
            LoadingIndicator.close(context);
            _saveDataToSession(responseData.Data);
          } else {
            print(responseData);
            print("s");
            LoadingIndicator.close(context);
            Fluttertoast.showToast(
              gravity: ToastGravity.TOP,
              textColor: Colors.white,
              backgroundColor: Color(0xFFFF4F4F),
              msg: "${responseData.Message}",
            );
            // Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          print("ss");
          LoadingIndicator.close(context);
          Fluttertoast.showToast(msg: "$error");
        });
      }
    } catch (e) {
      print("sss");
      LoadingIndicator.close(context);
      Fluttertoast.showToast(msg: "$e");
    }
  }
}
