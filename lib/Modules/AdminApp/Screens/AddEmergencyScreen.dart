import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';

class AddEmergencyScreen extends StatefulWidget {
  @override
  _AddEmergencyScreenState createState() => _AddEmergencyScreenState();
}

class _AddEmergencyScreenState extends State<AddEmergencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Emergency",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Padding(
        padding: paddingConstant.authScreenContentPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextFormField(
                lable: "Emergency Name", hintText: "Enter Emergency name"),
            MyTextFormField(
                lable: "Emergency Number", hintText: "Enter Emergency number"),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Image",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                height: 170,
                child: DottedBorder(
                    color: Colors.grey,
                    dashPattern: [4],
                    padding: EdgeInsets.all(6.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.black38,
                          ),
                          Text(
                            "Add Photo",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: MyButton(
                onPressed: () {},
                title: "Add",
              ),
            )
          ],
        ),
      ),
    );
  }
}
