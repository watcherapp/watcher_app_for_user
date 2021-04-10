import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/UserEmergencyComponent.dart';

class UserEmergencyScreen extends StatefulWidget {
  @override
  _UserEmergencyScreenState createState() => _UserEmergencyScreenState();
}

class _UserEmergencyScreenState extends State<UserEmergencyScreen> {
  bool isSLoading = false;
  List EmergencyList = [];

  @override
  void initState() {
    _getAllUserEmergencyContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Emergency",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: isSLoading == true
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: 5, bottom: 18),
              scrollDirection: Axis.vertical,
              itemCount: EmergencyList.length,
              itemBuilder: (BuildContext context, int index) {
                return UserEmergencyComponent(
                  userEmergencyData: EmergencyList[index],
                );
              }),
    );
  }

  _getAllUserEmergencyContact() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {"societyId": "${sharedPrefs.societyId}"};
        setState(() {
          isSLoading = true;
        });
        Services.responseHandler(
                apiName: "api/admin/getAllEmergencyContacts", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData);
            setState(() {
              EmergencyList = responseData.Data;
              isSLoading = false;
            });
          } else {
            print(responseData);
            setState(() {
              EmergencyList = responseData.Data;
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
