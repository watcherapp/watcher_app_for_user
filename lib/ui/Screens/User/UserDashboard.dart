import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
          BottomBarItem(icon: CupertinoIcons.profile_circled, title: "Watcher"),
          BottomBarItem(icon: CupertinoIcons.person_2_alt, title: "Visitors"),
          BottomBarItem(
              icon: CupertinoIcons.home,
              title: "Home",
              imageIcon: "images/Watcherlogo.png"),
          BottomBarItem(
              icon: CupertinoIcons.chat_bubble_2_fill, title: "Hello"),
          BottomBarItem(icon: CupertinoIcons.add, title: "More"),
        ],
      ),
    );
  }
}
