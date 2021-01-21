import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';
import 'package:watcher_app_for_user/Shapes/CircleShape.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyTextFormField.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: Stack(fit: StackFit.expand, children: [
              Positioned(
                  bottom: 40,
                  left: 20,
                  child: Text("Sign In", style: fontConstants.bigTitleWhite)),
              Positioned(
                  right: 20,
                  top: 6,
                  child: Opacity(
                      opacity: 0.1, child: CustomPaint(painter: DrawCircle()))),
              Positioned(
                  right: -40,
                  bottom: 25,
                  child: Opacity(
                      opacity: 0.1, child: CustomPaint(painter: DrawCircle()))),
            ]),
          ),
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
                    MyTextFormField(lable: "Mobile No or email"),
                    MyTextFormField(lable: "Password"),
                    MyButton(title: "Sign In", onPressed: () {}),
                    Padding(
                      padding: const EdgeInsets.only(top:25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: (){

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
                                      text: "Sign In",
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
