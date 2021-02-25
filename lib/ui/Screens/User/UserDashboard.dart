import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Common/ClassList.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/CommonWidgets/BottomNavigationBarWithFab.dart';
import 'package:watcher_app_for_user/Providers/BottomNavigationBarProvider.dart';
import 'package:watcher_app_for_user/ui/Screens/User/SubScreens/UserHomeScreen.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          ),
          SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(6.0)),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                "https://i.ibb.co/qmZJzK5/Whats-App-Image-2021-02-24-at-4-29-17-PM.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          UserHomeScreen()
        ],
      ),
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
