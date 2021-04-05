import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AddPollingQuestion.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/PollingComponent.dart';

class PollingScreen extends StatefulWidget {
  @override
  _PollingScreenState createState() => _PollingScreenState();
}

class _PollingScreenState extends State<PollingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Polling",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: ListView.builder(
          padding: EdgeInsets.only(bottom: 15),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return PollingComponent();
          }),
    );
  }
}
