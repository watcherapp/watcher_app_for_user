import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'dart:math' as math;

import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class ParkingScreen extends StatefulWidget {
  @override
  _ParkingScreenState createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  List wingList = [
    "A",
    "B",
    "C",
    "D",
    "E",
  ];
  List parkingList = [];
  List getAllWingList = [];
  List getAllFlatList = [];
  bool isSelected = false;
  bool isLoading = false;
  int selectedW = -1;
  int selectedF = -1;
  String flatId;

  TabController _tabController;
  List<Widget> tabs;

  @override
  void initState() {
    _getAllParkingSlot();
    _getAllWings();

    tabs = [
      for (int i = 0; i < wingList.length; i++) ...[
        Tab(
          child: Container(
            width: 70,
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
            _getAllFlats(wingId: getAllWingList[0]["_id"]);
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

  _getAllFlats({String wingId}) async {
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
                apiName: "api/society/getFlatsOfSocietyWing", body: body)
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

  //baki 6e haji.........................
  _getAllParkingSlot() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "wingId": sharedPrefs.wingId,
          "societyId": sharedPrefs.societyId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/getAllParkingSlots", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            setState(() {
              parkingList = responseData.Data;
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
          mainAxisSize: MainAxisSize.min,
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
                          _getAllFlats(wingId: getAllWingList[index]["_id"]);
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
                : Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              color: selectedF == index
                                  ? appPrimaryMaterialColor
                                  : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 10, right: 10, bottom: 8),
                                child: Align(
                                  alignment: Alignment.center,
                                  child:
                                      Text("${getAllFlatList[index]["flatNo"]}",
                                          style: TextStyle(
                                            color: selectedF == index
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
          child: MyButton(
              onPressed: () {
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
              },
              title: "Assign"),
        ),
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
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  List parkingSlot;
  String flatId;

  BottomSheet({
    this.parkingSlot,
    this.flatId,
  });

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  bool isLoading = false;
  List selectedList = [];

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
          "parkingSlotNo": selectedList,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/admin/assignParkingSlots", body: body)
            .then((responseData) {
          if (responseData.Data ==  1) {
            setState(() {
              // pollingDataList = responseData.Data;
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "Your Parking Slot Assign Successfully",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
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
      height: 400.0,
      color: Colors.transparent,
      child: Container(
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
            SizedBox(
              height: 20,
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
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {
                    print(selectedList);
                  },
                  child: GridItem(
                    item: widget.parkingSlot[index],
                    isSelected: (bool value) {
                      setState(() {
                        if (value) {
                          selectedList
                              .add(widget.parkingSlot[index]["parkingNo"]);
                        } else {
                          selectedList
                              .remove(widget.parkingSlot[index]["parkingNo"]);
                        }
                      });
                      print(selectedList);
                    },
                  ),
                ),
                itemCount: widget.parkingSlot.length,
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
                    _assignParkingSlot();
                  },
                ),
              ),
            ),
          ],
        ),
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
                    color: appPrimaryMaterialColor,
                    child: new Center(
                      child: new Text(
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
                    child: new Center(
                      child: new Text(
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
