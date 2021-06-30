import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Data/ValidationClass.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/BottomNavigationBarCustomForAdmin.dart';
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
  DateTime toDate = DateTime.now();
  var dateFormate = DateFormat('yMMMMd');
  var dateFormate2 = DateFormat('MMMMd');
  var dateFormateD = DateFormat('dd/MM/yyyy');

  DateTime yesterDayDate = DateTime.now().subtract(Duration(days: 1));
  DateTime weekDate = DateTime.now().subtract(Duration(days: 7));
  DateTime monthDate = DateTime.now().subtract(Duration(days: 30));

  // List<Widget> tabs = [
  //   Tab(
  //     child: Container(
  //       width: 70,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: appPrimaryMaterialColor, width: 1)),
  //       child: Align(
  //         alignment: Alignment.center,
  //         child: Text("A"),
  //       ),
  //     ),
  //   ),
  //   Tab(
  //     child: Container(
  //       width: 70,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: appPrimaryMaterialColor, width: 1)),
  //       child: Align(
  //         alignment: Alignment.center,
  //         child: Text("B"),
  //       ),
  //     ),
  //   ),
  //   Tab(
  //     child: Container(
  //       width: 70,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: appPrimaryMaterialColor, width: 1)),
  //       child: Align(
  //         alignment: Alignment.center,
  //         child: Text("C"),
  //       ),
  //     ),
  //   ),
  //   Tab(
  //     child: Container(
  //       width: 70,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: appPrimaryMaterialColor, width: 1)),
  //       child: Align(
  //         alignment: Alignment.center,
  //         child: Text("D"),
  //       ),
  //     ),
  //   ),
  //   Tab(
  //     child: Container(
  //       width: 70,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: appPrimaryMaterialColor, width: 1)),
  //       child: Align(
  //         alignment: Alignment.center,
  //         child: Text("E"),
  //       ),
  //     ),
  //   ),
  //   Tab(
  //     child: Container(
  //       width: 70,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: appPrimaryMaterialColor, width: 1)),
  //       child: Align(
  //         alignment: Alignment.center,
  //         child: Text("F"),
  //       ),
  //     ),
  //   ),
  // ];
  bool isLoading = false;
  List getAllComplaintList = [];

  @override
  void initState() {
    _getAllComplains();
    print(dateFormateD.format(toDate));
    print(dateFormateD.format(yesterDayDate));
    print(dateFormateD.format(weekDate));
    print(dateFormateD.format(monthDate));
  }

  _getAllComplains({var toDate, var fromDate}) async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body;
        if (fromDate != null && toDate != null) {
          body = {
            "societyId": sharedPrefs.societyId,
            "fromDate": dateFormateD.format(fromDate),
            "toDate": dateFormateD.format(toDate),
          };
        } else if (fromDate != null && toDate == null) {
          body = {
            "societyId": sharedPrefs.societyId,
            "fromDate": dateFormateD.format(fromDate),
            // "toDate": toDate,
          };
        } else if (fromDate == null && toDate != null) {
          body = {
            "societyId": sharedPrefs.societyId,
            // "fromDate": fromDate,
            "toDate": dateFormateD.format(toDate),
          };
        } else {
          body = {
            "societyId": sharedPrefs.societyId,
          };
        }
        print("$body");
        getAllComplaintList.clear();
        Services.responseHandler(
                apiName: "api/admin/getAllSocietyComplain", body: body)
            .then((responseData) {
              print(responseData.Data.length);
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
    // return DefaultTabController(
    //   length: tabs.length,
    //   child:
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Complaints",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  ),
                  context: context,
                  builder: (builder) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
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
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
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
                                  _getAllComplains(toDate: toDate);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: appPrimaryMaterialColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                              "${dateFormate.format(toDate)}",
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
                                  _getAllComplains(toDate: yesterDayDate);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                              "${dateFormate.format(toDate.subtract(Duration(days: 1)))}",
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
                                  _getAllComplains(
                                    fromDate: weekDate,
                                    toDate: toDate,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: appPrimaryMaterialColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                              "${dateFormate2.format(toDate.subtract(Duration(days: 1)))}-${dateFormate.format(toDate.subtract(Duration(days: 7)))}",
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
                                  _getAllComplains(
                                    fromDate: monthDate,
                                    toDate: toDate,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: appPrimaryMaterialColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                              "${dateFormate2.format(toDate.subtract(Duration(days: 1)))}-${dateFormate.format(toDate.subtract(Duration(days: 30)))}",
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
                      ),
                    );
                  });
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _getAllComplains();
        },
        color: appPrimaryMaterialColor,
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                //backgroundColor: Color(0xFFFF4F4F),
                valueColor:
                    new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
              ))
            : getAllComplaintList.length == 0
                ? Center(
                    child: Text("No Complaints Found"),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 5, bottom: 18),
                    scrollDirection: Axis.vertical,
                    // reverse: true,
                    itemCount: getAllComplaintList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ComplainComponent(
                        getAllComplain: getAllComplaintList[getAllComplaintList.length-1-index],
                        getComplaindApi: () {
                          _getAllComplains();
                        },
                      );
                    }),
      ),
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),
      //
      // Column(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(top: 5, left: 4, right: 4),
      //             child: Container(
      //               height: 35,
      //               child: TabBar(
      //                   controller: _tabController,
      //                   labelPadding:
      //                       EdgeInsets.only(left: 9.0, right: 9.0),
      //                   // indicatorSize: TabBarIndicatorSize.label,
      //                   unselectedLabelColor: Colors.grey[600],
      //                   labelColor: Colors.white,
      //                   isScrollable: true,
      //                   indicatorColor: appPrimaryMaterialColor,
      //                   indicator: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(8),
      //                       color: appPrimaryMaterialColor),
      //                   onTap: (index) {},
      //                   tabs: tabs),
      //             ),
      //           ),
      //           Expanded(
      //             child: TabBarView(
      //                 physics: BouncingScrollPhysics(),
      //                 children: [
      //                   ListView.builder(
      //                       padding: EdgeInsets.only(top: 5, bottom: 18),
      //                       scrollDirection: Axis.vertical,
      //                       itemCount: getAllComplaintList.length,
      //                       itemBuilder: (BuildContext context, int index) {
      //                         return ComplainComponent(
      //                           getAllComplain: getAllComplaintList[index],
      //                           getComplaindApi: () {
      //                             _getAllComplains();
      //                           },
      //                         );
      //                       }),
      //                   Container(),
      //                   Container(),
      //                   Container(),
      //                   Container(),
      //                   Container(),
      //                 ]),
      //           ),
      //         ],
      //       )),
    );
  }
}

class BottomSheet extends StatefulWidget {
  Function complainApi;

  BottomSheet({
    this.complainApi,
  });

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  DateTime toDate = DateTime.now();
  var dateFormate = DateFormat('yMMMMd');
  var dateFormate2 = DateFormat('MMMMd');
  var dateFormateD = DateFormat('dd/MM/yyyy');

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
                widget.complainApi();
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
                            "${dateFormate.format(toDate)}",
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
                            "${dateFormate.format(toDate.subtract(Duration(days: 1)))}",
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
                            "${dateFormate2.format(toDate.subtract(Duration(days: 1)))}-${dateFormate.format(toDate.subtract(Duration(days: 7)))}",
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
                            "${dateFormate2.format(toDate.subtract(Duration(days: 1)))}-${dateFormate.format(toDate.subtract(Duration(days: 30)))}",
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
