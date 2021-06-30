import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share/share.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/BottomNavigationBarCustomForAdmin.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AdvertisementScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ComplaintsScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/EmergencyScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/HelpDeskScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/InteractionScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ManagementScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/MemberApprovelScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/MemberDirectoryScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ParkingScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/WatcherScreen.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List dashFields = [
    {
      "label": "Complaints",
      "img": "images/complain.png",
      "screenName": ComplaintsScreen(),
    },
    {
      "label": "Directory",
      "img": "images/directory1.png",
      "screenName": MemberDirectoryScreen(),
    },
    {
      "label": "Parking",
      "img": "images/car.png",
      "screenName": ParkingScreen(),
    },
    {
      "label": "My Building",
      "img": "images/building.png",
      "screenName": MemberApprovelScreen(),
    },
    {
      "label": "Emergency",
      "img": "images/alarm.png",
      "screenName": EmergencyScreen(),
    },
    {
      "label": "Advertisement",
      "img": "images/ad-campaign.png",
      "screenName": AdvertisementScreen(),
    },
    {
      "label": "Management",
      "img": "images/team.png",
      "screenName": ManagementScreen(),
    },
    {
      "label": "Interaction",
      "img": "images/chat.png",
      "screenName": InteractionScreen(),
    },
    {
      "label": "Help Desk",
      "img": "images/communications.png",
      "screenName": HelpDeskScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   elevation: 0.5,
      //   centerTitle: true,
      //   title: Text(
      //     "Hey, " + "${sharedPrefs.memberName}",
      //     style: TextStyle(color: Colors.black, fontSize: 17),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 7,
            ),
            GestureDetector(
              onTap: () {
                Share.share(
                    '${sharedPrefs.societyCode} Share above code with building members to join ${sharedPrefs.societyName}.');
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13),
                child: Container(
                    height: 95,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 2.0,
                              spreadRadius: 2.0,
                              offset: Offset(3.0, 5.0))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 11.0),
                                child: Text(
                                  // "0160203220",
                                  "${sharedPrefs.societyCode}",
                                  style: TextStyle(
                                      color: appPrimaryMaterialColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 11.0, right: 10),
                                child: Text(
                                  "Share above code with building members to join ${sharedPrefs.societyName},",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                        Padding(
                            padding:
                            const EdgeInsets.only(right: 25.0, left: 8),
                            child: Icon(
                              Icons.share,
                              color: appPrimaryMaterialColor,
                              size: 32,
                            )),
                      ],
                    )),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 8, left: 11, right: 11),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 3.0),
              itemBuilder: (BuildContext context, int index) {
                return dashBox(
                  dashFields[index]["label"],
                  dashFields[index]["img"],
                  dashFields[index]["screenName"],
                );
              },
              itemCount: dashFields.length,
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: WatcherScreen(),
                        type: PageTransitionType.fade));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13),
                child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 2.0,
                              spreadRadius: 2.0,
                              offset: Offset(3.0, 5.0))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/gate.png",
                          width: 38,
                          color: appPrimaryMaterialColor,
                        ),
                        FittedBox(
                          // fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              "Watcher",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: appPrimaryMaterialColor,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),
    );
  }

  Widget dashBox(String label, String img, Widget screenName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: screenName, type: PageTransitionType.fade));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5, right: 3, left: 3),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                    offset: Offset(3.0, 5.0))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img,
                width: 37,
                color: appPrimaryMaterialColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: FittedBox(
                  // fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
