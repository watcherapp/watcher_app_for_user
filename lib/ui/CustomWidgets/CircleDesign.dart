import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';
import 'package:watcher_app_for_user/Shapes/CircleShape.dart';

class CircleDesign extends StatelessWidget {
  String title;

  CircleDesign({this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(fit: StackFit.expand, children: [
        Positioned(
            bottom: 40,
            left: 20,
            child: Text("${title ?? ""}", style: fontConstants.bigTitleWhite)),
        Positioned(
            right: 20,
            top: 6,
            child: Opacity(
                opacity: 0.1, child: CustomPaint(painter: DrawCircle()))),
        Positioned(
            right: -40,
            bottom: 25,
            child: Opacity(
                opacity: 0.1, child: CustomPaint(painter: DrawCircle()))),
      ]),
    );
  }
}
