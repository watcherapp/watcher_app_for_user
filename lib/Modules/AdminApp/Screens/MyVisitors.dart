import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

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
          // "societyId": "605583b2848881107c3fcf9d",
          "type": "0",
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
          // "societyId": "605583b2848881107c3fcf9d",
          "type": "1",
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
          // "societyId": "605583b2848881107c3fcf9d",
          "type": "2",
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
                        // for (int i = 0; i < wingList.length; i++) ...[
                        //   Container(
                        //     child: ListView.builder(
                        //       itemBuilder: (_, index) => Container(
                        //         height: 100,
                        //         child: Card(
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(5.0),
                        //             child: Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 10,
                        //                 ),
                        //                 // getAllWingMemberData[index]["memberImage"] == null || getAllWingMemberData[index]["memberImage"] == ""
                        //                 true == true
                        //                     ? Image.asset(
                        //                         'images/user.png',
                        //                         width: 70,
                        //                         height: 70,
                        //                       )
                        //                     : Padding(
                        //                         padding: const EdgeInsets.only(
                        //                             top: 3.0),
                        //                         child: Container(
                        //                           height: 70.0,
                        //                           width: 70,
                        //                           decoration: BoxDecoration(
                        //                             // borderRadius: BorderRadius.circular(30),
                        //                             color: Colors.white,
                        //                             shape: BoxShape.circle,
                        //                             border: Border.all(
                        //                                 width: 0.2,
                        //                                 color:
                        //                                     appPrimaryMaterialColor),
                        //                             image: DecorationImage(
                        //                               image: NetworkImage(
                        //                                 "",
                        //                               ),
                        //                               fit: BoxFit.fill,
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       ),
                        //                 SizedBox(
                        //                   width: 15,
                        //                 ),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.center,
                        //                   children: [
                        //                     Text(
                        //                       "smit vaghani",
                        //                       style: TextStyle(
                        //                           color:
                        //                               appPrimaryMaterialColor,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontSize: 14),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 5,
                        //                     ),
                        //                     SizedBox(
                        //                       height: 2,
                        //                     ),
                        //                     Text(
                        //                         '8735069293'),
                        //                     SizedBox(
                        //                       height: 2,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 SizedBox(
                        //                   width: 105,
                        //                 ),
                        //                 IconButton(
                        //                   icon: Icon(Icons.message),
                        //                   iconSize: 25,
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       // itemCount: 8,
                        //       itemCount: 10,
                        //     ),
                        //   ),
                        // ],
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
                            : guestList.length == 0
                                ? Center(
                                    child: Text("No Guest Entry Found"),
                                  )
                                : Container(
                                    child: ListView.builder(
                                      itemBuilder: (_, index) => Container(
                                        height: 100,
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                guestList[index][
                                                                "guestImage"] ==
                                                            null ||
                                                        guestList[index][
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
                                                                .only(top: 3.0),
                                                        child: Container(
                                                          height: 70.0,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            // borderRadius: BorderRadius.circular(30),
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                width: 0.2,
                                                                color:
                                                                    appPrimaryMaterialColor),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                API_URL +
                                                                    guestList[
                                                                            index]
                                                                        [
                                                                        "guestImage"],
                                                              ),
                                                              fit: BoxFit.fill,
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
                                                        style: TextStyle(
                                                            color:
                                                                appPrimaryMaterialColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "${guestList[index]["mobileNo"]}",
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        "${guestList[index]["vehicleNo"]}",
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
                                                  icon: Icon(Icons.message),
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
                            : staffList.length == 0
                                ? Center(
                                    child: Text("No Staff Entry Found"),
                                  )
                                : Container(
                                    child: ListView.builder(
                                      itemBuilder: (_, index) => Container(
                                        height: 100,
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                staffList[index]["StaffData"][0]
                                                                [
                                                                "staffImage"] ==
                                                            null ||
                                                        staffList[index][
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
                                                                .only(top: 3.0),
                                                        child: Container(
                                                          height: 70.0,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            // borderRadius: BorderRadius.circular(30),
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                width: 0.2,
                                                                color:
                                                                    appPrimaryMaterialColor),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                API_URL +
                                                                    staffList[index]
                                                                            [
                                                                            "StaffData"][0]
                                                                        [
                                                                        "staffImage"],
                                                              ),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${staffList[index]["StaffData"][0]["firstName"]} ${staffList[index]["StaffData"][0]["lastName"]}",
                                                      style: TextStyle(
                                                          color:
                                                              appPrimaryMaterialColor,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                  icon: Icon(Icons.message),
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
                            : vendorList.length == 0
                                ? Center(
                                    child: Text("No Vendor Entry Found"),
                                  )
                                : Container(
                                    child: ListView.builder(
                                      itemBuilder: (_, index) => Container(
                                        height: 100,
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                vendorList[index]["VendorData"]
                                                                    [0][
                                                                "vendorImage"] ==
                                                            null ||
                                                        vendorList[index][
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
                                                                .only(top: 3.0),
                                                        child: Container(
                                                          height: 70.0,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            // borderRadius: BorderRadius.circular(30),
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                width: 0.2,
                                                                color:
                                                                    appPrimaryMaterialColor),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                API_URL +
                                                                    vendorList[index]
                                                                            [
                                                                            "VendorData"][0]
                                                                        [
                                                                        "vendorImage"],
                                                              ),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      vendorList[index]
                                                              ["VendorData"][0]
                                                          ["vendorName"],
                                                      style: TextStyle(
                                                          color:
                                                              appPrimaryMaterialColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      vendorList[index]
                                                              ["VendorData"][0]
                                                          ["mobileNo1"],
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
                                                  icon: Icon(Icons.message),
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
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
