import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/MyPropertieComponent.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/ChooseCreateOrJoin.dart';

class MyProperties extends StatefulWidget {
  @override
  _MyPropertiesState createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  bool isLoading = false;
  List myPropertyList = [];

  @override
  void initState() {
    super.initState();
    _getMyProperties();
    _handleSendNotification();
    _updatePlyerId();
  }

  var playerId;

  void _handleSendNotification() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    playerId = status.subscriptionStatus.userId;
    print("playerid--->${playerId}");
    sharedPrefs.playerId = "${playerId}";
  }

  _updatePlyerId() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberId": "${sharedPrefs.memberId}",
          "mobile": "${sharedPrefs.mobileNo}",
          "playerId": playerId,
          "deviceType": Platform.isAndroid ? "Android" : "IOS",
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/member/updateMemberPlayerId", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print("Presponse-->${responseData.Data}");
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
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

  _getMyProperties() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(sharedPrefs.mobileNo);
        var body = {
          "memberId": "${sharedPrefs.memberId}",
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/member/getMemberSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              myPropertyList = responseData.Data;
              print("My Property------>${myPropertyList}");
              isLoading = false;
            });
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
      appBar: AppBar(
        title: Text(
          "My Properties",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation(appPrimaryMaterialColor)))
          : myPropertyList.length > 0
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.only(top: 8, left: 3, right: 3, bottom: 3),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    return MyPropertiesComponent(
                      myPropertyData: myPropertyList[index],
                      memberDataApi: () {
                        _getMyProperties();
                      },
                    );
                  },
                  itemCount: myPropertyList.length,
                )
              : Container(
                  child: Center(
                    child: Text("No Properties Found"),
                  ),
                ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12.0),
        child: SizedBox(
          height: 45,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: ChooseCreateOrJoin(),
                      type: PageTransitionType.rightToLeft));
              // Navigator.pushReplacement(
              //     context,
              //     PageTransition(
              //         child: ChooseCreateOrJoin(),
              //         type: PageTransitionType.rightToLeft));
            },
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: appPrimaryMaterialColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline_rounded,
                  size: 20,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Text(
                    'Create or Join New Society',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
