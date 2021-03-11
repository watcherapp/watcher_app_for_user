import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Modules/Authentication/Forgotpassword/PasswordScreen.dart';

import 'SignUp3.dart';

class OTPScreen extends StatefulWidget {
  var otpData;
  OTPScreen({this.otpData});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
        children: [
          CircleDesign(title: "OTP Verification", backbutton: true),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("Enter Verification Code",
                            style: fontConstants.bigTitleBlack),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "We have sent a verification code on",
                        style: fontConstants.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "+ 9429828152",
                        style: fontConstants.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    PinCodeTextField(
                      //controller: txtOTP,
                      autofocus: false,
                      wrapAlignment: WrapAlignment.center,
                      highlight: true,
                      pinBoxHeight: 42,
                      pinBoxWidth: 42,
                      pinBoxRadius: 8,
                      //pinBoxColor: Colors.grey[200],
                      highlightColor: appPrimaryMaterialColor,
                      defaultBorderColor: appPrimaryMaterialColor[700],
                      hasTextBorderColor: Colors.black,
                      maxLength: 6,
                      pinBoxDecoration:
                          ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      pinTextStyle: TextStyle(fontSize: 17),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyButton(
                        title: "Verify",
                        onPressed: () {
                          if (widget.otpData == true) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: PasswordScreen(),
                                    type: PageTransitionType.rightToLeft));
                          } else {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: SignUp3(),
                                    type: PageTransitionType.rightToLeft));
                          }
                          /*       widget.otpData
                              ? Navigator.push(
                                  context,
                                  PageTransition(
                                      child: PasswordScreen(),
                                      type: PageTransitionType.rightToLeft))
                              : Navigator.push(
                                  context,
                                  PageTransition(
                                      child: SignUp3(),
                                      type: PageTransitionType.rightToLeft));*/
                        }),
                    SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                            context,
                            PageTransition(
                                child: Login(),
                                type: PageTransitionType.bottomToTop));*/
                      },
                      child: Column(
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "If you didn't receive code ? ",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'WorkSans',
                                      fontSize: 16))),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text("Resend",
                                style: TextStyle(
                                    color: appPrimaryMaterialColor,
                                    fontFamily: 'WorkSans Bold',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                          )
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
    );
  }
}
