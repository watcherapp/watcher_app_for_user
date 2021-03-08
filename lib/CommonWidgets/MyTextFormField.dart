import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';

class MyTextFormField extends StatelessWidget {
  String hintText;
  String lable;
  TextInputType keyboardType;
  FormFieldValidator<String> validator;
  int maxLength;
  FocusNode focusNode;
  Widget hideShowText;
  TextCapitalization textCapitalization = TextCapitalization.none;
  ValueChanged<String> onChanged;
  ValueChanged<String> onFieldSubmitted;
  TextEditingController controller;
  TextInputAction textInputAction;
  bool isPassword;
  Widget icon;
  int maxLines;

  MyTextFormField({
    this.keyboardType,
    this.hintText,
    this.maxLength,
    this.lable,
    this.focusNode,
    this.controller,
    this.isPassword = false,
    this.validator,
    this.textCapitalization,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onChanged,
    this.hideShowText,
    this.maxLines,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(lable ?? "", style: fontConstants.formFieldLabel),
          ),
          TextFormField(
            controller: controller,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 15),
            maxLength: maxLength,
            focusNode: focusNode,
            onChanged: onChanged,
            validator: validator,
            textInputAction: textInputAction,
            obscureText: isPassword,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              filled: true,
              hintText: "${hintText ?? ""}",
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding:
                  EdgeInsets.only(left: 15, right: 8, top: 4, bottom: 4),
              counterText: "",
              suffix: hideShowText,
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
