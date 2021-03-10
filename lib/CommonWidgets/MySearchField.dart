import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MySearchField extends StatefulWidget {
  String hintText;
  ValueChanged<String> onChanged;
  ValueChanged<String> onFieldSubmitted;
  TextEditingController controller;
  TextInputAction textInputAction;
  Widget icon;

  MySearchField({
    this.hintText,
    this.controller,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onChanged,
    this.icon,
  });

  @override
  _MySearchFieldState createState() => _MySearchFieldState();
}

class _MySearchFieldState extends State<MySearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,left: 5,right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            style: TextStyle(fontSize: 15),
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              filled: true,
              hintText: "${widget.hintText ?? ""}",
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding:
                  EdgeInsets.only(left: 15, right: 8, top: 4, bottom: 4),
              counterText: "",
              suffixIcon: widget.icon,
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
