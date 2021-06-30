import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/BottomNavigationBarWithFab.dart';
import 'package:watcher_app_for_user/Constants/ClassList.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/MoreScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/MyWacther.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UserHomeScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UsersVisitorlist.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/HelloScreen.dart';

int pageIndex = 0;

class BottomNavigationBarCustom extends StatefulWidget {
  // int index2;
  //
  // BottomNavigationBarCustom({
  //   this.index2,
  // });

  @override
  _BottomNavigationBarCustomState createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  // @override
  // void initState() {
  //   widget.index2 == 0 ? pageIndex = 0 : pageIndex = 2;
  // }

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
              className: MyWatcher(),
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
              className: UserVisitorList(),
              title: "Visitors"),
          SizedBox(
            width: 2,
          ),
          Container(
            child: _buildBottomIcon(
                iconData: CupertinoIcons.home,
                index: 2,
                isActive: pageIndex == 2,
                mediaQuery: mediaQuery,
                activeColor: appPrimaryMaterialColor,
                className: UserHomeScreen(),
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
              className: HelloScreen(),
              title: "Hello"),
          SizedBox(
            width: 8,
          ),
          _buildBottomIcon(
              iconData: CupertinoIcons.add,
              index: 4,
              className: MoreScreen(),
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
