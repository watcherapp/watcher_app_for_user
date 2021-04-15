import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/VisitorComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/InviteGuestComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/InviteGuest.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';

class UserVisitorList extends StatefulWidget {
  @override
  _UserVisitorListState createState() => _UserVisitorListState();
}

class _UserVisitorListState extends State<UserVisitorList> {
  List wingList = [
    "Invited Guest",
    "Visited Guest",
  ];
  TabController _tabController;
  List<Widget> tabs;

  bool isLoading = false;
  List allGuestList = [];
  List inviteGuestList = [];
  bool isOpen = false;
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  var fromDate = DateFormat('dd / MM / yyyy');
  var toDate = DateFormat('dd / MM / yyyy');

  var dateFormate = DateFormat('dd/MM/yyyy');

  showToDatePicker(BuildContext context, var forDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2101));

    if (forDate == "fromDate") {
      if (picked != null && picked != selectedFromDate)
        setState(() {
          selectedFromDate = picked;
        });
    } else if (forDate == "toDate") {
      if (picked != null && picked != selectedToDate)
        setState(() {
          selectedToDate = picked;
        });
    }
  }

  // showToDatePicker(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2018),
  //       lastDate: DateTime(2101));
  //
  //   if (picked != null && picked != selectedFromDate)
  //     setState(() {
  //       selectedFromDate = picked;
  //     });
  // }
  // showToDatePicker2(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2018),
  //       lastDate: DateTime(2101));
  //
  //   if (picked != null && picked != selectedToDate)
  //     setState(() {
  //       selectedToDate = picked;
  //     });
  // }

  @override
  void initState() {
    _getAllvisitor();
    _getMemberInviteGuests();
    print(fromDate.format(selectedFromDate));
    print(fromDate.format(selectedToDate));
    tabs = [
      for (int i = 0; i < wingList.length; i++) ...[
        Tab(
          child: Container(
            // height: 100,
            width: 110,
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

  _getAllvisitor() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(sharedPrefs.memberId);
        print(selectedFromDate);
        print(selectedToDate);
        var body = {
          "memberId": sharedPrefs.memberId,
          "fromDate": dateFormate.format(selectedFromDate),
          "toDate": dateFormate.format(selectedToDate),
        };
        log("MemberId ${sharedPrefs.memberId}");
        setState(() {
          isLoading = true;
        });
        Services.responseHandler(
                apiName: "api/member/getAllGuestList", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              allGuestList = responseData.Data;
              isLoading = false;
            });
            print("allGuestList-------------->${allGuestList}");
          } else {
            print(responseData);
            setState(() {
              allGuestList = responseData.Data;
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

  _getMemberInviteGuests() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(sharedPrefs.memberId);
        var body = {
          "memberId": sharedPrefs.memberId,
        };
        log("MemberId ${sharedPrefs.memberId}");
        setState(() {
          isLoading = true;
        });
        Services.responseHandler(
                apiName: "api/member/getMemberInviteGuestList", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              inviteGuestList = responseData.Data;
              isLoading = false;
            });
            print("inviteGuestList-------------->${inviteGuestList}");
          } else {
            print(responseData);
            setState(() {
              allGuestList = responseData.Data;
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

  Future<void> getReport() async {
    print("Refresh");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: RefreshIndicator(
          onRefresh: () {
            return getReport();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* MySearchField(
                icon: Icon(
                  Icons.search_rounded,
                  color: appPrimaryMaterialColor,
                  size: 20,
                ),
                hintText: "Search",
              ),*/
              SizedBox(
                height: 10,
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
              // SizedBox(
              //   height: 10,
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      //guest..........................
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8, top: 14, left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // GestureDetector(
                                //   onTap: () {
                                //     setState(() {
                                //       isOpen = !isOpen;
                                //     });
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
                                //           left: 6.0, right: 4.0, top: 2.0, bottom: 2.0),
                                //       child: Row(
                                //         children: [
                                //           Image.asset(
                                //             "images/filter.png",
                                //             width: 16,
                                //             color: appPrimaryMaterialColor,
                                //           ),
                                //           Padding(
                                //             padding:
                                //             const EdgeInsets.only(left: 6.0, right: 3),
                                //             child: Text(
                                //               "Filter",
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
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: InviteGuest(onSaved: () {
                                              _getMemberInviteGuests();
                                            }),
                                            type: PageTransitionType
                                                .rightToLeft));
                                  },
                                  child: Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        // color: Colors.white,
                                        border: Border.all(
                                          color: appPrimaryMaterialColor,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0,
                                          right: 4.0,
                                          top: 2.0,
                                          bottom: 2.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add_circle_outline_sharp,
                                            size: 16,
                                            color: appPrimaryMaterialColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0, right: 3),
                                            child: Text(
                                              "Add",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      appPrimaryMaterialColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // isOpen == true
                          //     ? Padding(
                          //         padding: const EdgeInsets.only(
                          //             left: 8.0, right: 8, bottom: 8, top: 15),
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               border: Border.all(
                          //                 color: appPrimaryMaterialColor,
                          //                 width: 1,
                          //               ),
                          //               borderRadius:
                          //                   BorderRadius.circular(4.0)),
                          //           child: Column(
                          //             children: [
                          //               Padding(
                          //                 padding: const EdgeInsets.only(
                          //                     left: 6.0,
                          //                     top: 15,
                          //                     right: 10,
                          //                     bottom: 15),
                          //                 child: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.start,
                          //                   children: [
                          //                     Flexible(
                          //                       child: Padding(
                          //                         padding:
                          //                             const EdgeInsets.only(
                          //                                 left: 4.0),
                          //                         child: Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .start,
                          //                           children: [
                          //                             Text(
                          //                               "Valid From",
                          //                               style: fontConstants
                          //                                   .formFieldLabel1,
                          //                             ),
                          //                             Padding(
                          //                               padding:
                          //                                   const EdgeInsets
                          //                                       .only(top: 8.0),
                          //                               child: GestureDetector(
                          //                                 onTap: () {
                          //                                   showToDatePicker(
                          //                                       context,
                          //                                       "fromDate");
                          //                                 },
                          //                                 child: Container(
                          //                                   decoration: BoxDecoration(
                          //                                       borderRadius:
                          //                                           BorderRadius
                          //                                               .circular(
                          //                                                   8.0),
                          //                                       color: Colors
                          //                                           .grey[200]),
                          //                                   height: 35,
                          //                                   width: MediaQuery.of(
                          //                                               context)
                          //                                           .size
                          //                                           .width /
                          //                                       2,
                          //                                   child: Center(
                          //                                       child: Text(
                          //                                     selectedFromDate !=
                          //                                             null
                          //                                         ? fromDate.format(
                          //                                             selectedFromDate)
                          //                                         : "Select Date",
                          //                                     style: TextStyle(
                          //                                         fontSize: 13),
                          //                                   )),
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     SizedBox(
                          //                       width: 10,
                          //                     ),
                          //                     Flexible(
                          //                       child: Padding(
                          //                         padding:
                          //                             const EdgeInsets.only(
                          //                                 left: 2.0),
                          //                         child: Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .start,
                          //                           children: [
                          //                             Text("Valid To",
                          //                                 style: fontConstants
                          //                                     .formFieldLabel1),
                          //                             Padding(
                          //                               padding:
                          //                                   const EdgeInsets
                          //                                       .only(top: 8.0),
                          //                               child: GestureDetector(
                          //                                 onTap: () {
                          //                                   showToDatePicker(
                          //                                       context,
                          //                                       "toDate");
                          //                                 },
                          //                                 child: Container(
                          //                                   decoration: BoxDecoration(
                          //                                       borderRadius:
                          //                                           BorderRadius
                          //                                               .circular(
                          //                                                   8.0),
                          //                                       color: Colors
                          //                                           .grey[200]),
                          //                                   height: 35,
                          //                                   width: MediaQuery.of(
                          //                                               context)
                          //                                           .size
                          //                                           .width /
                          //                                       2,
                          //                                   child: Center(
                          //                                       child: Text(
                          //                                           selectedToDate !=
                          //                                                   null
                          //                                               ? toDate.format(
                          //                                                   selectedToDate)
                          //                                               : "Select Date",
                          //                                           style: TextStyle(
                          //                                               fontSize:
                          //                                                   13))),
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //               Padding(
                          //                 padding:
                          //                     const EdgeInsets.only(bottom: 7),
                          //                 child: SizedBox(
                          //                   width: 150,
                          //                   child: TextButton(
                          //                     style: TextButton.styleFrom(
                          //                       backgroundColor:
                          //                           appPrimaryMaterialColor,
                          //                       shape:
                          //                           const RoundedRectangleBorder(
                          //                               borderRadius:
                          //                                   BorderRadius.all(
                          //                                       Radius.circular(
                          //                                           7))),
                          //                     ),
                          //                     onPressed: () {
                          //                       _getAllvisitor();
                          //                     },
                          //                     child: Text(
                          //                       "Search",
                          //                       style: TextStyle(
                          //                           fontSize: 12,
                          //                           fontWeight: FontWeight.bold,
                          //                           color: Colors.white),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       )
                          //     : SizedBox(),
                          isLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            appPrimaryMaterialColor),
                                  ),
                                )
                              : inviteGuestList.length > 0
                                  ? Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: inviteGuestList.length,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InviteGuestComponent(
                                              guestData: inviteGuestList[index],
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          "No Data Found...",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 12,
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                        ],
                      ),

                      //visitors............................
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8, top: 14, left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isOpen = !isOpen;
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        // color: Colors.white,
                                        border: Border.all(
                                          color: appPrimaryMaterialColor,
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
                                            color: appPrimaryMaterialColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6.0, right: 3),
                                            child: Text(
                                              "Filter",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
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
                          isOpen == true
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8, bottom: 8, top: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: appPrimaryMaterialColor,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
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
                                                      const EdgeInsets.only(
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
                                                                .only(top: 8.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            showToDatePicker(
                                                                context,
                                                                "fromDate");
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                            height: 35,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2,
                                                            child: Center(
                                                                child: Text(
                                                              selectedFromDate !=
                                                                      null
                                                                  ? fromDate.format(
                                                                      selectedFromDate)
                                                                  : "Select Date",
                                                              style: TextStyle(
                                                                  fontSize: 13),
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
                                                      const EdgeInsets.only(
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
                                                                .only(top: 8.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            showToDatePicker(
                                                                context,
                                                                "toDate");
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                            height: 35,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2,
                                                            child: Center(
                                                                child: Text(
                                                                    selectedToDate !=
                                                                            null
                                                                        ? toDate.format(
                                                                            selectedToDate)
                                                                        : "Select Date",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13))),
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
                                              const EdgeInsets.only(bottom: 7),
                                          child: SizedBox(
                                            width: 150,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    appPrimaryMaterialColor,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    7))),
                                              ),
                                              onPressed: () {
                                                _getAllvisitor();
                                              },
                                              child: Text(
                                                "Search",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          isLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            appPrimaryMaterialColor),
                                  ),
                                )
                              : allGuestList.length > 0
                                  ? Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: allGuestList.length,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return VisitorComponent(
                                              visitorData: allGuestList[index],
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          "No Data Found...",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 12,
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
