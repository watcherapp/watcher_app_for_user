import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class MyButton extends StatelessWidget {
  VoidCallback onPressed;
  String title;
  FocusNode focusNode;

  MyButton({@required this.onPressed, this.title, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: RaisedButton(
            focusNode: focusNode,
            child: Text("${title ?? ""}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: appPrimaryMaterialColor,
            onPressed: onPressed),
      ),
    );
  }
}




