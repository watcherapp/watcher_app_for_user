import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/ui/Screens/Admin/AdminDashboard.dart';
import 'package:watcher_app_for_user/ui/Screens/CreateSociety/CreateNewSociety.dart';
import 'package:watcher_app_for_user/ui/Screens/Login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: CreateNewSociety(), type: PageTransitionType.fade));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryMaterialColor,
      body: Center(child: Image.asset('images/Watcherlogo.png', width: 200)),
    );
  }
}
