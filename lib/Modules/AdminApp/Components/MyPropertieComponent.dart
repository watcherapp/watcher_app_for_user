import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/AdminDashboard.dart';
import 'package:watcher_app_for_user/Modules/UserApp/UserDashboard.dart';

enum OwnerType { Owner, Admin }

class MyPropertiesComponent extends StatefulWidget {
  var myPropertyData;
  MyPropertiesComponent({this.myPropertyData});
  @override
  _MyPropertiesComponentState createState() => _MyPropertiesComponentState();
}

class _MyPropertiesComponentState extends State<MyPropertiesComponent> {
  setPreferences() {
    sharedPrefs.societyId =
        "${widget.myPropertyData["MemberData"][0]["society"]["societyId"]}";
    //smit..
    sharedPrefs.societyCode =
    "${widget.myPropertyData["MemberData"][0]["society"]["societyCode"]}";

    sharedPrefs.societyName =
    "${widget.myPropertyData["MemberData"][0]["society"]["societyName"]}";

    //
    sharedPrefs.wingId =
        "${widget.myPropertyData["MemberData"][0]["society"]["wingId"]}";
    sharedPrefs.flatId =
        "${widget.myPropertyData["MemberData"][0]["society"]["flatId"]}";
    sharedPrefs.userRole =
        "${widget.myPropertyData["MemberData"][0]["society"]["userRole"]}";
    if (sharedPrefs.userRole == "1") {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: AdminDashboard(), type: PageTransitionType.bottomToTop));
    } else if (sharedPrefs.userRole == "2") {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: UserDashboard(), type: PageTransitionType.bottomToTop));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setPreferences();
      },
      child: Card(
        elevation: 3,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          side: new BorderSide(color: Colors.grey, width: 0.1),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: GridTile(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Image.asset(
                "images/building.png",
                width: 38,
                color: appPrimaryMaterialColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0, bottom: 30),
              child: FittedBox(
                // fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0, right: 3, top: 4),
                  child: Text(
                    "${widget.myPropertyData["SocietyData"][0]["societyName"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ]),
          footer: Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
                color: appPrimaryMaterialColor,
                onPressed: () {},
                child: Text(
                  "${widget.myPropertyData["WingData"][0]["wingName"]}" +
                      " - " +
                      "${widget.myPropertyData["flatNo"]}",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }
}
