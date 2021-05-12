import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/Authentication/Splash.dart';

import 'Constants/appColors.dart';
import 'Data/Providers/IndexCountProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await sharedPrefs.init();
  Platform.isAndroid ? OneSignal.shared.init(
    "aef52e90-a64c-415a-81ad-9bc58b7c0e5e",
    iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false,
    },
  ):OneSignal.shared.init(
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

  @override
  void initState() {
    _handleSendNotification();
  }


  var playerId;
  void _handleSendNotification() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    playerId = status.subscriptionStatus.userId;
    print("playerid");
    print(playerId);
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
          playerId: playerId,
        ),
      ),
    );
  }

}
