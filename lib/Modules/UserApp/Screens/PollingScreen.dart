import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AddPollingQuestion.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/PollingComponent.dart';

class PollingScreen extends StatefulWidget {
  @override
  _PollingScreenState createState() => _PollingScreenState();
}

class _PollingScreenState extends State<PollingScreen> {
  List pollingDataList = [];
  bool isLoading = false;

  @override
  void initState() {
    _getAllPollings();
  }

  _getAllPollings() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/member/getAllPollingQuestion", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              pollingDataList = responseData.Data;
              isLoading = false;
            });
            print("$pollingDataList");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(
            "Polling",
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: appPrimaryMaterialColor,
        ),
        body: Stack(
          children: [
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          appPrimaryMaterialColor),
                    ),
                  )
                : pollingDataList.length == 0
                    ? Center(
                        child: Text("No Pollings Found"),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 15),
                        shrinkWrap: true,
                        itemCount: pollingDataList.length,
                        itemBuilder: (context, index) {
                          return PollingComponent(
                            index: index + 1,
                            pollingData: pollingDataList[index],
                            getPollingApi: () {
                              _getAllPollings();
                            },
                          );
                        }),
          ],
        ));
  }
}
