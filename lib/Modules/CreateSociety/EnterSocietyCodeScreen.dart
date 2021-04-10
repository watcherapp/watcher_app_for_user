import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'file:///C:/Users/SMIT%20VAGHANI/AndroidStudioProjects/watcher_app_for_user/lib/Modules/CreateSociety/SelectWingAndFlat.dart';

class EnterSocietyCode extends StatefulWidget {
  @override
  _EnterSocietyCodeState createState() => _EnterSocietyCodeState();
}

class _EnterSocietyCodeState extends State<EnterSocietyCode> {
  TextEditingController txtSocietyCode = new TextEditingController();
  String societyId = "";

  getSocietyId() async {
    try {
      LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyCode": txtSocietyCode.text,
        };
        print("$body");
        Services.responseHandler(apiName: "api/society/getSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            LoadingIndicator.close(context);
            setState(() {
              societyId = responseData.Data[0]["_id"];
            });
            Navigator.push(
                context,
                PageTransition(
                    child: EnterSocietyCode(),
                    type: PageTransitionType.rightToLeft));
          } else {
            print(responseData);
            LoadingIndicator.close(context);
            Fluttertoast.showToast(msg: "${responseData.Message}");
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Society"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  Navigator.push(
                      context,
                      PageTransition(
                          child: SelectWingAndFlat(
                            SocietyCode: txtSocietyCode.text,
                          ),
                          type: PageTransitionType.rightToLeft));
                },
                title: "Join",
              )
            ],
          ),
        ),
      ),
    );
  }
}
