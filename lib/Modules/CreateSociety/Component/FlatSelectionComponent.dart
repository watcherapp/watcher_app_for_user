import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class FlatSelectionComponent extends StatefulWidget {
  var floorData;
  Function onChange;

  FlatSelectionComponent({this.floorData, this.onChange});

  @override
  _FlatSelectionComponentState createState() => _FlatSelectionComponentState();
}

class _FlatSelectionComponentState extends State<FlatSelectionComponent> {
  int index = 3;

  List status = [
    {
      "color": Colors.grey,
      "status": 0,
    },
    {
      "color": Colors.redAccent,
      "status": 1,
    },
    {
      "color": Colors.lightGreen,
      "status": 2,
    },
    {"color": appPrimaryMaterialColor, "status": 3}
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 40,
        child: MaterialButton(
          color: status[index]["color"],
          onPressed: () {
            setState(() {
              if (index <= 2) {
                index++;
              } else {
                index = 0;
              }
            });
            widget.onChange(status[index]["status"]);
          },
          child: Text(
            widget.floorData["flatNo"].toString(),
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
