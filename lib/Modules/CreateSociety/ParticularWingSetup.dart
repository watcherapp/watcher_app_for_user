import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/SetupWingsFinalStep.dart';

class ParticularWingSetup extends StatefulWidget {
  var wingName, societyId;

  ParticularWingSetup({this.wingName, this.societyId});

  @override
  _ParticularWingSetupState createState() => _ParticularWingSetupState();
}

class _ParticularWingSetupState extends State<ParticularWingSetup> {
  TextEditingController txtWingName = new TextEditingController();
  TextEditingController txtTotalFloor = new TextEditingController();
  TextEditingController txtUnitPerWing = new TextEditingController();
  TextEditingController txtParkingSpot = new TextEditingController();
  int currentIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey();
  String wingName;
  List flatNoFormatList = [
    {
      "Id": 1,
      "numbers": ["301", "302", "303", "201", "202", "203", "101", "102", "103"]
    },
    {
      "Id": 2,
      "numbers": ["7", "8", "9", "4", "5", "6", "1", "2", "3"]
    },
    {
      "Id": 3,
      "numbers": ["201", "202", "203", "101", "102", "103", "G1", "G2", "G3"]
    },
    {
      "Id": 4,
      "numbers": ["4", "5", "6", "1", "2", "3", "G1", "G2", "G3"]
    },
  ];

  setData() {
    setState(() {
      wingName = widget.wingName;
      txtWingName.text = widget.wingName;
    });
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wing - $wingName"),
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
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                MyTextFormField(
                    controller: txtWingName,
                    lable: "Wing Name",
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (value) {
                      setState(() {
                        wingName = value;
                      });
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter WingName";
                      }
                      return null;
                    },
                    hintText: "Enter WingName"),
                MyTextFormField(
                    controller: txtTotalFloor,
                    keyboardType: TextInputType.number,
                    lable: "Total Floor",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Total Number of Floor";
                      }
                      return null;
                    },
                    hintText: "Enter Total Floor"),
                MyTextFormField(
                    controller: txtUnitPerWing,
                    keyboardType: TextInputType.number,
                    lable: "Units Per Floor",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Unit per Floor";
                      }
                      return null;
                    },
                    hintText: "Enter Unit Per Floor"),
                MyTextFormField(
                    controller: txtParkingSpot,
                    keyboardType: TextInputType.number,
                    lable: "Parking Spots",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Parking Spots";
                      }
                      return null;
                    },
                    hintText: "Enter Parking Spots"),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text("Choose Flat Number Format",
                      style: fontConstants.formFieldLabel),
                ),
                SizedBox(
                  height: 15,
                ),
                GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: flatNoFormatList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.6,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0),
                  itemBuilder: (BuildContext context, int index) {
                    List flatlist = flatNoFormatList[index]["numbers"];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      child: Container(
                        decoration: currentIndex == index
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                    width: 1.5, color: appPrimaryMaterialColor),
                              )
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              childAspectRatio: 1.6,
                              children: flatlist.map((value) {
                                return Padding(
                                  padding: const EdgeInsets.all(0.5),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(child: Text("$value")),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300])),
                                );
                              }).toList()),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
                  child: MyButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: SetupWingsFinalStep(
                                      societyId: widget.societyId,
                                      wingName: wingName,
                                      flatFormatId: currentIndex,
                                      parkingSpot: txtParkingSpot.text,
                                      totalFloor: int.parse(txtTotalFloor.text),
                                      totalCountPerFloor:
                                          int.parse(txtUnitPerWing.text)),
                                  type: PageTransitionType.rightToLeft));
                        }
                      },
                      title: "Next"),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }
}
