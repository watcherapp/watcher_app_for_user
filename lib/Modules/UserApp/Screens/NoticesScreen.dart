import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/NoticesComponent.dart';

class NoticesScreen extends StatefulWidget {
  @override
  _NoticesScreenState createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {

  List noticesList=[];

  bool  isSLoading = false;


  @override
  void initState() {
    _getAllSocietyNotice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Notice Board",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body:
      isSLoading==true?
      Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
              appPrimaryMaterialColor),
        ),
      )
          :ListView.builder(
          padding: EdgeInsets.only(bottom: 15),
          shrinkWrap: true,
          itemCount: noticesList.length,
          itemBuilder: (context, index) {
            return NoticesComponent(
              noticeData: noticesList[index],
            );
          }),
    );
  }
  _getAllSocietyNotice() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": "${sharedPrefs.societyId}"
        };
        setState(() {
          isSLoading = true;
        });
        Services.responseHandler(
            apiName: "api/admin/getSocietyNotice", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData);
            setState(() {
              noticesList = responseData.Data;
              isSLoading = false;
            });
          } else {
            print(responseData);
            setState(() {
              noticesList = responseData.Data;
              isSLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isSLoading = false;
          });
          Fluttertoast.showToast(msg: "$error");
        });
      }
    } catch (e) {
      setState(() {
        isSLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }
}
