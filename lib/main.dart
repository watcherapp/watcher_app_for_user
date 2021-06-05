import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ComplaintsScreen.dart';
import 'package:watcher_app_for_user/Modules/Authentication/Splash.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/ComplainsScreen.dart';

import 'Constants/appColors.dart';
import 'Data/Providers/IndexCountProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await sharedPrefs.init();
  Platform.isAndroid
      ? OneSignal.shared.init(
          "aef52e90-a64c-415a-81ad-9bc58b7c0e5e",
          iOSSettings: {
            OSiOSSettings.autoPrompt: false,
            OSiOSSettings.inAppLaunchUrl: false,
          },
        )
      : OneSignal.shared.init(
          "aef52e90-a64c-415a-81ad-9bc58b7c0e5e",
          iOSSettings: {
            OSiOSSettings.autoPrompt: true,
            OSiOSSettings.inAppLaunchUrl: true,
          },
        );

  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.none);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _handleSendNotification();
    initOneSignalNotification();
  }

  var playerId;

  void _handleSendNotification() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    playerId = status.subscriptionStatus.userId;
    print("playerid--->${playerId}");
  }

  bool isAppOpenedAfterNotification = false;

  Future<void> initOneSignalNotification() async {
    debugPrint("initOneSignalNotification called");
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    //..............
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      isAppOpenedAfterNotification = true;
      debugPrint(isAppOpenedAfterNotification.toString());
      print(notification.payload.body);
      print(notification.payload.title);
      print(notification.payload.sound);
      print(notification.payload.additionalData);
      dynamic data = notification.payload.additionalData;
      print("data from onesignal");
      print(data);
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
        //   onTap:(contex){
        //     Get.to(
        //           () => ComplainsScreen(),
        //     );
        //   },
        // );
        // Fluttertoast.showToast(
        //   msg: "Your Complain Response",
        //   backgroundColor: Colors.red,
        //   textColor: appPrimaryMaterialColor,
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
          onTap:(contex){
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
        //   onTap:(contex){
        //     Get.to(
        //           () => ComplainsScreen(),
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

    //...............
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      // will be called whenever a notification is opened/button pressed.
      print("---------------------------------");
      Get.snackbar("One Signal", "Open Handler",
          snackPosition: SnackPosition.BOTTOM);
      print("Opened notification");
      print(result.notification.jsonRepresentation().replaceAll("\\n", "\n"));
      print("s");
      print(result.notification.payload.additionalData);
      print("ss");
      dynamic data = result.notification.payload.additionalData;
      print("sss");
      print(
          "=================${data["NotificationType"].toString()}==========================");
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<IndexCountProvider>(
            create: (context) => IndexCountProvider()),
        /*ChangeNotifierProvider<PropertyManagerProvider>(
            create: (context) => PropertyManagerProvider())*/
      ],
      child: MaterialApp(
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                color: appPrimaryMaterialColor,
                centerTitle: true,
                textTheme: TextTheme(
                    // ignore: deprecated_member_use
                    title: TextStyle(color: Colors.white, fontSize: 18))),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: appPrimaryMaterialColor),
            primaryColor: appPrimaryMaterialColor,
            fontFamily: 'Montserrat'),
        home: Splash(
            // playerId: playerId,
            ),
      ),
    );
  }
}
