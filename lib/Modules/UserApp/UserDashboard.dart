import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:watcher_app_for_user/CommonWidgets/BottomNavigationBarWithFab.dart';
import 'package:watcher_app_for_user/Constants/ClassList.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Providers/IndexCountProvider.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ComplaintsScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/ComplainsScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/MoreScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/MyWacther.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UserHomeScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UsersVisitorlist.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  String Id;
  List screenList = [
    MyWatcher(),
    UserVisitorList(),
    UserHomeScreen(),
    Container(),
    MoreScreen()
  ];

  @override
  void initState() {
    initOneSignalNotification();
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initOneSignalNotification() async {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    //.........................
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      // will be called whenever a notification is received
      print("-------------------------->Received notification");
      //print(notification.jsonRepresentation().replaceAll("\\n", "\n"));
      print(notification.payload.additionalData);
      dynamic data = notification.payload.additionalData;
      print(data["NotificationType"].toString());
      Vibration.vibrate(
        duration: 700,
      );
      if (data["NotificationType"].toString() == "ComplainResponse") {
        // Get.snackbar(
        //   "New Complain",
        //   "New Complain has been added",
        //   snackPosition: SnackPosition.BOTTOM,
        //   duration: Duration(seconds: 5),
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        //   onTap: (contex) {
        //     Get.to(
        //       () => ComplainsScreen(),
        //     );
        //   },
        // );
        // Fluttertoast.showToast(
        //   msg: "Your Complain Response",
        //   backgroundColor: Colors.red,
        //   textColor: appPrimaryMaterialColor,
        //   timeInSecForIosWeb: 10,
        // );
      } else if (data["NotificationType"].toString() == "NewComplain") {
        //...............................
        sharedPrefs.societyId = "${data["societyId"]}";
        sharedPrefs.societyCode = "${data["societyCode"]}";
        sharedPrefs.societyName = "${data["societyName"]}";
        sharedPrefs.memberNo = "${data["memberNo"]}";
        sharedPrefs.memberName = "${data["MemberName"]}";
        sharedPrefs.mobileNo = "${data["mobileNo"]}";
        sharedPrefs.wingId = "${data["wingId"]}";
        sharedPrefs.flatId = "${data["flatId"]}";

        //..............................
        Get.snackbar(
          "New Complain",
          "New Complain has been added",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          onTap: (contex) {
            Get.to(
              () => ComplainsScreen(),
            );
          },
        );
        // Fluttertoast.showToast(
        //   msg: "New Complain has been added",
        //   backgroundColor: Colors.red,
        //   textColor: appPrimaryMaterialColor,
        // );
      } else if (data["NotificationType"].toString() == "AddNotice") {
        // Get.snackbar(
        //   "New Complain",
        //   "New Complain has been added",
        //   snackPosition: SnackPosition.BOTTOM,
        //   duration: Duration(seconds: 5),
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        //   onTap: (contex) {
        //     Get.to(
        //       () => ComplainsScreen(),
        //     );
        //   },
        // );
        // Fluttertoast.showToast(
        //   msg: "New Notice has been added",
        //   backgroundColor: Colors.red,
        //   textColor: appPrimaryMaterialColor,
        // );
      }
    });

    //...........................
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      // will be called whenever a notification is opened/button pressed.
      print("---------------------------------");
      Get.snackbar(
        "One Signal",
        "Open Handler",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("------------------------->Opened notification");
      print(result.notification.jsonRepresentation().replaceAll("\\n", "\n"));
      print("s");
      print(result.notification.payload.additionalData);
      print("ss");
      dynamic data = result.notification.payload.additionalData;
      print("sss");
      print(
          "=================${data["NotificationType"].toString()}==========================");
      Vibration.vibrate(
        duration: 700,
      );
      //...............................
      sharedPrefs.societyId = "${data["societyId"]}";
      sharedPrefs.societyCode = "${data["societyCode"]}";
      sharedPrefs.societyName = "${data["societyName"]}";
      sharedPrefs.memberNo = "${data["memberNo"]}";
      sharedPrefs.memberName = "${data["MemberName"]}";
      sharedPrefs.mobileNo = "${data["mobileNo"]}";
      sharedPrefs.wingId = "${data["wingId"]}";
      sharedPrefs.flatId = "${data["flatId"]}";

      //..............................
      if (data != null) {
        if (data["NotificationType"].toString() == "ComplainResponse") {
          // Get.to(
          //   () => ComplainsScreen(),
          // );
        } else if (data["NotificationType"].toString() == "NewComplain") {
          Get.to(
            () => ComplaintsScreen(),
          );
        }
      }
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      print("PERMISSION STATE CHANGED");
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // will be called whenever the subscription changes
      //(ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<IndexCountProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          "Hey, " + "${sharedPrefs.memberName}",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      /*appBar: AppBar(title: Text("${sharedPrefs.memberId}")),*/
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          // ),
          // SizedBox(
          //   height: 60,
          //   width: MediaQuery.of(context).size.width,
          //   child: Image.network(
          //     "https://i.ibb.co/tcxqCQx/Whats-App-Image-2021-02-24-at-4-29-21-PM.jpg",
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 6.0, right: 6.0),
            child: screenList[provider.bottomBarCurrentIndex],
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
