import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ChattingScreeen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/MyProfile.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/MyVisitors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/MyWatcherScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AdminHomeScreen.dart';

int pageIndex = 2;

class BottomNavigationBarCustomForAdmin extends StatefulWidget {
  @override
  _BottomNavigationBarCustomForAdminState createState() =>
      _BottomNavigationBarCustomForAdminState();
}

class _BottomNavigationBarCustomForAdminState
    extends State<BottomNavigationBarCustomForAdmin> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: mediaQuery.width,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.only(
        //   topRight: Radius.circular(18),
        //   topLeft: Radius.circular(18),
        // ),
      ),
      padding: EdgeInsets.only(top: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // SizedBox(
          //   width: 2,
          // ),
          _buildBottomIcon(
              iconData: CupertinoIcons.profile_circled,
              index: 0,
              isActive: pageIndex == 0,
              mediaQuery: mediaQuery,
              activeColor: appPrimaryMaterialColor,
              className: MyWatcherScreen(),
              title: "Watcher"),
          SizedBox(
            width: 2,
          ),
          _buildBottomIcon(
              iconData: CupertinoIcons.person_2_alt,
              index: 1,
              isActive: pageIndex == 1,
              mediaQuery: mediaQuery,
              activeColor: appPrimaryMaterialColor,
              className: MyVisitors(),
              title: "Visitors"),
          SizedBox(
            width: 2,
          ),
          Container(
            width: 45,
            child: _buildBottomIcon(
                iconData: CupertinoIcons.home,
                index: 2,
                isActive: pageIndex == 2,
                mediaQuery: mediaQuery,
                activeColor: appPrimaryMaterialColor,
                className: AdminHomeScreen(),
                image: "images/Watcherlogo.png",
                title: "Home"),
          ),
          SizedBox(
            width: 8,
          ),
          _buildBottomIcon(
              iconData: CupertinoIcons.chat_bubble_2_fill,
              index: 3,
              isActive: pageIndex == 3,
              mediaQuery: mediaQuery,
              activeColor: appPrimaryMaterialColor,
              className: ChattingScreeen(),
              title: "Hello"),
          SizedBox(
            width: 8,
          ),
          _buildBottomIcon(
              iconData: CupertinoIcons.add,
              index: 4,
              className: MyProfile(),
              isActive: pageIndex == 4,
              mediaQuery: mediaQuery,
              activeColor: appPrimaryMaterialColor,
              title: "More"),
          SizedBox(
            width: 0,
          ),
        ],
      ),
    );
  }

  _buildBottomIcon({
    bool isActive,
    IconData iconData,
    int index,
    Size mediaQuery,
    Color activeColor,
    var className,
    var title,
    String image,
  }) {
    return InkWell(
      onTap: () {
        print(index);
        print(pageIndex);
        if (index != pageIndex) {
          Navigator.of(context).pushAndRemoveUntil(
              PageTransition(child: className, type: PageTransitionType.fade),
              (Route<dynamic> route) => false);
          pageIndex = index;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          isActive
              ? Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Icon(
                    iconData,
                    color: isActive ? activeColor : Colors.grey[400],
                    size: 25,
                  ),
                )
              : image != null
                  ? Container(
                      // color: Colors.black,
                      child: Image.asset(
                        image,
                        width: 45,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Icon(
                        iconData,
                        color: isActive ? activeColor : Colors.grey[400],
                        size: 25,
                      ),
                    ),
          isActive
              ? Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: isActive ? activeColor : Colors.grey[400],
                    fontWeight: FontWeight.bold,
                  ),
                )
              : image != null
                  ? Container()
                  : Text(
                      title,
                      style: TextStyle(
                        fontSize: 11,
                        color: isActive ? activeColor : Colors.grey[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        ],
      ),
    );
  }
}
