import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';
import 'package:watcher_app_for_user/Shapes/CircleShape.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/ui/Screens/Admin/AdminDashboard.dart';
import 'package:watcher_app_for_user/ui/Screens/ChooseCreateOrJoin.dart';
import 'package:watcher_app_for_user/ui/Screens/SignUp.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool password = true;
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
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
                        lable: "Mobile No or email",
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please Enter Mobile or email";
                          }
                          return "";
                        },
                        hintText: "Enter mobile or email"),

                    //Passwprd FormField

                    MyTextFormField(
                      lable: "Password",
                      hintText: "Enter Password",
                      isPassword: password,
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
                        onTap: () {},
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
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: ChooseCreateOrJoin(),
                                  type: PageTransitionType.rightToLeft));
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
                                      child: SignUp(),
                                      type: PageTransitionType.bottomToTop));
                            },
                            child: RichText(
                                text: TextSpan(
                                    text: "Don't have an account ? ",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'WorkSans',
                                        fontSize: 16),
                                    children: [
                                  TextSpan(
                                      text: "Sign Up",
                                      style: TextStyle(
                                          color: appPrimaryMaterialColor,
                                          fontFamily: 'WorkSans Bold',
                                          fontSize: 16))
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
    );
  }
}
