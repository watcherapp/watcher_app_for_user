import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/BottomNavigationBarCustomForAdmin.dart';

class MyWatcherScreen extends StatefulWidget {
  @override
  _MyWatcherScreenState createState() => _MyWatcherScreenState();
}

class _MyWatcherScreenState extends State<MyWatcherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   elevation: 0.5,
      //   centerTitle: true,
      //   title: Text(
      //     "Hey, " + "${sharedPrefs.memberName}",
      //     style: TextStyle(color: Colors.black, fontSize: 17),
      //   ),
      // ),
      body: Container(
        child: Center(
          child: Text(
            "Watcher",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),
    );
  }
}
