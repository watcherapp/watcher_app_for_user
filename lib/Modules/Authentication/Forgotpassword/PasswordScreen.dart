import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Modules/UserApp/UserDashboard.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryMaterialColor,
      body: Column(
        children: [
          CircleDesign(title: "Change Password"),
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
                    SizedBox(
                      height: 15,
                    ),
                    MyTextFormField(
                        lable: "Create Password",
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
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock,
                            size: 13,
                            color: Colors.grey,
                          ),
                          Text(
                            "  Password must contain :",
                            style:
                                TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "○ at least 8 characters",
                          style: TextStyle(fontSize: 11, color: Colors.black87),
                        ),
                        Text(
                          "○ at least 1 symbol like ( ! , \$ , # , & )",
                          style: TextStyle(fontSize: 11, color: Colors.black87),
                        ),
                        Text(
                          "○ both uppercase and lowercase",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    MyButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: UserDashboard(),
                              type: PageTransitionType.rightToLeft),
                        );
                      },
                      title: "Change Password",
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
