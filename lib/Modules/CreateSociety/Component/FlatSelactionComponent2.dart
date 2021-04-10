import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class FlatSelactionComponent2 extends StatefulWidget {
  var floorData;
  Function onChange;

  FlatSelactionComponent2({
    this.floorData,
    this.onChange,
  });

  @override
  _FlatSelactionComponent2State createState() =>
      _FlatSelactionComponent2State();
}

class _FlatSelactionComponent2State extends State<FlatSelactionComponent2> {
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
