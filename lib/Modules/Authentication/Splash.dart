import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/Authentication/SignIn.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/MyProperties.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/MasterAdminDashboard.dart';

class Splash extends StatefulWidget {
  var playerId;

  Splash({
    this.playerId,
  });

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      checkUserStatus();
    });
  }

  checkUserStatus() {
    if (sharedPrefs.memberId != "") {
      if (sharedPrefs.userRole == "0") {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: MasterAdminDashboard(),
            type: PageTransitionType.bottomToTop,
          ),
        );
      } else if (sharedPrefs.userRole == "1") {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: MyProperties(),
            type: PageTransitionType.bottomToTop,
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: MyProperties(),
            type: PageTransitionType.bottomToTop,
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: SignIn(
                playerId: widget.playerId,
              ),
              type: PageTransitionType.bottomToTop));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryMaterialColor,
      body: Center(child: Image.asset('images/Watcherlogo.png', width: 200)),
    );
  }
}
