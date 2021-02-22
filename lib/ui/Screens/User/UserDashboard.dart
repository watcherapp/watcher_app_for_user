import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Common/Custom_Icons.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/CommonWidgets/BottomNavigationBarWithFab.dart';
import 'package:watcher_app_for_user/FloatingCenterBottomBar.dart';
import 'package:watcher_app_for_user/Common/ClassList.dart';
import 'package:watcher_app_for_user/ui/Screens/User/SubScreens/MyWacther.dart';
import 'package:watcher_app_for_user/ui/Screens/User/SubScreens/UsersVisitorlist.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int currentIndex = 1;
  List<Widget> _list = [];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _list[currentIndex],
      bottomNavigationBar: BottomNavigationBarWithFab(
          selectedColor: appPrimaryMaterialColor,
          height: 56,
          items: [
            BottomBarItem(icon: Icons.add_circle_outline_sharp, title: "Hello"),
            BottomBarItem(icon: Icons.add_circle_outline_sharp, title: "Hello"),
            BottomBarItem(icon: Icons.add_circle_outline_sharp, title: "Hello"),
            BottomBarItem(icon: Icons.add_circle_outline_sharp, title: "Hello"),
          ]),
    );
  }
}
