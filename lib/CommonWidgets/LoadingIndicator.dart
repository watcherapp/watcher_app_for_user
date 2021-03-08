import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: [
            SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      appPrimaryMaterialColor),
                  backgroundColor: Colors.white,
                )),
            Align(
                alignment: Alignment.center,
                child: Image.asset("images/Watcherlogo.png",
                    width: 50, height: 50))
          ],
        ),
      ),
    );
  }
}
