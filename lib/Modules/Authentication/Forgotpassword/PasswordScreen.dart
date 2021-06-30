import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/Authentication/SignIn.dart';
import 'package:watcher_app_for_user/Modules/UserApp/UserDashboard.dart';

class PasswordScreen extends StatefulWidget {
  String phoneNumber;

  PasswordScreen({
    this.phoneNumber,
  });

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController txtCreatePass = TextEditingController();
  TextEditingController txtConfirmPass = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> _passwordDetail = GlobalKey();
  bool password = true;
  bool password2 = true;
  bool _passwordLength = false;
  bool _passwordNumberSymbol = false;
  bool _passwordUpperLower = false;

  _setForgotPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "mobileNo1": widget.phoneNumber,
          "password": txtCreatePass.text,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/member/forgetPassword", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "Your Password changed Successfully",
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity: ToastGravity.TOP,
            );
            Navigator.push(
              context,
              PageTransition(
                  child: SignIn(), type: PageTransitionType.rightToLeft),
              // (route) => false,
            );
          } else {
            print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
            msg: "Error $error",
            backgroundColor: Colors.white,
            textColor: appPrimaryMaterialColor,
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "You aren't connected to the Internet !",
        backgroundColor: Colors.white,
        textColor: appPrimaryMaterialColor,
      );
    }
  }

  // String validatePassword(String value) {
  //   Pattern pattern =
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8}$';
  //   RegExp regExp = new RegExp(pattern);
  //   if (value.isEmpty) {
  //     return "Password can't be empty";
  //   } else if (!regExp.hasMatch(value)) {
  //     return "Password must contain";
  //   } else {
  //     return null;
  //   }
  // }

  checkPassword() {
    var create_pass = txtCreatePass.text;
    var confirm_pass = txtConfirmPass.text;

    if (create_pass == '' && create_pass.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter your password.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFFFF4F4F),
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isLoading = true;
        _passwordLength = false;
        _passwordNumberSymbol = false;
        _passwordUpperLower = false;
      });
    } else if (confirm_pass == '' && confirm_pass.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter confirm password.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFFFF4F4F),
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isLoading = true;
      });
    } else if (create_pass != confirm_pass) {
      Fluttertoast.showToast(
          msg: "Password not matched.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFFFF4F4F),
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        isLoading = true;
      });
    } else {
      String pattern =
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

      RegExp regExp = new RegExp(pattern);
      var pwd_match = regExp.hasMatch(create_pass);

      if (pwd_match == false) {
        Fluttertoast.showToast(
            msg: "Password does not match with the requirement.",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color(0xFFFF4F4F),
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG);

        setState(() {
          isLoading = true;
        });
      } else {
        _setForgotPassword();
      }
    }
  }

  containPassword() {
    var create_pass = txtCreatePass.text;

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String lower_upper = r'^(?=.*?[A-Z])(?=.*?[a-z])';
    String number_symbol = r'^(?=.*?[0-9])(?=.*?[!@#\$&*~])';

    RegExp regExp = new RegExp(pattern);
    var pwd_match = regExp.hasMatch(create_pass);

    RegExp regExp_LU = new RegExp(lower_upper);
    var pwd_matchLU = regExp_LU.hasMatch(create_pass);

    RegExp regExp_SN = new RegExp(number_symbol);
    var pwd_matchSN = regExp_SN.hasMatch(create_pass);

    if (create_pass == '' && create_pass.isEmpty) {
      setState(() {
        _passwordUpperLower = false;
        _passwordNumberSymbol = false;
        _passwordLength = false;
      });
    }

    if (pwd_matchLU == false) {
      print("not lower upper");
      setState(() {
        _passwordUpperLower = false;
      });
    } else {
      print("lower upper");
      setState(() {
        _passwordUpperLower = true;
      });
    }
    if (pwd_matchSN == false) {
      print("not symbol number");
      setState(() {
        _passwordNumberSymbol = false;
      });
    } else {
      print("symbol number");
      setState(() {
        _passwordNumberSymbol = true;
      });
    }
    if (create_pass.length < 8) {
      print("not length");
      setState(() {
        _passwordLength = false;
      });
    } else {
      print("Lenght");
      setState(() {
        _passwordLength = true;
      });
    }
  }

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
                child: Form(
                  key: _passwordDetail,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      MyTextFormField(
                        controller: txtCreatePass,
                        lable: "Create Password",
                        // validator: validatePassword,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
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
                        onChanged: (String val) {
                          // if(val.length==10){
                          //}
                          containPassword();
                        },
                      ),
                      MyTextFormField(
                          controller: txtConfirmPass,
                          lable: "Confirm Password",
                          isPassword: password2,
                          hideShowText: InkWell(
                            onTap: () {
                              setState(() {
                                password2 = !password2;
                              });
                            },
                            child: Text("${!password2 ? "Hide" : "Show"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: appPrimaryMaterialColor)),
                          ),
                          validator: (val) {
                            if (txtCreatePass.text != val) {
                              return "Pasword does not match";
                            }
                            return null;
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
                              style: TextStyle(
                                  fontSize: 11, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "○ at least 8 characters",
                      //       style: TextStyle(
                      //           fontSize: 11, color: Colors.black87),
                      //     ),
                      //     Text(
                      //       "○ at least 1 symbol like ( ! , \$ , # , & )",
                      //       style: TextStyle(
                      //           fontSize: 11, color: Colors.black87),
                      //     ),
                      //     Text(
                      //       "○ both uppercase and lowercase",
                      //       style: TextStyle(
                      //         fontSize: 11,
                      //         color: Colors.black87,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*Text(
                                        "○ at least 8 characters",
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.black87),
                                      ),*/
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black87),
                              children: [
                                _passwordLength == false
                                    ? WidgetSpan(
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          size: 15,
                                          color: Colors.red,
                                        ),
                                      )
                                    : WidgetSpan(
                                        child: Icon(
                                          Icons.verified_outlined,
                                          size: 15,
                                          color: Colors.green,
                                        ),
                                      ),
                                TextSpan(
                                  text: " at least 8 characters",
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black87),
                              children: [
                                _passwordNumberSymbol == false
                                    ? WidgetSpan(
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          size: 15,
                                          color: Colors.red,
                                        ),
                                      )
                                    : WidgetSpan(
                                        child: Icon(
                                          Icons.verified_outlined,
                                          size: 15,
                                          color: Colors.green,
                                        ),
                                      ),
                                TextSpan(
                                  text:
                                      " at least 1 number and 1 symbol like ( ! , \$ , # , & , @)",
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black87),
                              children: [
                                _passwordUpperLower == false
                                    ? WidgetSpan(
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          size: 15,
                                          color: Colors.red,
                                        ),
                                      )
                                    : WidgetSpan(
                                        child: Icon(
                                          Icons.verified_outlined,
                                          size: 15,
                                          color: Colors.green,
                                        ),
                                      ),
                                TextSpan(
                                  text: " both uppercase and lowercase",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MyButton(
                        onPressed: () {
                          if (_passwordDetail.currentState.validate()) {
                            print("smiy");
                            checkPassword();
                            // _userSignUp();
                          }
                        },
                        title: "Change Password",
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
