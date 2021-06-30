import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/BottomNavigationBarCustomForAdmin.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AddPollingQuestion.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/NoticeBoardScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AmenitiesScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/BloodRequestScreen.dart';


class InteractionScreen extends StatefulWidget {
  @override
  _InteractionScreenState createState() => _InteractionScreenState();
}

class _InteractionScreenState extends State<InteractionScreen> {
  List interFields = [
    // {
    //   "label": "Society Meetings",
    //   "img": "images/clock.png",
    // },
    {
      "label": "Notice",
      "img": "images/microphone.png",
      "screenName" : NoticeBoardScreen(),
    },
    // {
    //   "label": "Event",
    //   "img": "images/calendar.png",
    // },
    {
      "label": "Polling",
      "img": "images/ballot.png",
      "screenName" : AddPollingQuestion(),
    },
    {
      "label": " Amenities",
      "img": "images/building.png",
      "screenName" : AmenitiesScreen(),
    },
    {
      "label": " Blood Request",
      "img": "images/bloodDonation.png",
      "screenName" : BloodRequestScreen(),
    },
    // {
    //   "label": "Proposal",
    //   "img": "images/approval.png",
    // },
    // {
    //   "label": "Suggestions",
    //   "img": "images/good.png",
    // },
    // {
    //   "label": "Tasks",
    //   "img": "images/checklists.png",
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Interaction",
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
      body: GridView.builder(
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
            interFields[index]["label"],
            interFields[index]["img"],
            interFields[index]["screenName"],
          );
        },
        itemCount: interFields.length,
      ),
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),
    );
  }

  Widget dashBox(
    String label,
    String img,
    Widget screenName,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: screenName, type: PageTransitionType.fade));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5, right: 4, left: 4),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.10,
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
                width: 30,
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
