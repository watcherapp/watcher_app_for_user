import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/UpdateProfile.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: UpdateProfile(),
                      type: PageTransitionType.rightToLeft));
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: Image.asset(
                  "images/edit.png",
                  width: 18,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "images/perso-outline.png",
                  color: Colors.white,
                  width: 170,
                ),
              ],
            ),
            color: appPrimaryMaterialColor,
            height: MediaQuery.of(context).size.height / 3.2,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 19),
            child: Center(
              child: Text("Megha Solanki",
                  style: (TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontFamily: 'Montserrat',
                    //fontWeight: FontWeight.w600
                  ))),
            ),
          ),
          Divider(
            height: 0.5,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: ListTile(
              leading: Icon(Icons.call, color: appPrimaryMaterialColor),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "9429828152",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      "Mobile",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Divider(
              height: 0.5,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: ListTile(
              leading: Icon(Icons.email, color: appPrimaryMaterialColor),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "meghatech9teen@gmail.com",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Divider(
              height: 0.5,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
