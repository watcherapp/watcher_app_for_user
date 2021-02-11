import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';
import 'package:watcher_app_for_user/ui/Screens/ChooseCreateOrJoin.dart';
import 'package:watcher_app_for_user/ui/Screens/SignIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
        backgroundColor: appPrimaryMaterialColor,
        body: Stack(
          children: [
            Column(
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
                          Text("Welcome Back",
                              style: fontConstants.bigTitleBlack),
                          Text("Sign Up to Continue",
                              style: fontConstants.subTitleText),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 3,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: index == 0
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
                                      color: index == 0
                                          ? Colors.grey
                                          : appPrimaryMaterialColor,
                                      borderRadius: BorderRadius.circular(6.0)),
                                ),
                              )
                            ],
                          ),
                          if (index == 0) ...[
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
                                        hintText: "Enter Mobile Number"),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: SignIn(),
                                                      type: PageTransitionType
                                                          .bottomToTop));
                                            },
                                            child: RichText(
                                                text: TextSpan(
                                                    text:
                                                        "Already have an account ? ",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontFamily: 'WorkSans',
                                                        fontSize: 16),
                                                    children: [
                                                  TextSpan(
                                                      text: "Sign In",
                                                      style: TextStyle(
                                                          color:
                                                              appPrimaryMaterialColor,
                                                          fontFamily:
                                                              'WorkSans Bold',
                                                          fontSize: 16))
                                                ])),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ] else ...[
                            Expanded(
                                child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  MyTextFormField(
                                      lable: "Password",
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
                                  MyButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: ChooseCreateOrJoin(),
                                              type: PageTransitionType
                                                  .rightToLeft));
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
            )
          ],
        ),
        floatingActionButton: keyboardIsOpened
            ? null
            : Stack(
                children: <Widget>[
                  index != 0
                      ? Padding(
                          padding: EdgeInsets.only(left: 31),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: FloatingActionButton(
                                mini: true,
                                onPressed: () {
                                  setState(() {
                                    index = 0;
                                  });
                                },
                                heroTag: null,
                                child: Icon(Icons.arrow_back_ios_rounded)),
                          ),
                        )
                      : SizedBox(),
                  index == 1
                      ? SizedBox()
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                index = 1;
                              });
                            },
                            mini: true,
                            heroTag: null,
                            child: Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ),
                ],
              ));
  }
}
