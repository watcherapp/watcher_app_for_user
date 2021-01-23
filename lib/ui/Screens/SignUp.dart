import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
        children: [
          CircleDesign(title: "Sign Up", backbutton: true),
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
                    Text("Sign Up to Continue",
                        style: fontConstants.subTitleText),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
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
                                lable: "Last Name",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter Last Name";
                                  }
                                  return "";
                                },
                                hintText: "Enter last name"),
                            MyTextFormField(
                                lable: "email (optional)",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter Last Name";
                                  }
                                  return "";
                                },
                                hintText: "Enter email"),
                            MyTextFormField(
                                lable: "Mobile Number",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter Last Name";
                                  }
                                  return "";
                                },
                                hintText: "Enter Mobile Number")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appPrimaryMaterialColor,
        onPressed: () {},
        child: Icon(Icons.arrow_forward_ios_rounded),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
