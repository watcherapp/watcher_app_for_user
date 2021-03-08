import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Modules/Authentication/SignIn.dart';
import 'package:watcher_app_for_user/Registration/OTPScreen.dart';

class SignUp1 extends StatefulWidget {
  @override
  _SignUp1State createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("Enter Your Mobile Number",
                            style: fontConstants.bigTitleBlack),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "We will send the OTP ( One Time Password )",
                        style: fontConstants.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        "to verify a number",
                        style: fontConstants.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyTextFormField(
                        lable: "Mobile No",
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please Enter Mobile or email";
                          }
                          return "";
                        },
                        hintText: "Enter mobile"),
                    SizedBox(
                      height: 20,
                    ),
                    MyButton(
                        title: "Send OTP",
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: OTPScreen(),
                                  type: PageTransitionType.rightToLeft));
                        }),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: SignIn(),
                                    type: PageTransitionType.bottomToTop));
                          },
                          child: RichText(
                              text: TextSpan(
                                  text: "Already have an account ? ",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'WorkSans',
                                      fontSize: 16),
                                  children: [
                                TextSpan(
                                    text: "Sign in",
                                    style: TextStyle(
                                        color: appPrimaryMaterialColor,
                                        fontFamily: 'WorkSans Bold',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16))
                              ])),
                        ),
                      ],
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
