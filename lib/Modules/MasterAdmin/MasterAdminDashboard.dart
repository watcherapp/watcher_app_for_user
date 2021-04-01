import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Providers/PropertyManagerProvider.dart';
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
  List demoList = [
    {
      "label": " megha 1",
    },
    {
      "label": " megha 2",
    },
    {
      "label": "megha 3",
    },
    {
      "label": "megha 4",
    },
    {
      "label": "megha 5",
    },
    {
      "label": "megha 6",
    },
    {
      "label": "megha 7",
    },
    {
      "label": "megha 8",
    },
    {
      "label": "megha 9",
    },
    {
      "label": "megha 10",
    },
  ];

  @override
  void initState() {
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            SizedBox(height: 10),
            /*   Expanded(
              child: Column(
                  children:
                      demoList.reversed.take(5).map((propertyManagerData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(child: Text(propertyManagerData["label"])),
                    color: Colors.green,
                    height: 30,
                  ),
                );
              }).toList()),
            ),*/
            /* ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                // itemCount: AllmanagerList.length,
                itemCount: demoList.length,
                reverse: true,
                itemBuilder: (context, index) {
                  if (index > 5) {
                    return SizedBox();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(child: Text(demoList[index]["label"])),
                        color: Colors.green,
                        height: 30,
                      ),
                    );
                  }
                }),*/
            /* isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            appPrimaryMaterialColor)))
                : AllmanagerList.length > 0
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                itemCount: AllmanagerList.length,
                        itemBuilder: (context, index) {
                          return PropertyManagetComponent(
                              propertyManagerData: AllmanagerList[index]);
                        })
                    : Center(
                        child: Text(
                          "No Data Found...",
                          style: TextStyle(
                              // fontFamily: 'Montserrat',
                              fontSize: 13,
                              color: Colors.grey),
                        ),
                      ),
*/
            /*Center(
                    child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        appPrimaryMaterialColor),
                  )),*/
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: PropertyManagers(),
                        type: PageTransitionType.rightToLeft));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Text(
                    "See All",
                    style: TextStyle(
                        // fontFamily: 'Montserrat',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
