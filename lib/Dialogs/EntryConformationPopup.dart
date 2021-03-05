import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/CommonWidgets/RoundButton.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';

class EntryConfirmationPopup extends StatefulWidget {
  @override
  _EntryConfirmationPopupState createState() => _EntryConfirmationPopupState();
}

class _EntryConfirmationPopupState extends State<EntryConfirmationPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 32, 82, 0.7),
      body: Center(
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AvatarGlow(
                  glowColor: Colors.orangeAccent,
                  endRadius: 90.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: Image.network(
                        "https://randomuser.me/api/portraits/men/11.jpg",
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    RoundButton(
                        imageName: "images/icons/success.png",
                        actionName: "Accept")
                  ],
                )
              ],
            )),
      ),
    );
  }
}
