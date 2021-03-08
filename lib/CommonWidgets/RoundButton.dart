import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  String imageName, actionName;

  RoundButton({this.imageName, this.actionName});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "${imageName}",
          width: 70,
        ),
        Text(
          "${actionName}",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
