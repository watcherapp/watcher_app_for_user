import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/CommonWidgets/FlatStatusColorsWithLabel.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/Component/FlatSelectionComponent.dart';

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
          // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
          flatList.add({"flatNo": currentNumber, "flatStatus": "Owner"});
        }
        flatNo = flatNo + 100;
        // z += maxFlatPerFloor;
        numbers.add(flatList);
        flatList = [];
      }
    } else if (widget.flatFormatId == 1) {
      int flatNo = 1;
      for (int i = 0; i < widget.totalFloor; i++) {
        int maxFlatPerFloor = widget.totalCountPerFloor;
        for (int j = 0; j < maxFlatPerFloor; j++) {
          int currentNumber = flatNo + j;
          flatList.add({"flatNo": currentNumber, "flatStatus": "Owner"});
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
            flatList.add({"flatNo": "G" + "${j + 1}", "flatStatus": "Owner"});
            // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
          }
        } else {
          for (int j = 0; j < maxFlatPerFloor; j++) {
            int currentNumber = flatNo + j;
            flatList.add({"flatNo": currentNumber, "flatStatus": "Owner"});
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
            flatList.add({"flatNo": "G" + "${j + 1}", "flatStatus": "Owner"});
          }
        } else {
          for (int j = 0; j < maxFlatPerFloor; j++) {
            int currentNumber = flatNo + j;
            flatList.add({"flatNo": currentNumber, "flatStatus": "Owner"});
          }
          flatNo += maxFlatPerFloor;
        }
        numbers.add(flatList);
        flatList = [];
      }
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
        child: MyButton(onPressed: () {}, title: "Finish"),
      ),
    );
  }
}
