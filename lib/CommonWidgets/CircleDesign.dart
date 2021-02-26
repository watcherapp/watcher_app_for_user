import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Shapes/CircleShape.dart';

class CircleDesign extends StatelessWidget {
  String title;
  bool backbutton = false;
  double size;
  Widget child;
  CircleDesign({this.title, this.backbutton, this.size, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 150,
      child: Stack(fit: StackFit.expand, children: [
        if (backbutton == true) ...[
          Positioned(
              top: 35,
              left: 8,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }))
        ],
        Positioned(
            bottom: 30,
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
        Positioned(child: child ?? SizedBox(), right: 12, top: 5),
      ]),
    );
  }
}
