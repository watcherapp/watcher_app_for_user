import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Common/Custom_Icons.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/FloatingCenterBottomBar.dart';
import 'package:watcher_app_for_user/ui/Screens/User/SubScreens/MyWacther.dart';
import 'package:watcher_app_for_user/ui/Screens/User/SubScreens/UsersVisitorlist.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int currentIndex = 3;
  List<Widget> _list = [
    Container(
      color: Colors.teal,
      child: Center(
        child: Text("Watcher"),
      ),
    ),
    Container(
      color: Colors.redAccent,
      child: Center(
        child: Text("Visitor"),
      ),
    ),
    Container(
      color: Colors.grey,
      child: Center(
        child: Text("Chat"),
      ),
    ),
    Container(
      color: Colors.amber,
      child: Center(
        child: Text("More"),
      ),
    ),
    Container(
      color: Colors.blueAccent,
      child: Center(
        child: Text("Home"),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    print(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _list[currentIndex],
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        onPressed: () {
          _onItemTapped(4);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FloatingCenterBottomBar(
        color: Colors.grey[500],
        onTabSelected: _onItemTapped,
        notchedShape: CircularNotchedRectangle(),
        height: 56,
        items: [
          BottomBarItem(iconData: Icons.more_time, title: "Watcher"),
          BottomBarItem(iconData: Icons.more_time, title: "Visitor"),
          BottomBarItem(iconData: Icons.more_time, title: "Hello"),
          BottomBarItem(iconData: Icons.more_time, title: "More"),
        ],
      ),
    );
  }
}
