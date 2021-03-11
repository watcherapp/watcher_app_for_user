import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Modules/Authentication/Registration/OTPScreen.dart';

class VerifyScreen extends StatefulWidget {
  var verifyData;
  VerifyScreen({this.verifyData});

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
        children: [
          CircleDesign(title: "Verify Mobile"),
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
                        child: Text("Enter Mobile Number",
                            style: fontConstants.bigTitleBlack),
                      ),
                    ),
                    /* Padding(
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
                    ),*/
                    SizedBox(
                      height: 40,
                    ),
                    MyTextFormField(
                      lable: "Mobile Number",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Mobile Number";
                        }
                        return "";
                      },
                      hintText: "Enter mobile number",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyButton(
                        title: "Next",
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: OTPScreen(
                                    otpData: widget.verifyData,
                                  ),
                                  type: PageTransitionType.rightToLeft));
                        }),
                    SizedBox(
                      height: 35,
                    ),
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
