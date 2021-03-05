import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/EmergencyComponent.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AddEmergencyScreen.dart';

class EmergencyScreen extends StatefulWidget {
  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Emergency",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: ListView.builder(
          padding: EdgeInsets.only(top: 5, bottom: 18),
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return EmergencyComponent();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: FloatingActionButton(
          // isExtended: true,
          child: Icon(
            Icons.add,
            size: 26,
          ),
          backgroundColor: appPrimaryMaterialColor,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: AddEmergencyScreen(),
                    type: PageTransitionType.rightToLeft));
            setState(() {});
          },
        ),
      ),
    );
  }
}
