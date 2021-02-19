import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Common/Custom_Icons.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/ui/Screens/User/SubScreens/MyWacther.dart';
import 'package:watcher_app_for_user/ui/Screens/User/SubScreens/UsersVisitorlist.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int currentIndex = 0;
  List<Widget> _list = [
    MyWatcher(),
    UserVisitorList(),
    Container(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _list[currentIndex],
        appBar: AppBar(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          currentIndex: currentIndex,
          unselectedFontSize: 14,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text('Watcher'),
              icon: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Icon(
                  CustomIcons.filled_user_profile,
                  size: 20,
                ),
              ),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text('Visitors'),
              icon: Icon(CustomIcons.filled_icard, size: 20),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text('Hello'),
              icon: Icon(
                CustomIcons.filled_chat,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text('More'),
              icon: Icon(CustomIcons.filled_more, size: 20),
            ),
          ],
        ));
  }
}
