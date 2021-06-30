import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/BottomNavigationBarCustom.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/AddDetailPage.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/BloodRequestScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/NoticesScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/ComplainsScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/AmenitiesScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/PollingScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/MeetingScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/VendorsScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/ParkingScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UserEmergencyScreen.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  List moreFields = [
    {
      "label": "Amenities",
      "img": "images/gym.png",
      "screenName": AmenitiesScreen()
    },
    {
      "label": "Notices",
      "img": "images/noticeboard.png",
      "screenName": NoticesScreen()
    },
    {
      "label": "Polling ",
      "img": "images/polling.png",
      "screenName": PollingScreen()
    },
    {
      "label": "Complains",
      "img": "images/complain.png",
      "screenName": ComplainsScreen()
    },
    {
      "label": " Blood Request",
      "img": "images/bloodDonation.png",
      "screenName": BloodRequestScreen(),
    },
    {
      "label": "Emergency",
      "img": "images/alarm.png",
      "screenName": UserEmergencyScreen(),
    },
    {
      "label": "Meetings",
      "img": "images/meeting.png",
      "screenName": MeetingScreen()
    },
    {
      "label": "Vendors",
      "img": "images/seller.png",
      "screenName": VendorsScreen()
    },
    {
      "label": "Parking",
      "img": "images/car.png",
      "screenName": ParkingScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
      body: Padding(
        padding: EdgeInsets.only(left: 6.0, right: 6.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 7,
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    PageTransition(
                        child: AddDetailPage(data: "https://i.pinimg.com/originals/14/14/5f/14145f84d1f7dbceddf9f6ffd9995594.jpg",),
                        type: PageTransitionType.fade));
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  "https://i.pinimg.com/originals/14/14/5f/14145f84d1f7dbceddf9f6ffd9995594.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 8),
            //   child: Container(
            //     height: 0.3,
            //     width: MediaQuery.of(context).size.width,
            //     color: Colors.grey,
            //   ),
            // ),
            SizedBox(height: 15),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 8, left: 8, right: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 3.0),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: moreFields[index]["screenName"],
                            type: PageTransitionType.fade));
                  },
                  child: Container(
                      height: 130,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              moreFields[index]["img"],
                              color: appPrimaryMaterialColor,
                              width: 37,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                moreFields[index]["label"],
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    //  fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            )
                          ],
                        ),
                      )),
                );
              },
              itemCount: moreFields.length,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}
