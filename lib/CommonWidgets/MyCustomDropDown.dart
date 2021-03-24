import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';

class MyCustomDropDown extends StatefulWidget {
  String lable;
  String hintText;
  String value;
  String displayName;
  String hiddenValue;
  List myListValue;
  Function functionName;

  MyCustomDropDown({
    this.lable,
    this.value,
    this.myListValue,
    this.displayName,
    this.hiddenValue,
    this.hintText,
    this.functionName,
  });

  @override
  _MyCustomDropDownState createState() => _MyCustomDropDownState();
}

class _MyCustomDropDownState extends State<MyCustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
          child: Text(widget.lable ?? "", style: fontConstants.formFieldLabel),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0)),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: widget.value,
                  iconSize: 30,
                  icon: (null),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                  hint: Text(
                    '${widget.hintText}',
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      var locality = '';
                      widget.value = newValue;
                      locality = newValue.toString();
                      print(widget.value);
                      widget.functionName;
                    });
                  },
                  items: widget.myListValue?.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item[widget.displayName]),
                          value: item[widget.hiddenValue].toString(),
                        );
                      })?.toList() ??
                      [],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
