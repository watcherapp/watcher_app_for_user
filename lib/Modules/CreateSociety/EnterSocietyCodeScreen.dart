import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/SelectWingAndFlat.dart';

class EnterSocietyCode extends StatefulWidget {
  @override
  _EnterSocietyCodeState createState() => _EnterSocietyCodeState();
}

class _EnterSocietyCodeState extends State<EnterSocietyCode> {
  TextEditingController txtSocietyCode;
  String societyId;

  GlobalKey<FormState> _formKey = GlobalKey();

  // getSocietyId() async {
  //   try {
  //     LoadingIndicator.show(context);
  //     final internetResult = await InternetAddress.lookup('google.com');
  //     if (internetResult.isNotEmpty &&
  //         internetResult[0].rawAddress.isNotEmpty) {
  //       var body = {
  //         "societyCode": txtSocietyCode.text,
  //       };
  //       print("$body");
  //       Services.responseHandler(apiName: "api/society/getSociety", body: body)
  //           .then((responseData) {
  //         if (responseData.Data.length > 0) {
  //           LoadingIndicator.close(context);
  //           setState(() {
  //             societyId = responseData.Data[0]["_id"];
  //           });
  //           Navigator.push(
  //               context,
  //               PageTransition(
  //                   child: EnterSocietyCode(),
  //                   type: PageTransitionType.rightToLeft));
  //         } else {
  //           print(responseData);
  //           LoadingIndicator.close(context);
  //           Fluttertoast.showToast(msg: "${responseData.Message}");
  //         }
  //       }).catchError((error) {
  //         LoadingIndicator.close(context);
  //         Fluttertoast.showToast(msg: "$error");
  //       });
  //     }
  //   } catch (e) {
  //     LoadingIndicator.close(context);
  //     Fluttertoast.showToast(msg: "$e");
  //   }
  // }

  _checkSocietyCode() async {
    try {
      LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyCode": txtSocietyCode.text,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/member/checkSocietyCode", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print("s");
            setState(() {
              print("ss");
              print(responseData.Data);
            });
            print("-->${responseData.Data[0]["isApprove"]}");
            LoadingIndicator.close(context);
            print("sss");
            if (responseData.Data[0]["isApprove"] == true) {
              print("ssss");
              Navigator.push(
                context,
                PageTransition(
                  child: SelectWingAndFlat(
                    SocietyCode: txtSocietyCode.text,
                  ),
                  type: PageTransitionType.rightToLeft,
                ),
              );
              // LoadingIndicator.close(context);
            } else {
              Fluttertoast.showToast(
                gravity: ToastGravity.TOP,
                textColor: Colors.white,
               backgroundColor: Color(0xFFFF4F4F),
                msg:
                    "Your Society is not Approve Yet.please contact Society Admin",
              );
            }
          } else {
            print(responseData);
            LoadingIndicator.close(context);
            Fluttertoast.showToast(
              gravity: ToastGravity.TOP,
              textColor: Colors.white,
              backgroundColor: Color(0xFFFF4F4F),
              msg:
              "${responseData.Message}",
            );
            // Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          LoadingIndicator.close(context);
          Fluttertoast.showToast(msg: "$error");
        });
      }
    } catch (e) {
      LoadingIndicator.close(context);
      Fluttertoast.showToast(msg: "$e");
    }
  }


  @override
  void initState() {
    txtSocietyCode = new TextEditingController(
        text: "SOC-");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Society"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextFormField(
                  controller: txtSocietyCode,
                  lable: "Society Code",
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Society Code";
                    } else {
                      return null;
                    }
                  },
                  hintText: "Enter Society Code",
                ),
                MyButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _checkSocietyCode();
                    }
                  },
                  title: "Join",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
