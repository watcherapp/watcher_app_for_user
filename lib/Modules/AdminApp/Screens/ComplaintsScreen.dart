import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/ValidationClass.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/ComplainComponent.dart';

class ComplaintsScreen extends StatefulWidget {
  @override
  _ComplaintsScreenState createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  List dateSortList = [
    {"icon": "", "date": ""},
    {"icon": "", "date": ""},
    {"icon": "", "date": ""},
    {"icon": "", "date": ""},
  ];
  List<Widget> tabs = [
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("A"),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("B"),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("C"),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("D"),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("E"),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("F"),
        ),
      ),
    ),
  ];
  bool isLoading = false;
  List getAllComplaintList = [];

  @override
  void initState() {
    _getAllComplains();
  }

  _getAllComplains() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": societyId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/admin/getAllSocietyComplain", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            getAllComplaintList = responseData.Data;
            setState(() {
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
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text(
              "Complaints",
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      context: context,
                      builder: (builder) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: BottomSheet(),
                        );
                      });
                },
              ),
            ],
            centerTitle: true,
            elevation: 0,
            backgroundColor: appPrimaryMaterialColor,
          ),
          body: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                  // backgroundColor: Colors.red,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      appPrimaryMaterialColor),
                ))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 4, right: 4),
                      child: Container(
                        height: 35,
                        child: TabBar(
                            controller: _tabController,
                            labelPadding:
                                EdgeInsets.only(left: 9.0, right: 9.0),
                            // indicatorSize: TabBarIndicatorSize.label,
                            unselectedLabelColor: Colors.grey[600],
                            labelColor: Colors.white,
                            isScrollable: true,
                            indicatorColor: appPrimaryMaterialColor,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: appPrimaryMaterialColor),
                            onTap: (index) {},
                            tabs: tabs),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            ListView.builder(
                                padding: EdgeInsets.only(top: 5, bottom: 18),
                                scrollDirection: Axis.vertical,
                                itemCount: getAllComplaintList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ComplainComponent(
                                    getAllComplain: getAllComplaintList[index],
                                    getComplaindApi: () {
                                      _getAllComplains();
                                    },
                                  );
                                }),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                          ]),
                    ),
                  ],
                )),
    );
  }
}

class BottomSheet extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      color: Colors.transparent,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 90,
                ),
                Text(
                  "Filter by Date",
                  style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.date_range,
                        color: appPrimaryMaterialColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today",
                            style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Aug 26",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.date_range,
                        color: appPrimaryMaterialColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Yesterday",
                            style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Aug 25",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.date_range,
                        color: appPrimaryMaterialColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last Week",
                            style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Aug 19-25",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.date_range,
                        color: appPrimaryMaterialColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last Month",
                            style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "July 1-31",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            // Container(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Icon(
            //           Icons.date_range,
            //           color: appPrimaryMaterialColor,
            //         ),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               "Custom Range",
            //               style: TextStyle(
            //                 color: appPrimaryMaterialColor,
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //             SizedBox(
            //               height: 5,
            //             ),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
