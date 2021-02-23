import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Common/ClassList.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/CommonWidgets/BottomNavigationBarWithFab.dart';
import 'package:watcher_app_for_user/Providers/BottomNavigationBarProvider.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWithFab(
        notchedShape: CircularNotchedRectangle(),
        height: 56,
        selectedColor: appPrimaryMaterialColor,
        unSelectedColor: Colors.grey,
        items: [
          BottomBarItem(icon: Icons.person, title: "Watcher"),
          BottomBarItem(icon: Icons.insert_drive_file, title: "Visitors"),
          BottomBarItem(
              icon: Icons.home,
              title: "Home",
              imageIcon: "images/Watcherlogo.png"),
          BottomBarItem(icon: Icons.chat, title: "Hello"),
          BottomBarItem(icon: Icons.add, title: "More"),
        ],
      ),
    );
  }
}
