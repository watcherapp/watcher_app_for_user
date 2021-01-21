import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';

class MyTextFormField extends StatelessWidget {
  String hintText;
  String lable;
  TextInputType keyboardType;
  Icon icon;
  int maxLength;
  TextEditingController controller;
  bool isPassword;

  MyTextFormField({
    this.keyboardType,
    this.hintText,
    this.maxLength,
    this.icon,
    this.lable,
    this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:4.0,bottom: 4.0),
            child: Text(lable ?? "",style: fontConstants.formFieldLabel),
          ),
          TextFormField(

            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 13),
            maxLength: maxLength,
            obscureText: isPassword,
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              filled: true,
              hintText: "${hintText??""}",
              hintStyle: TextStyle(
                fontSize: 13,
              ),

              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding:
                  EdgeInsets.only(left: 15, right: 8, top: 4, bottom: 4),
              counterText: "",
              prefixIcon: icon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
