import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'dart:math' as math;

import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/BottomNavigationBarCustomForAdmin.dart';

class ParkingScreen extends StatefulWidget {
  @override
  _ParkingScreenState createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  ScrollController controller = new ScrollController();
  List parkingList = [];
  List getAllWingList = [];
  List getAllFlatList = [];
  bool isSelected = false;
  bool isLoading = false;
  bool isPLoading = false;
  int selectedW = -1;
  int selectedF = -1;
  String flatId;
  var wingId;

  TabController _tabController;
  List<Widget> tabs;

  @override
  void initState() {
    _getAllWings();

    // tabs = [
    //   for (int i = 0; i < wingList.length; i++) ...[
    //     Tab(
    //       child: Container(
    //         width: 70,
    //         decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(8),
    //             border: Border.all(color: appPrimaryMaterialColor, width: 1)),
    //         child: Align(
    //           alignment: Alignment.center,
    //           child: Text("${wingList[i]}"),
    //         ),
    //       ),
    //     )
    //   ]
    // ];
  }

  _getAllWings() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          // "societyCode": "SOC-990854",
          "societyCode": sharedPrefs.societyCode,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/getAllWingsOfSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              getAllWingList = responseData.Data;
              print("Wings----------------->$getAllWingList");
              isLoading = false;
            });
            // _getAllFlats(wingId: getAllWingList[0]["_id"]);
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

  _getAllFlatsWithParking({String wingId}) async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": getAllWingList[0]["societyId"],
          "wingId": wingId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/getFlatNParkingOfSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            getAllFlatList = responseData.Data;
            print("Flats----------------->$getAllFlatList");
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

  //only for available.........................
  _getAllAvailableParkingSlot() async {
    try {
      setState(() {
        isPLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "wingId": wingId,
          "societyId": sharedPrefs.societyId,
        };
        print("$body");
        parkingList.clear();
        Services.responseHandler(
                apiName: "api/member/getAllAvailableParkingSlots", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print("Parking Slots----->${responseData.Data}");
            setState(() {
              parkingList = responseData.Data;
              isPLoading = false;
            });
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                context: context,
                builder: (builder) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BottomSheet(
                      parkingSlot: parkingList,
                      flatId: flatId,
                    ),
                  );
                });
          } else {
            parkingList.clear();
            print(responseData);
            setState(() {
              isPLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
          }
        }).catchError((error) {
          setState(() {
            isPLoading = false;
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
        isPLoading = false;
      });
      Fluttertoast.showToast(
        msg: "You aren't connected to the Internet !",
        backgroundColor: Colors.white,
        textColor: appPrimaryMaterialColor,
      );
    }
  }

  _getAllParkingSlot() async {
    try {
      setState(() {
        isPLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "wingId": wingId,
          "societyId": sharedPrefs.societyId,
        };
        print("$body");
        parkingList.clear();
        Services.responseHandler(
                apiName: "api/member/getAllParkingSlotsData", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print("Parking Slots----->${responseData.Data}");
            setState(() {
              parkingList = responseData.Data;
              isPLoading = false;
            });
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isScrollControlled: true,
                context: context,
                builder: (builder) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BottomSheet(
                      parkingSlot: parkingList,
                      flatId: flatId,
                      wingId: wingId,
                      getAllFlat: (){
                        _getAllFlatsWithParking(
                          wingId: wingId,
                        );
                      },
                    ),
                  );
                });
          } else {
            parkingList.clear();
            print(responseData);
            setState(() {
              isPLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
          }
        }).catchError((error) {
          setState(() {
            isPLoading = false;
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
        isPLoading = false;
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
      // appBar: AppBar(
      //   title: Text(
      //     "Parking Slots",
      //     style: TextStyle(fontFamily: 'Montserrat'),
      //   ),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: appPrimaryMaterialColor,
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Parking Slots",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Select Your Wing",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 90,
            // width: 100,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 5, bottom: 18),
                scrollDirection: Axis.horizontal,
                itemCount: getAllWingList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedW = index;
                        });
                        wingId = getAllWingList[index]["_id"];
                        _getAllFlatsWithParking(
                            wingId: getAllWingList[index]["_id"]);
                        print("${getAllWingList[index]["wingName"]}");
                      },
                      child: Container(
                        width: 70,
                        child: Card(
                          color: selectedW == index
                              ? appPrimaryMaterialColor
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 10, right: 10, bottom: 8),
                            child: Align(
                              alignment: Alignment.center,
                              child:
                                  Text("${getAllWingList[index]["wingName"]}",
                                      style: TextStyle(
                                        color: selectedW == index
                                            ? Colors.white
                                            : appPrimaryMaterialColor,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                      )),
                            ),
                          ),
                        ),
                        // decoration: BoxDecoration(
                        //   color: selectedF == index
                        //       ? appPrimaryMaterialColor
                        //       : Colors.white,
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Select Your Flat",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          isLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          appPrimaryMaterialColor),
                      //backgroundColor: Colors.white54,
                    ),
                  ),
                )
              : getAllFlatList.length > 0
                  ? Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Scrollbar(
                          thickness: 3,
                          isAlwaysShown: true,
                          controller: controller,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              controller: controller,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5),
                              itemBuilder: (_, index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedF = index;
                                    print("${getAllFlatList[index]["_id"]}");
                                    flatId = getAllFlatList[index]["_id"];
                                  });
                                },
                                child: Container(
                                  width: 70,
                                  child: Card(
                                    color: getAllFlatList[index]["ParkingSlot"]
                                                .length >
                                            0
                                        ? Colors.green
                                        : selectedF == index
                                            ? appPrimaryMaterialColor
                                            : Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8,
                                          left: 10,
                                          right: 10,
                                          bottom: 8),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            "${getAllFlatList[index]["flatNo"]}",
                                            style: TextStyle(
                                              color: getAllFlatList[index]
                                                              ["ParkingSlot"]
                                                          .length >
                                                      0
                                                  ? Colors.white
                                                  : selectedF == index
                                                      ? Colors.white
                                                      : appPrimaryMaterialColor,
                                              fontFamily: 'Montserrat',
                                              fontSize: 16,
                                            )),
                                      ),
                                    ),
                                  ),
                                  // decoration: BoxDecoration(
                                  //   color: selectedF == index
                                  //       ? appPrimaryMaterialColor
                                  //       : Colors.white,
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                ),
                              ),
                              // itemCount: 8,
                              itemCount: getAllFlatList.length,
                            ),
                          ),
                        ),
                      ),
                  )
                  : Center(
                      child: Text("No Flat Found"),
                    ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
            child: MyButton(
                onPressed: () {
                  if (wingId == null) {
                    Fluttertoast.showToast(
                      gravity: ToastGravity.TOP,
                      textColor: Colors.white,
                      backgroundColor: Color(0xFFFF4F4F),
                      msg: "Please Select Wing of Your Society",
                    );
                  } else if (flatId == null) {
                    Fluttertoast.showToast(
                      gravity: ToastGravity.TOP,
                      textColor: Colors.white,
                      backgroundColor: Color(0xFFFF4F4F),
                      msg: "Please Select Flat of Your Wing",
                    );
                  } else {
                    isPLoading
                        ? Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              appPrimaryMaterialColor),
                          //backgroundColor: Colors.white54,
                        ),
                      ),
                    )
                    // : _getAllAvailableParkingSlot();
                        : _getAllParkingSlot();
                  }
                },
                title: "Assign"),
          ),
          // SizedBox(
          //   height: 40,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 5, right: 5),
          //   child: MyButton(
          //     onPressed: () {
          //       showModalBottomSheet(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           context: context,
          //           builder: (builder) {
          //             return Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: BottomSheet(
          //                 parkingSlot: parkingList,
          //                 flatId: flatId,
          //               ),
          //             );
          //           });
          //     },
          //     title: "Assign",
          //   ),
          // ),
        ],
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
      //   child: MyButton(
      //       onPressed: () {
      //         if (wingId == null) {
      //           Fluttertoast.showToast(
      //             gravity: ToastGravity.TOP,
      //             textColor: Colors.white,
      //             backgroundColor: Color(0xFFFF4F4F),
      //             msg: "Please Select Wing of Your Society",
      //           );
      //         } else if (flatId == null) {
      //           Fluttertoast.showToast(
      //             gravity: ToastGravity.TOP,
      //             textColor: Colors.white,
      //             backgroundColor: Color(0xFFFF4F4F),
      //             msg: "Please Select Flat of Your Wing",
      //           );
      //         } else {
      //           isPLoading
      //               ? Padding(
      //                   padding: const EdgeInsets.only(top: 100),
      //                   child: Center(
      //                     child: CircularProgressIndicator(
      //                       valueColor: new AlwaysStoppedAnimation<Color>(
      //                           appPrimaryMaterialColor),
      //                       //backgroundColor: Colors.white54,
      //                     ),
      //                   ),
      //                 )
      //               // : _getAllAvailableParkingSlot();
      //               : _getAllParkingSlot();
      //         }
      //       },
      //       title: "Assign"),
      // ),
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     SizedBox(
      //       height: 5,
      //     ),
      //     Text(
      //       "Select Wing",
      //       style: TextStyle(
      //           color: appPrimaryMaterialColor,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 15),
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      //       child: Container(
      //         height: 35,
      //         child: TabBar(
      //             controller: _tabController,
      //             labelPadding: EdgeInsets.only(left: 9.0, right: 9.0),
      //             // indicatorSize: TabBarIndicatorSize.label,
      //             unselectedLabelColor: Colors.grey[600],
      //             labelColor: Colors.white,
      //             isScrollable: true,
      //             indicatorColor: appPrimaryMaterialColor,
      //             indicator: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(8),
      //                 color: appPrimaryMaterialColor),
      //             onTap: (index) {},
      //             tabs: tabs),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     Expanded(
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: TabBarView(physics: BouncingScrollPhysics(), children: [
      //           for (int i = 0; i < wingList.length; i++) ...[
      //             Container(
      //               child: GridView.builder(
      //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                     crossAxisCount: 4),
      //                 itemBuilder: (_, index) => GestureDetector(
      //                   onTap: () {
      //                     print("${wingList[i]}-10${index}");
      //                   },
      //                   child: Card(
      //                     // color: isSelected == false
      //                     //     ? Colors.white
      //                     //     : appPrimaryMaterialColor,
      //                     child: new Center(
      //                       child: Transform.rotate(
      //                         angle: -math.pi / 4,
      //                         child: Text(
      //                           "${wingList[i]}-10${index}",
      //                           style: TextStyle(
      //                             color: appPrimaryMaterialColor,
      //                             fontWeight: FontWeight.bold,
      //                             fontSize: 14,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 // itemCount: 8,
      //                 itemCount: wingList.length,
      //               ),
      //             ),
      //           ],
      //         ]),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 5, right: 5),
      //       child: MyButton(
      //         onPressed: () {
      //           showModalBottomSheet(
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(10.0),
      //               ),
      //               context: context,
      //               builder: (builder) {
      //                 return Padding(
      //                   padding: const EdgeInsets.all(10.0),
      //                   child: BottomSheet(
      //                     wingList: wingList,
      //                   ),
      //                 );
      //               });
      //           print("hii");
      //         },
      //         title: "Assign",
      //       ),
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //   ],
      // ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  List parkingSlot;
  String flatId;
  String wingId;
  Function getAllFlat;

  BottomSheet({
    this.parkingSlot,
    this.flatId,
    this.wingId,
    this.getAllFlat,
  });

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  bool isLoading = false;
  List selectedList = [];
  List parkingList = [];
  ScrollController controller = new ScrollController();

  _assignParkingSlot() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
          "flatId": widget.flatId,
          "parkingSlotId": parkingList,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/admin/assignParkingSlots", body: body)
            .then((responseData) {
              print(responseData.Data);
          if (responseData.Data == 1) {
            setState(() {
              // pollingDataList = responseData.Data;
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "Your Parking Slot Assign Successfully",
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity: ToastGravity.TOP,
            );
            widget.getAllFlat();
            Navigator.pop(context);
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
    return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      // height: 700,
      color: Colors.transparent,
      child: widget.parkingSlot.length > 0
          ? Container(
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     FlatButton(
                  //       color:
                  //           isSelectedWing ? appPrimaryMaterialColor : Colors.white,
                  //       child: Text(
                  //         "Wing Select",
                  //         style: TextStyle(
                  //             color: isSelectedWing
                  //                 ? Colors.white
                  //                 : appPrimaryMaterialColor),
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           isSelectedWing = true;
                  //           print("t");
                  //         });
                  //       },
                  //     ),
                  //     FlatButton(
                  //       color:
                  //           isSelectedWing ? Colors.white : appPrimaryMaterialColor,
                  //       child: Text(
                  //         "Flat Select",
                  //         style: TextStyle(
                  //             color: isSelectedWing
                  //                 ? appPrimaryMaterialColor
                  //                 : Colors.white),
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           isSelectedWing = false;
                  //           print("f");
                  //         });
                  //       },
                  //     ),
                  //     // TextButton(
                  //     //   style: TextButton.styleFrom(
                  //     //     backgroundColor: isSelectedWing ? appPrimaryMaterialColor : Colors.white,
                  //     //   ),
                  //     //   // color: isSelectedWing ? appPrimaryMaterialColor : Colors.white,
                  //     //   child: Text(
                  //     //     "Wing Select",
                  //     //     style: TextStyle(
                  //     //         color: isSelectedWing ? Colors.white : appPrimaryMaterialColor),
                  //     //   ),
                  //     //   onPressed: () {
                  //     //     setState(() {
                  //     //       isSelectedWing = true;
                  //     //     });
                  //     //   },
                  //     // ),
                  //     // TextButton(
                  //     //   style: TextButton.styleFrom(
                  //     //     backgroundColor: isSelectedWing ? Colors.white : appPrimaryMaterialColor,
                  //     //   ),
                  //     //   // color: isSelectedWing ? Colors.white : appPrimaryMaterialColor,
                  //     //   child: Text(
                  //     //     "Flat Select",
                  //     //     style: TextStyle(
                  //     //         color: isSelectedWing ? appPrimaryMaterialColor : Colors.white),
                  //     //   ),
                  //     //   onPressed: () {
                  //     //     setState(() {
                  //     //       isSelectedWing = false;
                  //     //     });
                  //     //   },
                  //     // ),
                  //   ],
                  // ),
                  Text(
                    "Parking Slots",
                    style: TextStyle(
                      color: appPrimaryMaterialColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // isSelectedWing
                  //     ? Expanded(
                  //         child: GridView.builder(
                  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //               crossAxisCount: 5),
                  //           itemBuilder: (_, index) => GestureDetector(
                  //             onTap: () {},
                  //             child: Card(
                  //                 child: Center(
                  //               child: Text(
                  //                 "${widget.wingList[index]}",
                  //                 style: TextStyle(
                  //                   color: appPrimaryMaterialColor,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 13,
                  //                 ),
                  //               ),
                  //             )),
                  //           ),
                  //           itemCount: widget.wingList.length,
                  //         ),
                  //       )
                  //     :
                  Expanded(
                    child: Scrollbar(
                      thickness: 3,
                      isAlwaysShown: true,
                      controller: controller,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          controller: controller,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              print(selectedList);
                            },
                            child: GridItem(
                              item: widget.parkingSlot[index],
                              isSelected: (bool value) {
                                setState(() {
                                  if (value) {
                                    selectedList.add(
                                        widget.parkingSlot[index]["parkingNo"]);
                                    parkingList
                                        .add(widget.parkingSlot[index]["_id"]);
                                  } else {
                                    selectedList.remove(
                                        widget.parkingSlot[index]["parkingNo"]);
                                    parkingList.remove(
                                        widget.parkingSlot[index]["_id"]);
                                  }
                                });
                                print(selectedList);
                                print(parkingList);
                              },
                            ),
                          ),
                          itemCount: widget.parkingSlot.length,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 24.0, right: 10, left: 10, bottom: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: RaisedButton(
                        child: Text("Asign",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        color: appPrimaryMaterialColor,
                        onPressed: () {
                          if (parkingList.length > 0) {
                            _assignParkingSlot();
                          } else {
                            Fluttertoast.showToast(
                              gravity: ToastGravity.TOP,
                              textColor: Colors.white,
                              backgroundColor: Color(0xFFFF4F4F),
                              msg: "Please Select at least one Parking Slot",
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Text("No Parking Slots Found"),
            ),
    );
  }
}

class GridItem extends StatefulWidget {
  final Key key;
  var item;
  final ValueChanged<bool> isSelected;

  GridItem({this.item, this.isSelected, this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      child: Stack(
        children: <Widget>[
          isSelected
              ? Align(
                  alignment: Alignment.center,
                  child: Card(
                    color: widget.item["FlatData"].length > 0 ? Colors.green :  appPrimaryMaterialColor,
                    child: widget.item["FlatData"].length > 0
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "${widget.item["parkingNo"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "${widget.item["FlatData"][0]["WingData"][0]["wingName"]}-${widget.item["FlatData"][0]["flatNo"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text(
                              "${widget.item["parkingNo"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                  ),
                )
              : Align(
                  alignment: Alignment.center,
                  child: Card(
                    color: widget.item["FlatData"].length > 0 ? Colors.green : Colors.white,
                    child: widget.item["FlatData"].length > 0
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "${widget.item["parkingNo"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "${widget.item["FlatData"][0]["WingData"][0]["wingName"]}-${widget.item["FlatData"][0]["flatNo"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text(
                              "${widget.item["parkingNo"]}",
                              style: TextStyle(
                                color: appPrimaryMaterialColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                  ),
                )
        ],
      ),
    );
  }
}
