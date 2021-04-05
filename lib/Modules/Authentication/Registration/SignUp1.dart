import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/Authentication/Registration/OTPScreen.dart';
import 'package:watcher_app_for_user/Modules/Authentication/SignIn.dart';

class SignUp1 extends StatefulWidget {
  String fromWhere;

  SignUp1({this.fromWhere});

  @override
  _SignUp1State createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController txtMobile = new TextEditingController();
  String dialCode = "+91";
  bool isLoading = false;

  _verifyMember() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "mobileNo1": txtMobile.text,
        };
        print("$body");
        Services.responseHandler(apiName: "api/member/checkMember", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            Fluttertoast.showToast(
              msg: "Phone Number is already exist",
            );
            setState(() {
              isLoading = false;
            });
          } else {
            print(responseData);
            Navigator.push(
              context,
              PageTransition(
                  child: OTPScreen(
                    dialCode: dialCode,
                    mobileNo: txtMobile.text,
                    fromWhere: widget.fromWhere,
                  ),
                  type: PageTransitionType.rightToLeft),
            );
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
            );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
            msg: "Error $error",
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "You aren't connected to the Internet !",
        textColor: appPrimaryMaterialColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Form(
        key: _formKey,
        child: Column(
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: MyTextFormField(
                                controller: txtMobile,
                                lable: "Mobile No",
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter Mobile No";
                                  }
                                  return null;
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: CountryCodePicker(
                                    onChanged: (CountryCode code) {
                                      setState(() {
                                        dialCode = code.dialCode;
                                      });
                                    },
                                    initialSelection: 'IN',
                                    favorite: ['+91', 'IN'],
                                    showCountryOnly: true,
                                    showFlag: true,
                                    showOnlyCountryWhenClosed: false,
                                    alignLeft: false,
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                hintText: "Enter mobile No"),
                          ),
                        ],
                      ),
                      /* MyTextFormField(
                          lable: "Mobile No",
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please Enter Mobile or email";
                            }
                            return "";
                          },
                          icon: CountryCodePicker(
                            // onChanged: _onCountryChange,
                            initialSelection: 'IT',
                            favorite: ['+91', 'IN'],
                            showCountryOnly: false, showFlag: true,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                          hintText: "Enter mobile"),*/
                      SizedBox(
                        height: 20,
                      ),
                      MyButton(
                          title: "Send OTP",
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (widget.fromWhere == "fromForgotPassword") {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: OTPScreen(
                                      dialCode: dialCode,
                                      mobileNo: txtMobile.text,
                                      fromWhere: widget.fromWhere,
                                    ),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              } else {
                                _verifyMember();
                              }
                            }

                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         child: OTPScreen(
                            //           dialCode: dialCode,
                            //           mobileNo: txtMobile.text,
                            //           fromWhere: widget.fromWhere,
                            //         ),
                            //         type: PageTransitionType.rightToLeft));
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
                                        fontSize: 18),
                                    children: [
                                  TextSpan(
                                      text: "Sign in",
                                      style: TextStyle(
                                          color: appPrimaryMaterialColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17))
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
      ),
    );
  }
}
