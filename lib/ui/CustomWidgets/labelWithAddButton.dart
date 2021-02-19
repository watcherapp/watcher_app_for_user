import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';

class LabelWithAddButton extends StatelessWidget {
  Function onPressed;
  String title;
  Icon icon;
  LabelWithAddButton(
      {@required this.onPressed, @required this.icon, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0),
      child: Row(
        children: [
          icon,
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$title", style: fontConstants.titleFonts),
          )),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange[200],
                  borderRadius: BorderRadius.circular(4.0)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline_sharp,
                      size: 15,
                      color: appPrimaryMaterialColor,
                    ),
                    Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: appPrimaryMaterialColor),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
