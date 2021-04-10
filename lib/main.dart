import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/AdminDashboard.dart';
import 'package:watcher_app_for_user/Modules/Authentication/SignIn.dart';
import 'file:///C:/Users/SMIT%20VAGHANI/AndroidStudioProjects/watcher_app_for_user/lib/Modules/CreateSociety/SelectWingAndFlat.dart';
import 'package:watcher_app_for_user/Modules/Authentication/Splash.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/MasterAdminDashboard.dart';
import 'package:watcher_app_for_user/Modules/UserApp/UserDashboard.dart';

import 'Constants/appColors.dart';
import 'Data/Providers/IndexCountProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await sharedPrefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        home: Splash(),
      ),
    );
  }
}
