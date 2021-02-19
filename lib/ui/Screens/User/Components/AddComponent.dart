import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddComponent extends StatelessWidget {
  Function onTap;
  double width;
  AddComponent({@required this.onTap, @required this.width});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 6.0, right: 10.0, bottom: 8.0, top: 8.0),
      child: DottedBorder(
          strokeWidth: 1,
          dashPattern: [4],
          radius: Radius.circular(10.0),
          borderType: BorderType.Rect,
          child: Container(
            width: width,
            child: Center(
              child: Icon(
                Icons.add_circle_outline_sharp,
                size: 20,
              ),
            ),
          )),
    );
  }
}
