import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/ValidationClass.dart';
import 'package:watcher_app_for_user/Modules/Authentication/Forgotpassword/VerifyScreen.dart';
import 'package:watcher_app_for_user/Modules/Authentication/Registration/SignUp1.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/ChooseCreateOrJoin.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/MasterAdminDashboard.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool password = true;
  bool isLoading = false;
  var _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  bool isVerify = true;
  TextEditingController txtEmailOrMobile = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

  @override
  void initState() {}

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
                          validator: (input) {
                            if (isNumeric(input)) {
                            } else {}
                            if (input.isValidEmail())
                              return "";
                            else
                              return "Invalid email address";
                          },
                          hintText: "Enter mobile or email"),

                      //Password FormField

                      MyTextFormField(
                        lable: "Password",
                        hintText: "Enter Password",
                        isPassword: password,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Password can't be empty";
                          }
                          return "";
                        },
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
                                    child: VerifyScreen(),
                                    type: PageTransitionType.rightToLeft));
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: VerifyScreen(
                                        verifyData: isVerify,
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
                            ),
                          )),
                      // Sign In Button
                      MyButton(
                          title: "Sign In",
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              print("email is validate");
                            } else {
                              print("error");
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
                                        child: SignUp1(),
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Session.memberId, sessionData[0]["_id"] ?? "");
    prefs.setString(Session.memberNo, sessionData[0]["memberNo"] ?? "");
    prefs.setString(
        Session.userRole, sessionData[0]["userRole"].toString() ?? "");
    if (sessionData[0]["userRole"] == 0) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: MasterAdminDashboard(),
              type: PageTransitionType.leftToRight));
    } else if (sessionData[0]["userRole"] == 1) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: ChooseCreateOrJoin(),
              type: PageTransitionType.leftToRight));
    } else {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: ChooseCreateOrJoin(),
              type: PageTransitionType.leftToRight));
    }
  }

  _userLogin() async {
    try {
      //LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var key;
        isNumeric(txtEmailOrMobile.text) ? key = "mobileNo1" : key = "email";
        var body = {
          "$key": txtEmailOrMobile.text,
          "password": txtPassword.text,
          "deviceType": Platform.isAndroid ? "android" : "ios",
          "fcmToken": "vgwcvd"
        };
        print("$body");
        // Services.postForSave(apiName: "api/member/memberSignIn", body: body)
        //     .then((responseData) {
        //   if (responseData.Data.length > 0) {
        //     LoadingIndicator.close(context);
        //     _saveDataToSession(responseData.Data);
        //   } else {
        //     print(responseData);
        //     LoadingIndicator.close(context);
        //     scaffoldKey.currentState.showSnackBar(SnackBar(
        //         behavior: SnackBarBehavior.floating,
        //         backgroundColor: Colors.red,
        //         content: Text("${responseData.Message}")));
        //   }
        // }).catchError((error) {
        //   LoadingIndicator.close(context);
        //   scaffoldKey.currentState.showSnackBar(SnackBar(
        //       behavior: SnackBarBehavior.floating,
        //       backgroundColor: Colors.red,
        //       content: Text("Error $error")));
        // });
      }
    } catch (e) {
      LoadingIndicator.close(context);
      scaffoldKey.currentState.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text("You aren't connected to the Internet !")));
    }
  }
}
