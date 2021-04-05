import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class FlatStatusColorsWithLabel extends StatefulWidget {
  @override
  _FlatStatusColorsWithLabelState createState() =>
      _FlatStatusColorsWithLabelState();
}

class _FlatStatusColorsWithLabelState extends State<FlatStatusColorsWithLabel> {
  List dataList = [
    {"label": "Dead", "Color": Colors.grey},
    {"label": "Closed", "Color": Colors.redAccent},
    {"label": "Rent", "Color": Colors.lightGreen},
    {"label": "Owner", "Color": appPrimaryMaterialColor},
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dataList.map((data) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: data["Color"],
                        borderRadius: BorderRadius.circular(4.0)),
                    height: 15,
                    width: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    "${data["label"]}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
