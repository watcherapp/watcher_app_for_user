import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/FlatStatusColorsWithLabel.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/Component/FlatSelectionComponent.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/SetupWings.dart';

class SetupWingsFinalStep extends StatefulWidget {
  int flatFormatId, totalFloor, totalCountPerFloor;
  String wingName, societyId, parkingSpot;
  var wingCount,wingId;

  SetupWingsFinalStep({
    this.flatFormatId,
    this.totalFloor,
    this.totalCountPerFloor,
    this.wingName,
    this.societyId,
    this.parkingSpot,
    this.wingCount,
    this.wingId,
  });

  @override
  _SetupWingsFinalStepState createState() => _SetupWingsFinalStepState();
}

class _SetupWingsFinalStepState extends State<SetupWingsFinalStep> {
  List wingFlatData = [];
  String errorText;
  final ScrollController _scrollController = new ScrollController();
  int rowsColumn = 0;
  int total;
  ScrollController controller = new ScrollController();
  List<Widget> myRowChildren = [];
  List<List> numbers = [];
  List finalFlatList = [];
  List flatList = [];
  int colorIndex = 0;
  List flatColorsList = [
    appPrimaryMaterialColor,
    Colors.lightGreen,
    Colors.orange,
    Colors.red[300]
  ];

  @override
  void initState() {
    createWing();
    //total = widget.totalFloor * widget.totalCountPerFloor;
    // createGridFlatList();
  }

  createWing() {
    if (widget.flatFormatId == 0) {
      int flatNo = 101;
      for (int i = 0; i < widget.totalFloor; i++) {
        int maxFlatPerFloor = widget.totalCountPerFloor;
        for (int y = 0; y < maxFlatPerFloor; y++) {
          int currentNumber = flatNo + y;
          print("floor No ${i + 1}");
          // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
          flatList.add({
            "flatNo": currentNumber,
            "floorNo": "${i + 1}",
            "flatStatus": 3
          });
        }
        flatNo = flatNo + 100;
        // z += maxFlatPerFloor;
        numbers.add(flatList);
        flatList = [];
      }

      log(numbers.toString());
    } else if (widget.flatFormatId == 1) {
      int flatNo = 1;
      for (int i = 0; i < widget.totalFloor; i++) {
        int maxFlatPerFloor = widget.totalCountPerFloor;
        for (int j = 0; j < maxFlatPerFloor; j++) {
          int currentNumber = flatNo + j;
          flatList.add({
            "flatNo": currentNumber,
            "floorNo": "${i + 1}",
            "flatStatus": 3
          });
          // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
        }
        flatNo += maxFlatPerFloor;
        numbers.add(flatList);
        flatList = [];
      }
    } else if (widget.flatFormatId == 2) {
      int flatNo = 101;
      for (int i = 0; i < widget.totalFloor; i++) {
        int maxFlatPerFloor = widget.totalCountPerFloor;
        if (i == 0) {
          for (int j = 0; j < maxFlatPerFloor; j++) {
            int currentNumber = flatNo + j;
            flatList.add({
              "flatNo": "G" + "${j + 1}",
              "floorNo": "${i}",
              "flatStatus": 3
            });
            // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
          }
        } else {
          for (int j = 0; j < maxFlatPerFloor; j++) {
            int currentNumber = flatNo + j;
            flatList.add({
              "flatNo": currentNumber,
              "floorNo": "${i + 1}",
              "flatStatus": 3
            });
            // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
          }
          flatNo = flatNo + 100;
          // z += maxFlatPerFloor;
        }
        numbers.add(flatList);
        flatList = [];
      }
    } else {
      int flatNo = 1;
      for (int i = 0; i < widget.totalFloor; i++) {
        int maxFlatPerFloor = widget.totalCountPerFloor;
        if (i == 0) {
          for (int j = 0; j < maxFlatPerFloor; j++) {
            int currentNumber = flatNo + j;
            flatList.add({
              "flatNo": "G" + "${j + 1}",
              "floorNo": "${i}",
              "flatStatus": 3
            });
          }
        } else {
          for (int j = 0; j < maxFlatPerFloor; j++) {
            int currentNumber = flatNo + j;
            flatList.add({
              "flatNo": currentNumber,
              "floorNo": "${i + 1}",
              "flatStatus": 3
            });
          }
          flatNo += maxFlatPerFloor;
        }
        numbers.add(flatList);
        flatList = [];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setup Wing"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              FlatStatusColorsWithLabel(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Scrollbar(
                    thickness: 3,
                    isAlwaysShown: true,
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, left: 4.0, right: 4.0),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        controller: controller,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            child: Column(
                                children: numbers.reversed
                                    .map(
                                      (columns) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: columns.map((floorData) {
                                          int index =
                                              columns.indexOf(floorData);
                                          print(index);
                                          return FlatSelectionComponent(
                                              floorData: floorData,
                                              onChange: (value) {
                                                setState(() {
                                                  columns[index]["flatStatus"] =
                                                      value;
                                                });
                                                log(numbers.toString());
                                              });
                                        }).toList(),
                                      ),
                                    )
                                    .toList()),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
        child: MyButton(
            onPressed: () {
              List tempList = [];
              tempList.clear();
              for (int i = 0; i < numbers.length; i++) {
                for (int j = 0; j < numbers[i].length; j++) {
                  tempList.add(numbers[i][j]);
                }
              }
              setState(() {
                finalFlatList = tempList;
              });
              _setupWing();
            },
            title: "Finish"),
      ),
    );
  }

  _setupWing() async {
    try {
      LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(widget.wingId);
        var body = {
          "secretaryId": "${sharedPrefs.memberId}",
          "societyId": "${widget.societyId}",
          "wingName": "${widget.wingName}",
          "wingId": "${widget.wingId}",
          "totalFloor": "${widget.totalFloor}",
          "maxUnitPerFloor": "${widget.totalCountPerFloor}",
          "totalParkingSpot": "${widget.parkingSpot}",
          "flatList": finalFlatList
        };
        log("$body");
        Services.responseHandler(apiName: "api/society/setUpWing", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print("------------------->${responseData.Data}");
            LoadingIndicator.close(context);
            Fluttertoast.showToast(
                msg: "Wing Created Successfully !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                fontSize: 16.0);
            Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                    child: SetupWings(
                      societyId: widget.societyId,
                      wingsCount: widget.wingCount,
                      // isSetUp: responseData.Data,
                      // isSetUp: responseData.Data[0]["isSetup"],
                    ),
                    type: PageTransitionType.rightToLeft),
                (Route<dynamic> route) => false);
          } else {
            print(responseData);
            LoadingIndicator.close(context);
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          LoadingIndicator.close(context);
          Fluttertoast.showToast(
              msg: "$error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
