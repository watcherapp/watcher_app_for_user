import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/Authentication/SignIn.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Components/PropertyManagerComponent.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/CategoryScreen.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/PropertyManagers.dart';

class MasterAdminDashboard extends StatefulWidget {
  @override
  _MasterAdminDashboardState createState() => _MasterAdminDashboardState();
}

class _MasterAdminDashboardState extends State<MasterAdminDashboard> {
  bool isLoading = false;
  List AllmanagerList = [];

  @override
  void initState() {
    super.initState();
    _getAllPropertyManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text("Master Admin", style: TextStyle(fontFamily: 'Montserrat')),
          centerTitle: true,
          elevation: 0,
          backgroundColor: appPrimaryMaterialColor,
          actions: [
            GestureDetector(
              onTap: () {
                sharedPrefs.logout();
                Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                        child: SignIn(), type: PageTransitionType.rightToLeft),
                    (Route<dynamic> route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: Image.asset(
                  "images/logout.png",
                  width: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 6, right: 6),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: PropertyManagers(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/manager.png",
                                width: 34,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Property Manager's",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: CategoryScreen(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/Category.png",
                                width: 32,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Category",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/digital-marketing.png",
                              width: 33,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Advertisement",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Montserrat'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/Payment_setting.png",
                              width: 32,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Payment Setting",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Montserrat'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, left: 10, right: 6, bottom: 10),
                  child: Text(
                    "Recent Requests",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    height: 35,
                    width: 70,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        // backgroundColor: appPrimaryMaterialColor[100],
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: PropertyManagers(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          appPrimaryMaterialColor),
                    ),
                  )
                : AllmanagerList.length > 0
                    ? Expanded(
                        child: ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: AllmanagerList.reversed
                                .take(AllmanagerList.length)
                                .map((propertyManagerData) {
                              return PropertyManagetComponent(
                                  propertyManagerData: propertyManagerData);
                            }).toList()),
                      )
                    : Text(
                        "Data Not Found",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         PageTransition(
            //             child: PropertyManagers(),
            //             type: PageTransitionType.rightToLeft));
            //   },
            //   child: Center(
            //     child: Padding(
            //       padding: const EdgeInsets.only(top: 10.0),
            //       child: Text(
            //         "See All",
            //         style: TextStyle(
            //             // fontFamily: 'Montserrat',
            //             fontSize: 13,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.black),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ));
  }

  _getAllPropertyManager() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {
          "requestStatusCode": 3,
        };
        Services.responseHandler(
                apiName: "api/admin/getListOfRequestPropertyManager",
                body: body)
            .then((responseData) {
          print(responseData.Data.length);
          if (responseData.Data.length > 0) {
            setState(() {
              AllmanagerList = responseData.Data;
              isLoading = false;
            });
            print(responseData.Data);
            print("==============================>${AllmanagerList.length}");
          } else {
            print(responseData);
            setState(() {
              AllmanagerList = responseData.Data;
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "$error");
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }
}
