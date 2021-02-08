import 'dart:math';

import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  ScrollController controller = new ScrollController();
  List<Widget> myRowChildren = [];
  List<List> numbers = [];
  List flatList = [];
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
  }

  createWing() {
    int z = 1;
    for (int i = 0; i < 2; i++) {
      int maxColNr = 4;
      for (int y = 0; y < maxColNr; y++) {
        int currentNumber = z + y;
        // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
        flatList.add("A" + "$currentNumber");
      }
      z += maxColNr;
      numbers.add(flatList);
      flatList = [];
    }
    print(numbers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Scrollbar(
          controller: controller,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: controller,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: myRowChildren,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
