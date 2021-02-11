import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watcher_app_for_user/Common/Custom_Icons.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyBottomBar.dart';
import 'package:watcher_app_for_user/ui/Screens/User/SubScreens/UserHomeScreen.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          Card(
            //semanticContainer: true,
            //clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.network(
              "https://i.imgur.com/ZtdhrUA.jpeg",
              fit: BoxFit.contain,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            elevation: 2,
            margin: EdgeInsets.all(4),
          ),
          UserHomeScreen()
        ],
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }
}
