import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/BottomNavigationBarCustomForAdmin.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/DailyHelperScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/GateKeeperScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/GatesScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/GatePassScreen.dart';

class WatcherScreen extends StatefulWidget {
  @override
  _WatcherScreenState createState() => _WatcherScreenState();
}

class _WatcherScreenState extends State<WatcherScreen> {
  List dashFields = [
    {
      "label": "Gate Keeper",
      "img": "images/watchman.png",
      "screenName": GateKeeperScreen(),
    },
    {
      "label": "Gates",
      "img": "images/gate.png",
      "screenName": GatesScreen(),
    },
    {
      "label": "GatePass",
      "img": "images/pass.png",
      "screenName": GatePassScreen(),
    },
    {
      "label": "Daily Helper",
      "img": "images/housekeeping.png",
      "screenName": DailyHelperScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gate Keeper",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Container(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 8, left: 11, right: 11),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
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
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13, top: 10),
                child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(9.0),
                        ),
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
                          "images/group.png",
                          width: 38,
                          color: appPrimaryMaterialColor,
                        ),
                        FittedBox(
                          // fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              "Visitor Statistics and History",
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
            // Padding(
            //   padding: const EdgeInsets.only(top: 25,left: 30,right: 12,
            //   ),
            //   child: Text(
            //     "Visitor data that are older than 30 days will be permanently deleted",
            //     style: TextStyle(
            //         color: Colors.red,
            //         fontSize: 13.5,
            //         fontFamily: 'Montserrat',
            //         fontWeight: FontWeight.w600),
            //   ),
            // ),
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
                          fontWeight: FontWeight.w600),
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
