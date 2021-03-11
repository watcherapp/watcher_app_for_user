import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class BloodRequestScreen extends StatefulWidget {
  @override
  _BloodRequestScreenState createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  List bloodGroupList = [
    "A+",
    "B+",
    "AB+",
    "O+",
    "A-",
    "B-",
    "AB-",
    "O-",
  ];
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text("Blood Request"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Select Blood Group",
                style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 50,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (_, index) => Card(
                      color: isSelected == false
                          ? Colors.white
                          : appPrimaryMaterialColor,
                      child: new Center(
                        child: new Text(
                          bloodGroupList[index],
                          style: TextStyle(
                            color: isSelected == true
                                ? Colors.white
                                : appPrimaryMaterialColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      )),
                  itemCount: 8,
                ),
              ),
              MyTextFormField(
                  lable: "Hospital Name",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Hospital Name";
                    }
                    return "";
                  },
                  hintText: "Enter Hospital Name"),
              SizedBox(
                height: 3,
              ),
              MyTextFormField(
                  lable: "Hospital Email",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Hospital Email";
                    }
                    return "";
                  },
                  hintText: "Enter Hospital Email"),
              SizedBox(
                height: 3,
              ),
              MyTextFormField(
                  lable: "Hospital Contect No",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Hospital Contect No";
                    }
                    return "";
                  },
                  hintText: "Enter Hospital Contect No"),
              SizedBox(
                height: 3,
              ),
              MyTextFormField(
                  lable: "Hospital Address",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Hospital Address";
                    }
                    return "";
                  },
                  hintText: "Enter Hospital Address"),
              MyButton(
                onPressed: () {},
                title: "Make Blood Request",
              ),
              Expanded(
                  flex: 10,
                  child: SizedBox(
                    height: 10,
                  )),
            ],
          ),
        ));
  }
}
