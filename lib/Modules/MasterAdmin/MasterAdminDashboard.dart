import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
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
          title: Text("Admin", style: TextStyle(fontFamily: 'Montserrat')),
          centerTitle: true,
          elevation: 0,
          backgroundColor: appPrimaryMaterialColor,
        ),
        body: Column(
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
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10, right: 6),
              child: Text(
                "Recent Requests",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView(
                  children: AllmanagerList.reversed
                      .take(5)
                      .map((propertyManagerData) {
                return PropertyManagetComponent(
                    propertyManagerData: propertyManagerData);
              }).toList()),
            ),
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
          if (responseData.Data.length > 0) {
            setState(() {
              AllmanagerList = responseData.Data;
              isLoading = false;
            });
            print(responseData.Data);
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
          Fluttertoast.showToast(msg: "${error}");
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
