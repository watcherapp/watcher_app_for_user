import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/DialogOpenFormField.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/Popups/MyDropdown.dart';

class CreateNewSociety extends StatefulWidget {
  @override
  _CreateNewSocietyState createState() => _CreateNewSocietyState();
}

class _CreateNewSocietyState extends State<CreateNewSociety> {
  List societyTypeList = [
    "Buildings (Multiple Floors)",
    "Society (Single Floor)",
    "Commercial",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Society"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingConstant.createSocietyScreenPadding,
          child: Column(
            children: [
              DialogOpenFormField(
                  lable: "Society Type",
                  onTap: () {
                    // print("click");
                    FocusScope.of(context).unfocus();
                    showDialog(
                        context: context,
                        child: MyDropDown(
                            dropDownTitle: "Society Type",
                            dropDownData: societyTypeList));
                  }),
              MyTextFormField(
                  lable: "Society Name",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Society Name";
                    }
                    return "";
                  },
                  hintText: "Enter Society Name"),
            ],
          ),
        ),
      ),
    );
  }
}
