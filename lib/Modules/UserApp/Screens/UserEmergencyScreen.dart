import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/BottomNavigationBarCustom.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/UserEmergencyComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/AddUserEmergencyScreen.dart';

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
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _getAllUserEmergencyContact();
        },
        color: appPrimaryMaterialColor,
        child: Stack(
          children: [
            isSLoading == true
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
            Positioned(
              bottom: 30,
              right: 10,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: AddUserEmergencyScreen(
                            getAllEmergency: () {
                              _getAllUserEmergencyContact();
                            },
                          ),
                          type: PageTransitionType.rightToLeft));
                  setState(() {});
                },
                icon: Icon(Icons.add),
                label: Text("Add Emergency"),
              ),
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
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
            print(responseData.Data);
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
