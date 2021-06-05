import 'dart:developer';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/EmergencyScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/MyVisitorListComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/NoticesScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UserEmergencyScreen.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool isVisitorLoading = false;
  List myGuestList = [];
  int x = -1;

  DateTime selectedFromDate = DateTime.now();
  var dateFormate = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    _getAllvisitor();
  }

  _getAllvisitor() async {
    try {
      setState(() {
        isVisitorLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        // print(sharedPrefs.memberId);
        print(selectedFromDate);
        // print(selectedToDate);
        var body = {
          // "memberId": sharedPrefs.memberId,
          "flatId": sharedPrefs.flatId,
          "wingId": sharedPrefs.wingId,
          "societyId": sharedPrefs.societyId,
          "fromDate": dateFormate.format(selectedFromDate),
          // "fromDate": "31/05/2021",
          // "fromDate": "01/06/2021",
          // "toDate": dateFormate.format(selectedToDate),
        };
        print(body);
        log("MemberId ${sharedPrefs.memberId}");
        Services.responseHandler(
                apiName: "api/member/getAllGuestList", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            List allGuestList = responseData.Data;
            // print("allGuestList-------------->${allGuestList}");
            for (int i = 0; i < allGuestList.length; i++) {
              if (allGuestList[i]["guestVideo"] != "") {
                print(allGuestList[i]["guestVideo"]);
                myGuestList.add(allGuestList[i]);
                print(i);
                // print(x++);
                // log("myGuestList-------------->${myGuestList}");
              }
            }
            print(
                "======================================My visitor=====================================");
            print("myGuestList-------------->${myGuestList}");
            print("${myGuestList.length}");
            print(
                "=====================================================================================");
            setState(() {
              isVisitorLoading = false;
            });
          } else {
            print(responseData);
            setState(() {
              // allGuestList = responseData.Data;
              isVisitorLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isVisitorLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isVisitorLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }

/*
  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }
*/

  List bannerList = [
    "https://graphicsfamily.com/wp-content/uploads/edd/2020/11/Tasty-Food-Web-Banner-Design-scaled.jpg",
    "https://previews.customer.envatousercontent.com/files/219112782/preview%20image.JPG",
    "https://i.pinimg.com/originals/14/14/5f/14145f84d1f7dbceddf9f6ffd9995594.jpg"
  ];

  List quickActions = [
    {
      "image": "images/noticeboard.png",
      "title": "Notice",
      "screenName": NoticesScreen(),
    },
    {
      "image": "images/alarm.png",
      "title": "Emergency",
      "screenName": UserEmergencyScreen(),
    },
    {
      "image": "images/ad-campaign.png",
      "title": "Advertisement",
      "screenName": NoticesScreen(),
    },
    {
      "image": "images/car.png",
      "title": "Parking",
      "screenName": NoticesScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150.0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: true,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(seconds: 1),
                dotSize: 4.0,
                dotIncreasedColor: appPrimaryMaterialColor,
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                dotVerticalPadding: 10.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                images: bannerList
                    .map(
                      (item) => Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          "$item",
                          fit: BoxFit.fitWidth,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        elevation: 2,
                        margin: EdgeInsets.all(4),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 6.0, top: 8.0),
            child: Text(
              "Quick Actions",
              style: fontConstants.listTitles,
            ),
          ),
          SizedBox(
            height: 85,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: quickActions.map((e) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: e["screenName"],
                            type: PageTransitionType.rightToLeft));
                  },
                  child: Card(
                    elevation: 0,
                    child: SizedBox(
                      width: 85,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "${e["image"]}",
                                width: 32,
                                color: appPrimaryMaterialColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${e["title"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, bottom: 6.0, top: 8.0, right: 8),
            child: Text(
              "My Visitors",
              style: fontConstants.listTitles,
            ),
          ),
          myGuestList.length > 0
              ? SizedBox(
                  height: 310,
                  child: PageView.builder(
                      itemCount: myGuestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(myGuestList.length);
                        print(index);
                        return MyVisitorListComponent(
                          visitorData: myGuestList[index],
                          index: index,
                        );
                      }))
              : SizedBox(
                  height: 310,
                  child: Center(
                    child: Text("No Visitor Entry found on your flat"),
                  ),
                ),
        ],
      ),
    );
  }
}
