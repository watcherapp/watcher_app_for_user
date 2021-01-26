import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyTextFormField.dart';

class MyDropDown extends StatefulWidget {
  String dropDownTitle;
  List dropDownData = [];
  Function onSelectValue;

  MyDropDown({this.dropDownTitle, this.dropDownData, this.onSelectValue});

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 15, left: 20.0, right: 22),
            child: Row(
              children: [
                GestureDetector(
                    child: Icon(Icons.backspace_rounded,
                        size: 22, color: appPrimaryMaterialColor),
                    onTap: () {}),
                Expanded(
                  child: Center(
                    child: Text("Select ${widget.dropDownTitle ?? ""}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: appPrimaryMaterialColor)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.grey[400],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 8.0),
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                prefixIcon: Icon(Icons.search_outlined, size: 20),
                hintText: "Search",
                hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                contentPadding:
                    EdgeInsets.only(left: 15, right: 8, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.dropDownData.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    widget.onSelectValue(widget.dropDownData[index]);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 16, bottom: 12.0),
                    child: Text(widget.dropDownData[index],
                        style: TextStyle(fontSize: 15, color: Colors.black87)),
                  ),
                );
              }),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
