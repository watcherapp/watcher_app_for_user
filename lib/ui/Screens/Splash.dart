import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'file:///E:/Keval%20Work/watcher_app_for_user/lib/ui/Screens/User/UserDashboard.dart';
import 'package:watcher_app_for_user/ui/Screens/CreateSociety/CreateNewSociety.dart';
import 'package:watcher_app_for_user/ui/Screens/SignIn.dart';

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
              child: SignIn(), type: PageTransitionType.bottomToTop));
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
