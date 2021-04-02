import 'package:firebase_auth/firebase_auth.dart';
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
  var mobileNo;
  var dialCode;
  OTPScreen({this.otpData, this.mobileNo, this.dialCode});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _verificationCode;
  TextEditingController _txtOTP = TextEditingController();

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+917359571489',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print("Login Successfully");
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

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
                        "${widget.dialCode}" + "9429828152",
                        style: fontConstants.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    PinCodeTextField(
                      controller: _txtOTP,
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
                        _verifyPhone();
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
