import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/ui/Screens/Splash.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: appPrimaryMaterialColor,
        fontFamily: 'WorkSans'
      ),
      home: Splash(),
    );
  }
}

