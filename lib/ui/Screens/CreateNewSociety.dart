import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/DialogOpenFormField.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyButton.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/Popups/MyDropdown.dart';
import 'package:watcher_app_for_user/ui/Screens/SetupWings.dart';

class CreateNewSociety extends StatefulWidget {
  @override
  _CreateNewSocietyState createState() => _CreateNewSocietyState();
}

class _CreateNewSocietyState extends State<CreateNewSociety> {
  String selectedSocietyType, selectedCountry, selctedState, selectedCity;
  List societyTypeList = [
    "Buildings (Multiple Floors)",
    "Society (Single Floor)",
    "Commercial",
  ];

  List country = ["USA", "India", "Pakistan"];

  List states = ["Gujrat", "Maharastra", "Utter Pradesh"];

  List city = ["Surat", "Rajkot", "Navsari"];

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
                  value: selectedSocietyType,
                  onTap: () {
                    // print("click");
                    FocusScope.of(context).unfocus();
                    showDialog(
                      context: context,
                      child: MyDropDown(
                          dropDownTitle: "Society Type",
                          dropDownData: societyTypeList,
                          onSelectValue: (value) {
                            setState(() {
                              selectedSocietyType = value;
                            });
                          }),
                    );
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
              MyTextFormField(
                  lable: "Total Wings",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Total Wings";
                    }
                    return "";
                  },
                  hintText: "Enter Total Wings"),
              DialogOpenFormField(
                  lable: "Select Country",
                  value: selectedCountry,
                  onTap: () {
                    // print("click");
                    FocusScope.of(context).unfocus();
                    showDialog(
                      context: context,
                      child: MyDropDown(
                          dropDownTitle: "Select Country",
                          dropDownData: country,
                          onSelectValue: (value) {
                            setState(() {
                              selectedCountry = value;
                            });
                          }),
                    );
                  }),
              DialogOpenFormField(
                  lable: "Select State",
                  value: selctedState,
                  onTap: () {
                    // print("click");
                    FocusScope.of(context).unfocus();
                    showDialog(
                      context: context,
                      child: MyDropDown(
                          dropDownTitle: "Select State",
                          dropDownData: states,
                          onSelectValue: (value) {
                            setState(() {
                              selctedState = value;
                            });
                          }),
                    );
                  }),
              DialogOpenFormField(
                  lable: "Select City",
                  value: selectedCity,
                  onTap: () {
                    // print("click");
                    FocusScope.of(context).unfocus();
                    showDialog(
                      context: context,
                      child: MyDropDown(
                          dropDownTitle: "Select City",
                          dropDownData: city,
                          onSelectValue: (value) {
                            setState(() {
                              selectedCity = value;
                            });
                          }),
                    );
                  }),
              MyButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: SetupWings(),
                            type: PageTransitionType.fade));
                  },
                  title: "Submit"),
            ],
          ),
        ),
      ),
    );
  }
}
