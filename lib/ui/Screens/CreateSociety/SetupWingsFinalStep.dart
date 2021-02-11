import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/FlatStatusColorsWithLabel.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyButton.dart';
import 'file:///E:/Keval%20Work/watcher_app_for_user/lib/ui/Screens/User/UserDashboard.dart';

class SetupWingsFinalStep extends StatefulWidget {
  int flatFormatId, totalFloor, totalCountPerFloor;
  String wingName;

  SetupWingsFinalStep(
      {this.flatFormatId,
      this.totalFloor,
      this.totalCountPerFloor,
      this.wingName});

  @override
  _SetupWingsFinalStepState createState() => _SetupWingsFinalStepState();
}

class _SetupWingsFinalStepState extends State<SetupWingsFinalStep> {
  List wingFlatData = [];
  final ScrollController _scrollController = new ScrollController();
  int rowsColumn = 0;
  int total;
  ScrollController controller = new ScrollController();
  List<Widget> myRowChildren = [];
  List<List> numbers = [];
  List flatList = [];
  int colorIndex = 0;
  List flatColorsList = [
    appPrimaryMaterialColor,
    Colors.grey,
    Colors.orange,
    Colors.black,
    Colors.blueAccent,
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
          // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
          flatList.add({
            "flatNo": currentNumber,
            "statusColor": flatColorsList[colorIndex]
          });
        }
        flatNo = flatNo + 100;
        // z += maxFlatPerFloor;
        numbers.add(flatList);
        flatList = [];
      }
      print(numbers);
    } else if (widget.flatFormatId == 1) {
      int flatNo = 1;
      for (int i = 0; i < widget.totalFloor; i++) {
        int maxFlatPerFloor = widget.totalCountPerFloor;
        for (int j = 0; j < maxFlatPerFloor; j++) {
          int currentNumber = flatNo + j;
          flatList.add({
            "flatNo": currentNumber,
            "statusColor": flatColorsList[colorIndex]
          });
          // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
        }
        flatNo += maxFlatPerFloor;
        numbers.add(flatList);
        flatList = [];
      }
      print(numbers);
    } else if (widget.flatFormatId == 2) {
      int flatNo = 101;
      for (int i = 0; i < widget.totalFloor; i++) {
        int maxFlatPerFloor = widget.totalCountPerFloor;
        if (i == 0) {
          for (int j = 0; j < maxFlatPerFloor; j++) {
            int currentNumber = flatNo + j;
            flatList.add({
              "flatNo": "G" + "${j + 1}",
              "statusColor": flatColorsList[colorIndex]
            });
            // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
          }
        } else {
          for (int j = 0; j < maxFlatPerFloor; j++) {
            int currentNumber = flatNo + j;
            flatList.add({
              "flatNo": currentNumber,
              "statusColor": flatColorsList[colorIndex]
            });
            // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
          }
          flatNo = flatNo + 100;
          // z += maxFlatPerFloor;
        }
        numbers.add(flatList);
        flatList = [];
      }
      print(numbers);
    } else {
      int flatNo = 1;
      for (int i = 0; i < widget.totalFloor; i++) {
        int maxFlatPerFloor = widget.totalCountPerFloor;
        if (i == 0) {
          for (int j = 0; j < maxFlatPerFloor; j++) {
            int currentNumber = flatNo + j;
            flatList.add({
              "flatNo": "G" + "${j + 1}",
              "statusColor": flatColorsList[colorIndex]
            });
          }
        } else {
          for (int j = 0; j < maxFlatPerFloor; j++) {
            int currentNumber = flatNo + j;
            flatList.add({
              "flatNo": currentNumber,
              "statusColor": flatColorsList[colorIndex]
            });
          }
          flatNo += maxFlatPerFloor;
        }
        numbers.add(flatList);
        flatList = [];
      }
      print(numbers);
    }
  }

  changeColor({int index}) {
    setState(() {
      int colorIndex = flatColorsList.indexOf(flatList[index]["statusColor"]);
      if (colorIndex <= 3)
        flatList[index]["statusColor"] = flatColorsList[colorIndex + 1];
      else
        flatList[index]["statusColor"] = flatColorsList[colorIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                        controller: controller,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: SingleChildScrollView(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            child: Column(
                                children: numbers.reversed
                                    .map(
                                      (columns) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: columns.map((floorData) {
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: SizedBox(
                                              height: 40,
                                              child: MaterialButton(
                                                color: floorData['statusColor'],
                                                onPressed: () {
                                                  setState(() {
                                                    if (colorIndex == 4) {
                                                      colorIndex = 0;
                                                      floorData["statusColor"] =
                                                          flatColorsList[
                                                              colorIndex];
                                                    } else {
                                                      colorIndex++;
                                                      floorData["statusColor"] =
                                                          flatColorsList[
                                                              colorIndex];
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  floorData["flatNo"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          );
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
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: UserDashboard(),
                      type: PageTransitionType.bottomToTop));
            },
            title: "Next"),
      ),
    );
  }
}
