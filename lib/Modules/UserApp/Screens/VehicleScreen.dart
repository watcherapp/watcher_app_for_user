import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 15,
              padding:
                  EdgeInsets.only(top: 25, left: 11, right: 11, bottom: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 3.5,
                  mainAxisSpacing: 3.0),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 6, top: 8),
                  child: Transform(
                    transform: Matrix4.skewY(0.3)..rotateZ(3.14 / 4.0),
                    child: Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DottedBorder(
                            color: Colors.grey,
                            dashPattern: [4],
                            //padding: EdgeInsets.all(6.0),
                            child: Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(30),
                                  shape: BoxShape.rectangle,

                                  /* border: Border.all(
                                              width: 0.2,
                                              color: appPrimaryMaterialColor),*/
                                ),
                                child: Center(
                                  child: MyVerticleText(
                                    text: "A25",
                                  ),
                                ))),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class MyVerticleText extends StatelessWidget {
  final String text;
  MyVerticleText({this.text});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 30,
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      children: text
          .split("")
          .map((string) => Text(string, style: TextStyle(fontSize: 9)))
          .toList(),
    );
  }
}