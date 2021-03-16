import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class LoadingIndicator {
  static show(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Material(
            color: Colors.transparent,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 65,
                            height: 65,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  appPrimaryMaterialColor),
                              backgroundColor: Colors.white54,
                            )),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset("images/watcherlogomini.png",
                                width: 50, height: 50),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Please Wait...",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          );
        });
  }

  static close(BuildContext context) {
    Navigator.of(context).pop();
  }
}

// class LoadingIndicator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Stack(
//           children: [
//             SizedBox(
//                 width: 60,
//                 height: 60,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: new AlwaysStoppedAnimation<Color>(
//                       appPrimaryMaterialColor),
//                   backgroundColor: Colors.white,
//                 )),
//             Align(
//                 alignment: Alignment.center,
//                 child: Image.asset("images/Watcherlogo.png",
//                     width: 50, height: 50))
//           ],
//         ),
//       ),
//     );
//   }
// }
