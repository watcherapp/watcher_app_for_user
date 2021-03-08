import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/CommonWidgets/BottomNavigationBarWithFab.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/Constants/ClassList.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Providers/BottomNavigationBarProvider.dart';
import 'package:watcher_app_for_user/Dialogs/EntryConformationPopup.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/MyWacther.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UserHomeScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UsersVisitorlist.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List screenList = [
    MyWatcher(),
    UserVisitorList(),
    UserHomeScreen(),
    Container(),
    Container()
  ];

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 5));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoadingIndicator();
        });
  }

  @override
  void initState() {
    //   _showDialog();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              "https://i.ibb.co/tcxqCQx/Whats-App-Image-2021-02-24-at-4-29-21-PM.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 6.0, right: 6.0),
            child: screenList[provider.currentIndex],
          ))
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
