import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/ui/Screens/Splash.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          fontFamily: 'WorkSans'),
      home: Splash(),
    );
  }
}
