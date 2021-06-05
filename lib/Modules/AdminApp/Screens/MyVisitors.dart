import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';

class MyVisitors extends StatefulWidget {
  @override
  _MyVisitorsState createState() => _MyVisitorsState();
}

class _MyVisitorsState extends State<MyVisitors> {
  List wingList = [
    "Guest",
    "Staff",
    "Vendor",
  ];
  List guestList = [];
  List staffList = [];
  List vendorList = [];
  bool isLoading = false;

  TabController _tabController;
  List<Widget> tabs;

  //gest...............
  bool isOpenG = false;
  DateTime selectedFromDateG = DateTime.now();
  DateTime selectedToDateG = DateTime.now();

  var fromDateG = DateFormat('dd / MM / yyyy');
  var toDateG = DateFormat('dd / MM / yyyy');

  var dateFormateG = DateFormat('dd/MM/yyyy');

  showToDatePickerG(BuildContext context, var forDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now());

    if (forDate == "fromDate") {
      if (picked != null && picked != selectedFromDateG)
        setState(() {
          selectedFromDateG = picked;
        });
    } else if (forDate == "toDate") {
      if (picked != null && picked != selectedToDateG)
        setState(() {
          selectedToDateG = picked;
        });
    }
  }

  //staff...................
  bool isOpenS = false;
  DateTime selectedFromDateS = DateTime.now();
  DateTime selectedToDateS = DateTime.now();

  var fromDateS = DateFormat('dd / MM / yyyy');
  var toDateS = DateFormat('dd / MM / yyyy');

  var dateFormateS = DateFormat('dd/MM/yyyy');

  showToDatePickerS(BuildContext context, var forDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now());

    if (forDate == "fromDate") {
      if (picked != null && picked != selectedFromDateS)
        setState(() {
          selectedFromDateS = picked;
        });
    } else if (forDate == "toDate") {
      if (picked != null && picked != selectedToDateS)
        setState(() {
          selectedToDateS = picked;
        });
    }
  }

  //vendor.......................

  bool isOpenV = false;
  DateTime selectedFromDateV = DateTime.now();
  DateTime selectedToDateV = DateTime.now();

  var fromDateV = DateFormat('dd / MM / yyyy');
  var toDateV = DateFormat('dd / MM / yyyy');

  var dateFormateV = DateFormat('dd/MM/yyyy');

  showToDatePickerV(BuildContext context, var forDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now());

    if (forDate == "fromDate") {
      if (picked != null && picked != selectedFromDateV)
        setState(() {
          selectedFromDateV = picked;
        });
    } else if (forDate == "toDate") {
      if (picked != null && picked != selectedToDateV)
        setState(() {
          selectedToDateV = picked;
        });
    }
  }

  @override
  void initState() {
    _getAllGuest();
    _getAllStaff();
    _getAllvendor();

    tabs = [
      for (int i = 0; i < wingList.length; i++) ...[
        Tab(
          child: Container(
            // height: 100,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: appPrimaryMaterialColor, width: 1)),
            child: Align(
              alignment: Alignment.center,
              child: Text("${wingList[i]}"),
            ),
          ),
        )
      ]
    ];
  }

  _getAllGuest() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
          "type": "0",
          "fromDate": dateFormateG.format(selectedFromDateG),
          "toDate": dateFormateG.format(selectedToDateG),
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/staff/getAllVisitorList", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              guestList = responseData.Data;
              print("guestList----------------->$guestList");
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

  _getAllStaff() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
          "type": "1",
          "fromDate": dateFormateS.format(selectedFromDateS),
          "toDate": dateFormateS.format(selectedToDateS),
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/staff/getAllVisitorList", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              staffList = responseData.Data;
              print("staffList----------------->$staffList");
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

  _getAllvendor() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
          "type": "2",
          "fromDate": dateFormateV.format(selectedFromDateV),
          "toDate": dateFormateV.format(selectedToDateV),
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/staff/getAllVisitorList", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              vendorList = responseData.Data;
              print("vendorList----------------->$vendorList");
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
            backgroundColor: Colors.grey[100],
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: Container(
                    height: 35,
                    child: TabBar(
                        controller: _tabController,
                        labelPadding: EdgeInsets.only(left: 9.0, right: 9.0),
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
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        isLoading
                            ? Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            appPrimaryMaterialColor),
                                    //backgroundColor: Colors.white54,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, top: 14, left: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isOpenG = !isOpenG;
                                            });
                                          },
                                          child: Container(
                                            height: 25,
                                            decoration: BoxDecoration(
                                                // color: Colors.white,
                                                border: Border.all(
                                                  color:
                                                      appPrimaryMaterialColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 2.0,
                                                  bottom: 2.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "images/filter.png",
                                                    width: 16,
                                                    color:
                                                        appPrimaryMaterialColor,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 6.0,
                                                            right: 3),
                                                    child: Text(
                                                      "Filter",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              appPrimaryMaterialColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         PageTransition(
                                        //             child: InviteGuest(onSaved: () {
                                        //               _getAllvisitor();
                                        //             }),
                                        //             type: PageTransitionType.rightToLeft));
                                        //   },
                                        //   child: Container(
                                        //     height: 25,
                                        //     decoration: BoxDecoration(
                                        //       // color: Colors.white,
                                        //         border: Border.all(
                                        //           color: appPrimaryMaterialColor,
                                        //           width: 1,
                                        //         ),
                                        //         borderRadius: BorderRadius.circular(4.0)),
                                        //     child: Padding(
                                        //       padding: const EdgeInsets.only(
                                        //           left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                                        //       child: Row(
                                        //         children: [
                                        //           Icon(
                                        //             Icons.add_circle_outline_sharp,
                                        //             size: 16,
                                        //             color: appPrimaryMaterialColor,
                                        //           ),
                                        //           Padding(
                                        //             padding:
                                        //             const EdgeInsets.only(left: 4.0, right: 3),
                                        //             child: Text(
                                        //               "Add",
                                        //               style: TextStyle(
                                        //                   fontSize: 12,
                                        //                   fontWeight: FontWeight.bold,
                                        //                   color: appPrimaryMaterialColor),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  isOpenG == true
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              bottom: 8,
                                              top: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color:
                                                      appPrimaryMaterialColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6.0,
                                                          top: 15,
                                                          right: 10,
                                                          bottom: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Valid From",
                                                                style: fontConstants
                                                                    .formFieldLabel1,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    showToDatePickerG(
                                                                        context,
                                                                        "fromDate");
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8.0),
                                                                        color: Colors
                                                                            .grey[200]),
                                                                    height: 35,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    child: Center(
                                                                        child: Text(
                                                                      selectedFromDateG !=
                                                                              null
                                                                          ? fromDateG
                                                                              .format(selectedFromDateG)
                                                                          : "Select Date",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text("Valid To",
                                                                  style: fontConstants
                                                                      .formFieldLabel1),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    showToDatePickerG(
                                                                        context,
                                                                        "toDate");
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8.0),
                                                                        color: Colors
                                                                            .grey[200]),
                                                                    height: 35,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    child: Center(
                                                                        child: Text(
                                                                            selectedToDateG != null
                                                                                ? toDateG.format(selectedToDateG)
                                                                                : "Select Date",
                                                                            style: TextStyle(fontSize: 13))),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 7),
                                                  child: SizedBox(
                                                    width: 150,
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            appPrimaryMaterialColor,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            7))),
                                                      ),
                                                      onPressed: () {
                                                        _getAllGuest();
                                                      },
                                                      child: Text(
                                                        "Search",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  guestList.length == 0
                                      ? Center(
                                          child: Text("No Guest Entry Found"),
                                        )
                                      : Expanded(
                                          child: Container(
                                            child: ListView.builder(
                                              itemBuilder: (_, index) =>
                                                  Container(
                                                height: 100,
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        guestList[index][
                                                                        "guestImage"] ==
                                                                    null ||
                                                                guestList[index]
                                                                        [
                                                                        "guestImage"] ==
                                                                    ""
                                                            ? Image.asset(
                                                                'images/user.png',
                                                                width: 70,
                                                                height: 70,
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            3.0),
                                                                child:
                                                                    Container(
                                                                  height: 70.0,
                                                                  width: 70,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    // borderRadius: BorderRadius.circular(30),
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        width:
                                                                            0.2,
                                                                        color:
                                                                            appPrimaryMaterialColor),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        API_URL +
                                                                            guestList[index]["guestImage"],
                                                                      ),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "${guestList[index]["guestName"]}",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      appPrimaryMaterialColor,
                                                                  fontFamily:
                                                                      'WorkSans Bold',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "${guestList[index]["mobileNo"]}",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontFamily:
                                                                      'WorkSans Bold',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                "${guestList[index]["FlatData"][0]["WingData"][0]["wingName"]} - ${guestList[index]["FlatData"][0]["flatNo"]}",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontFamily:
                                                                      'WorkSans Bold',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                "${guestList[index]["vehicleNo"]}",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontFamily:
                                                                      'WorkSans Bold',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 90,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.message),
                                                          iconSize: 25,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // itemCount: 8,
                                              itemCount: guestList.length,
                                            ),
                                          ),
                                        )
                                ],
                              ),
                        isLoading
                            ? Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            appPrimaryMaterialColor),
                                    //backgroundColor: Colors.white54,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, top: 14, left: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isOpenS = !isOpenS;
                                            });
                                          },
                                          child: Container(
                                            height: 25,
                                            decoration: BoxDecoration(
                                                // color: Colors.white,
                                                border: Border.all(
                                                  color:
                                                      appPrimaryMaterialColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 2.0,
                                                  bottom: 2.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "images/filter.png",
                                                    width: 16,
                                                    color:
                                                        appPrimaryMaterialColor,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 6.0,
                                                            right: 3),
                                                    child: Text(
                                                      "Filter",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              appPrimaryMaterialColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         PageTransition(
                                        //             child: InviteGuest(onSaved: () {
                                        //               _getAllvisitor();
                                        //             }),
                                        //             type: PageTransitionType.rightToLeft));
                                        //   },
                                        //   child: Container(
                                        //     height: 25,
                                        //     decoration: BoxDecoration(
                                        //       // color: Colors.white,
                                        //         border: Border.all(
                                        //           color: appPrimaryMaterialColor,
                                        //           width: 1,
                                        //         ),
                                        //         borderRadius: BorderRadius.circular(4.0)),
                                        //     child: Padding(
                                        //       padding: const EdgeInsets.only(
                                        //           left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                                        //       child: Row(
                                        //         children: [
                                        //           Icon(
                                        //             Icons.add_circle_outline_sharp,
                                        //             size: 16,
                                        //             color: appPrimaryMaterialColor,
                                        //           ),
                                        //           Padding(
                                        //             padding:
                                        //             const EdgeInsets.only(left: 4.0, right: 3),
                                        //             child: Text(
                                        //               "Add",
                                        //               style: TextStyle(
                                        //                   fontSize: 12,
                                        //                   fontWeight: FontWeight.bold,
                                        //                   color: appPrimaryMaterialColor),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  isOpenS == true
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              bottom: 8,
                                              top: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color:
                                                      appPrimaryMaterialColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6.0,
                                                          top: 15,
                                                          right: 10,
                                                          bottom: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Valid From",
                                                                style: fontConstants
                                                                    .formFieldLabel1,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    showToDatePickerS(
                                                                        context,
                                                                        "fromDate");
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8.0),
                                                                        color: Colors
                                                                            .grey[200]),
                                                                    height: 35,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    child: Center(
                                                                        child: Text(
                                                                      selectedFromDateS !=
                                                                              null
                                                                          ? fromDateS
                                                                              .format(selectedFromDateS)
                                                                          : "Select Date",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text("Valid To",
                                                                  style: fontConstants
                                                                      .formFieldLabel1),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    showToDatePickerS(
                                                                        context,
                                                                        "toDate");
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8.0),
                                                                        color: Colors
                                                                            .grey[200]),
                                                                    height: 35,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    child: Center(
                                                                        child: Text(
                                                                            selectedToDateS != null
                                                                                ? toDateS.format(selectedToDateS)
                                                                                : "Select Date",
                                                                            style: TextStyle(fontSize: 13))),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 7),
                                                  child: SizedBox(
                                                    width: 150,
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            appPrimaryMaterialColor,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            7))),
                                                      ),
                                                      onPressed: () {
                                                        _getAllStaff();
                                                      },
                                                      child: Text(
                                                        "Search",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  staffList.length == 0
                                      ? Center(
                                          child: Text("No Staff Entry Found"),
                                        )
                                      : Expanded(
                                          child: Container(
                                            child: ListView.builder(
                                              itemBuilder: (_, index) =>
                                                  Container(
                                                height: 100,
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        staffList[index]["StaffData"]
                                                                            [0][
                                                                        "staffImage"] ==
                                                                    null ||
                                                                staffList[index]
                                                                            [
                                                                            "StaffData"][0]
                                                                        [
                                                                        "staffImage"] ==
                                                                    ""
                                                            ? Image.asset(
                                                                'images/user.png',
                                                                width: 70,
                                                                height: 70,
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            3.0),
                                                                child:
                                                                    Container(
                                                                  height: 70.0,
                                                                  width: 70,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    // borderRadius: BorderRadius.circular(30),
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        width:
                                                                            0.2,
                                                                        color:
                                                                            appPrimaryMaterialColor),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        API_URL +
                                                                            staffList[index]["StaffData"][0]["staffImage"],
                                                                      ),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "${staffList[index]["StaffData"][0]["firstName"]} ${staffList[index]["StaffData"][0]["lastName"]}",
                                                              style: TextStyle(
                                                                  color:
                                                                      appPrimaryMaterialColor,
                                                                  fontFamily:
                                                                      'WorkSans Bold',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                                '${staffList[index]["StaffData"][0]["mobileNo1"]}'),
                                                            SizedBox(
                                                              height: 2,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 105,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.message,
                                                          ),
                                                          iconSize: 25,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // itemCount: 8,
                                              itemCount: staffList.length,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                        isLoading
                            ? Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            appPrimaryMaterialColor),
                                    //backgroundColor: Colors.white54,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, top: 14, left: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isOpenV = !isOpenV;
                                            });
                                          },
                                          child: Container(
                                            height: 25,
                                            decoration: BoxDecoration(
                                                // color: Colors.white,
                                                border: Border.all(
                                                  color:
                                                      appPrimaryMaterialColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 2.0,
                                                  bottom: 2.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "images/filter.png",
                                                    width: 16,
                                                    color:
                                                        appPrimaryMaterialColor,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 6.0,
                                                            right: 3),
                                                    child: Text(
                                                      "Filter",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              appPrimaryMaterialColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         PageTransition(
                                        //             child: InviteGuest(onSaved: () {
                                        //               _getAllvisitor();
                                        //             }),
                                        //             type: PageTransitionType.rightToLeft));
                                        //   },
                                        //   child: Container(
                                        //     height: 25,
                                        //     decoration: BoxDecoration(
                                        //       // color: Colors.white,
                                        //         border: Border.all(
                                        //           color: appPrimaryMaterialColor,
                                        //           width: 1,
                                        //         ),
                                        //         borderRadius: BorderRadius.circular(4.0)),
                                        //     child: Padding(
                                        //       padding: const EdgeInsets.only(
                                        //           left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                                        //       child: Row(
                                        //         children: [
                                        //           Icon(
                                        //             Icons.add_circle_outline_sharp,
                                        //             size: 16,
                                        //             color: appPrimaryMaterialColor,
                                        //           ),
                                        //           Padding(
                                        //             padding:
                                        //             const EdgeInsets.only(left: 4.0, right: 3),
                                        //             child: Text(
                                        //               "Add",
                                        //               style: TextStyle(
                                        //                   fontSize: 12,
                                        //                   fontWeight: FontWeight.bold,
                                        //                   color: appPrimaryMaterialColor),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  isOpenV == true
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              bottom: 8,
                                              top: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color:
                                                      appPrimaryMaterialColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6.0,
                                                          top: 15,
                                                          right: 10,
                                                          bottom: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Valid From",
                                                                style: fontConstants
                                                                    .formFieldLabel1,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    showToDatePickerV(
                                                                        context,
                                                                        "fromDate");
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8.0),
                                                                        color: Colors
                                                                            .grey[200]),
                                                                    height: 35,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    child: Center(
                                                                        child: Text(
                                                                      selectedFromDateV !=
                                                                              null
                                                                          ? fromDateV
                                                                              .format(selectedFromDateV)
                                                                          : "Select Date",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text("Valid To",
                                                                  style: fontConstants
                                                                      .formFieldLabel1),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    showToDatePickerV(
                                                                        context,
                                                                        "toDate");
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8.0),
                                                                        color: Colors
                                                                            .grey[200]),
                                                                    height: 35,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    child: Center(
                                                                        child: Text(
                                                                            selectedToDateV != null
                                                                                ? toDateV.format(selectedToDateV)
                                                                                : "Select Date",
                                                                            style: TextStyle(fontSize: 13))),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 7),
                                                  child: SizedBox(
                                                    width: 150,
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            appPrimaryMaterialColor,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            7))),
                                                      ),
                                                      onPressed: () {
                                                        _getAllStaff();
                                                      },
                                                      child: Text(
                                                        "Search",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  vendorList.length == 0
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Center(
                                            child:
                                                Text("No Vendor Entry Found"),
                                          ),
                                        )
                                      : Expanded(
                                          child: Container(
                                            child: ListView.builder(
                                              itemBuilder: (_, index) =>
                                                  Container(
                                                height: 100,
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        vendorList[index]["VendorData"]
                                                                            [0][
                                                                        "vendorImage"] ==
                                                                    null ||
                                                                vendorList[index]
                                                                            [
                                                                            "VendorData"][0]
                                                                        [
                                                                        "vendorImage"] ==
                                                                    ""
                                                            ? Image.asset(
                                                                'images/user.png',
                                                                width: 70,
                                                                height: 70,
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            3.0),
                                                                child:
                                                                    Container(
                                                                  height: 70.0,
                                                                  width: 70,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    // borderRadius: BorderRadius.circular(30),
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        width:
                                                                            0.2,
                                                                        color:
                                                                            appPrimaryMaterialColor),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        API_URL +
                                                                            vendorList[index]["VendorData"][0]["vendorImage"],
                                                                      ),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              vendorList[index][
                                                                      "VendorData"][0]
                                                                  [
                                                                  "vendorName"],
                                                              style: TextStyle(
                                                                  color:
                                                                      appPrimaryMaterialColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                              vendorList[index][
                                                                      "VendorData"]
                                                                  [
                                                                  0]["mobileNo1"],
                                                            ),
                                                            SizedBox(
                                                              height: 2,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 105,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.message),
                                                          iconSize: 25,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // itemCount: 8,
                                              itemCount: vendorList.length,
                                            ),
                                          ),
                                        ),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
