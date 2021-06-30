import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share/share.dart';
import 'package:vibration/vibration.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/CommonWidgets/labelWithAddButton.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Dialogs/EntryConformationPopup.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/AdminDashboard.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AdminHomeScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ComplaintsScreen.dart';
import 'package:watcher_app_for_user/Modules/Authentication/SignIn.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/AddComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/BottomNavigationBarCustom.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/DailyHelperComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/FamilyMemberComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/MyResidentComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/MyVehicleComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/AddFamilyMember.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/ComplainsScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/JoinNewFlatInSociety.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UpdateMemberProfile.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/AddMyStaff.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/VehicleScreen.dart';

class MyWatcher extends StatefulWidget {
  @override
  _MyWatcherState createState() => _MyWatcherState();
}

class _MyWatcherState extends State<MyWatcher> {
  int length = 2;
  List familyMemberList = [];
  List vehicleList = [];
  List staffList = [];
  List memberList = [];
  List myPropertyList = [];
  bool ismemberLoading = false;
  bool isFamilyLoading = false;
  bool isStaffLoading = false;
  bool isResidentLoading = false;
  bool isVehicleLoading = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initOneSignalNotification();
    _memberDetail();
    _getMyFamilyMember();
    _getMyStaff();
    _getMyVehical();
    _getMyProperties();
  }

  bool isAppOpenedAfterNotification = false;

  Future<void> initOneSignalNotification() async {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    isAppOpenedAfterNotification = true;
    //.........................
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      // will be called whenever a notification is received
      print("-------------------------->Received notification");
      //print(notification.jsonRepresentation().replaceAll("\\n", "\n"));
      print(notification.payload.additionalData);
      dynamic data = notification.payload.additionalData;
      print(data["NotificationType"].toString());
      Vibration.vibrate(
        duration: 700,
      );
      print(
          "Receivedhandler=================${data["NotificationType"].toString()}==========================fromMyWatcher");
      print("from recive ==========>${data}");
      if (data != null) {
        print("receive from mywatch");
        if (data["NotificationType"].toString() == "ComplainResponse") {
          // Get.snackbar(
          //   "New Complain",
          //   "New Complain has been added",
          //   snackPosition: SnackPosition.BOTTOM,
          //   duration: Duration(seconds: 5),
          //  backgroundColor: Color(0xFFFF4F4F),
          //   colorText: Colors.white,
          //   onTap: (contex) {
          //     Get.to(
          //       () => ComplainsScreen(),
          //     );
          //   },
          // );
          // Fluttertoast.showToast(
          //   msg: "Your Complain Response",
          //  backgroundColor: Color(0xFFFF4F4F),
          //   textColor: appPrimaryMaterialColor,
          //   timeInSecForIosWeb: 10,
          // );
        } else if (data["NotificationType"].toString() == "NewComplain") {
          //...............................
          sharedPrefs.societyId = "${data["societyId"]}";
          sharedPrefs.societyCode = "${data["societyCode"]}";
          sharedPrefs.societyName = "${data["societyName"]}";
          sharedPrefs.memberNo = "${data["memberNo"]}";
          sharedPrefs.memberName = "${data["MemberName"]}";
          sharedPrefs.mobileNo = "${data["mobileNo"]}";
          sharedPrefs.wingId = "${data["wingId"]}";
          sharedPrefs.flatId = "${data["flatId"]}";

          //..............................
          Get.snackbar(
            "New Complain",
            "New Complain has been added",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 5),
            backgroundColor: Color(0xFFFF4F4F),
            colorText: Colors.white,
            onTap: (contex) {
              Get.to(
                () => ComplainsScreen(),
              );
            },
          );
          // Fluttertoast.showToast(
          //   msg: "New Complain has been added",
          //  backgroundColor: Color(0xFFFF4F4F),
          //   textColor: appPrimaryMaterialColor,
          // );
        } else if (data["NotificationType"].toString() == "AddNotice") {
          // Get.snackbar(
          //   "New Complain",
          //   "New Complain has been added",
          //   snackPosition: SnackPosition.BOTTOM,
          //   duration: Duration(seconds: 5),
          //  backgroundColor: Color(0xFFFF4F4F),
          //   colorText: Colors.white,
          //   onTap: (contex) {
          //     Get.to(
          //       () => ComplainsScreen(),
          //     );
          //   },
          // );
          // Fluttertoast.showToast(
          //   msg: "New Notice has been added",
          //  backgroundColor: Color(0xFFFF4F4F),
          //   textColor: appPrimaryMaterialColor,
          // );
        } else if (data["NotificationType"].toString() == "VisitorEntry") {
          // Get.snackbar(
          //   "New Complain",
          //   "New Complain has been added",
          //   snackPosition: SnackPosition.BOTTOM,
          //   duration: Duration(seconds: 5),
          //  backgroundColor: Color(0xFFFF4F4F),
          //   colorText: Colors.white,
          //   onTap: (contex) {
          //     Get.to(
          //       () => ComplainsScreen(),
          //     );
          //   },
          // );
          // Fluttertoast.showToast(
          //   msg: "New Notice has been added",
          //  backgroundColor: Color(0xFFFF4F4F),
          //   textColor: appPrimaryMaterialColor,
          // );
          print("watchmanId-->${data["watchmanId"].toString()}");
          print("Name-->${data["Name"].toString()}");
          print("ContactNo-->${data["ContactNo"].toString()}");
          print("Image-->${data["Image"].toString()}");
          print("EntryNo-->${data["EntryNo"].toString()}");
          Get.to(
            () => EntryConfirmationPopup(
              visitorData: data,
            ),
          );
        }
      }
    });

    //...........................
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      // will be called whenever a notification is opened/button pressed.
      // print("---------------------------------");
      // Get.snackbar(
      //   "One Signal",
      //   "Open Handler",
      //   snackPosition: SnackPosition.BOTTOM,
      // );

      print("------------------------->Opened notification");
      // print(result.notification.jsonRepresentation().replaceAll("\\n", "\n"));
      print("s");
      print(result.notification.payload.additionalData);
      print("ss");
      dynamic data = result.notification.payload.additionalData;
      print("sss");
      print(
          "Openhandler=================${data["NotificationType"].toString()}==========================fromMyWatcher");
      print("from recive ==========>${data}");
      Vibration.vibrate(
        duration: 700,
      );
      //...............................
      // sharedPrefs.societyId = "${data["societyId"]}";
      // sharedPrefs.societyCode = "${data["societyCode"]}";
      // sharedPrefs.societyName = "${data["societyName"]}";
      // sharedPrefs.memberNo = "${data["memberNo"]}";
      // sharedPrefs.memberName = "${data["MemberName"]}";
      // sharedPrefs.mobileNo = "${data["mobileNo"]}";
      // sharedPrefs.wingId = "${data["wingId"]}";
      // sharedPrefs.flatId = "${data["flatId"]}";

      //..............................
      if (data != null) {
        print("open from mywatch");
        if (data["NotificationType"].toString() == "ComplainResponse") {
          // Get.to(
          //   () => ComplainsScreen(),
          // );
        } else if (data["NotificationType"].toString() == "NewComplain") {
          Get.to(
            () => ComplaintsScreen(),
          );
        } else if (data["NotificationType"].toString() == "VisitorEntry") {
          print(
              "s-----------------------------------------------------------------------s");
          print("watchmanId-->${data["watchmanId"].toString()}");
          print("Name-->${data["Name"].toString()}");
          print("ContactNo-->${data["ContactNo"].toString()}");
          print("Image-->${data["Image"].toString()}");
          print("EntryNo-->${data["EntryNo"].toString()}");
          Get.to(
            () => EntryConfirmationPopup(
              visitorData: data,
            ),
          );
        }
      }
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      print("PERMISSION STATE CHANGED");
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // will be called whenever the subscription changes
      //(ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 6.0, right: 6.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 7,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  "https://i.pinimg.com/originals/14/14/5f/14145f84d1f7dbceddf9f6ffd9995594.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              ismemberLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            appPrimaryMaterialColor),
                        //backgroundColor: Colors.white54,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 8.0, right: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: appPrimaryMaterialColor,
                            radius: 35,
                            child: ClipOval(
                              child: Padding(
                                  padding: const EdgeInsets.all(0.5),
                                  child: memberList[0]["memberImage"] == null ||
                                          memberList[0]["memberImage"] == ""
                                      ? Image.asset(
                                          'images/maleavtar.png',
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3.0),
                                          child: Container(
                                            height: 70.0,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              // borderRadius: BorderRadius.circular(30),
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 0.2,
                                                  color:
                                                      appPrimaryMaterialColor),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  API_URL +
                                                      memberList[0]
                                                          ["memberImage"],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${memberList[0]["firstName"]} ${memberList[0]["lastName"]}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87)),
                                  Text("${memberList[0]["mobileNo1"]}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: UpdateMemberProfile(
                                          myProfileFun: () {
                                            _memberDetail();
                                          },
                                          profileData: memberList,
                                        ),
                                        type: PageTransitionType.rightToLeft));
                              },
                              color: appPrimaryMaterialColor)
                        ],
                      ),
                    ),
              LabelWithAddButton(
                icon: Icon(
                  Icons.apartment_sharp,
                  size: 22,
                ),
                onPressed: () {},
                title: "My Residents",
              ),
              SizedBox(
                height: 90,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: myPropertyList.length + 1,
                    itemBuilder: (context, index) {
                      if (index > myPropertyList.length - 1) {
                        return AddComponent(
                          width: 100,
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: JoinNewFlatInSociety(
                                      memberPropertyApi: () {
                                        _getMyProperties();
                                      },
                                    ),
                                    type: PageTransitionType.rightToLeft));
                          },
                        );
                      } else {
                        return isResidentLoading
                            ? Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            appPrimaryMaterialColor),
                                    //backgroundColor: Colors.white54,
                                  ),
                                ),
                              )
                            : MyResidentComponent(
                                memberPropertyData: myPropertyList[index],
                              );
                      }
                    }),
              ),
              LabelWithAddButton(
                icon: Icon(
                  Icons.group,
                  size: 22,
                ),
                onPressed: () {},
                title: "Family Members",
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    //aa use karvanu 6e.................................
                    // itemCount: familyMemberList.length + 1,
                    itemCount: familyMemberList.length + 1,
                    itemBuilder: (context, index) {
                      if (index > familyMemberList.length - 1) {
                        return AddComponent(
                            width: 100,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: AddFamilyMember(
                                        memberApi: () {
                                          _getMyFamilyMember();
                                        },
                                      ),
                                      type: PageTransitionType.rightToLeft));
                            });
                      } else {
                        return isFamilyLoading
                            ? Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            appPrimaryMaterialColor),
                                    //backgroundColor: Colors.white54,
                                  ),
                                ),
                              )
                            : FamilyMemberComponent(
                                familyDataList: familyMemberList[index],
                                familyApi: () {
                                  _getMyFamilyMember();
                                },
                              );
                      }
                    }),
              ),
              LabelWithAddButton(
                icon: Icon(
                  Icons.person,
                  size: 20,
                ),
                onPressed: () {},
                title: "My Staff",
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: staffList.length + 1,
                    itemBuilder: (context, index) {
                      if (index > staffList.length - 1) {
                        return AddComponent(
                            width: 100,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: AddMyStaff(
                                        staffDataApi: () {
                                          _getMyStaff();
                                        },
                                      ),
                                      type: PageTransitionType.rightToLeft));
                            });
                      } else {
                        return isStaffLoading
                            ? Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            appPrimaryMaterialColor),
                                    //backgroundColor: Colors.white54,
                                  ),
                                ),
                              )
                            : DailyHelperComponent(
                                myStaffData: staffList[index],
                                staffApi: () {
                                  _getMyStaff();
                                },
                              );
                      }
                    }),
              ),
              LabelWithAddButton(
                icon: Icon(
                  Icons.directions_car_outlined,
                  size: 22,
                ),
                onPressed: () {},
                title: "My Vehicle",
              ),
              SizedBox(
                height: 90,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: vehicleList.length + 1,
                    itemBuilder: (context, index) {
                      if (index > vehicleList.length - 1) {
                        return AddComponent(
                            width: 100,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: VehicleScreen(
                                        myVehicleApi: () {
                                          _getMyVehical();
                                        },
                                      ),
                                      type: PageTransitionType.rightToLeft));
                            });
                      } else {
                        return isVehicleLoading
                            ? Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            appPrimaryMaterialColor),
                                    //backgroundColor: Colors.white54,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onLongPress: () {
                                  print("smit");
                                },
                                child: MyVehicleComponent(
                                  vehicleData: vehicleList[index],
                                ),
                              );
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 10, top: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("images/set.png", width: 21),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text('Preferences',
                              //overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Montserrat",
                                  color: Colors.black87)),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 10, top: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("images/emcall.png", width: 24),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text('Emergency Contact',
                              //overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Montserrat",
                                  color: Colors.black87)),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ShowDialog(),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 10, top: 23),
                  child: Row(
                    children: [
                      Image.asset("images/star.png", width: 21),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text('Support  &  Feedback',
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                color: Colors.black87)),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 12.0, right: 10, top: 23),
              //   child: Row(
              //     children: [
              //       Image.asset("images/feedback.png", width: 23),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 15.0),
              //         child: Text('Complaint',
              //             //overflow: TextOverflow.ellipsis,
              //             style: TextStyle(
              //                 fontSize: 16,
              //                 fontFamily: "Montserrat",
              //                 color: Colors.black87)),
              //       ),
              //     ],
              //   ),
              // ),
              GestureDetector(
                onTap: (){
                  Share.share(
                      'http://www.itfuturz.com/');
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 10, top: 22),
                  child: Row(
                    children: [
                      Image.asset("images/share.png", width: 21),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text('Tell a friend about Watcher',
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                color: Colors.black87)),
                      ),
                    ],
                  ),
                ),
              ),
              sharedPrefs.userRole == "1"
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: AdminHomeScreen(),
                                type: PageTransitionType.fade));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 10, top: 23),
                        child: Row(
                          children: [
                            Image.asset("images/switch.png", width: 21),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text('Switch to Admin',
                                  //overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Montserrat",
                                      color: Colors.black87)),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              GestureDetector(
                onTap: () {
                  _logOutMember();
                  // sharedPrefs.logout();
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     PageTransition(
                  //         child: SignIn(), type: PageTransitionType.rightToLeft),
                  //     (Route<dynamic> route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 10, top: 23, bottom: 15),
                  child: Row(
                    children: [
                      Image.asset("images/logout1.png", width: 21),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text('Logout',
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                color: Colors.black87)),
                      ),
                    ],
                  ),
                ),
              ),
              /*  Center(
                child: Image.asset(
              "images/Watcherlogo.png",
              width: 90,
            )),*/
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Terms & Conditions',
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            color: appPrimaryMaterialColor)),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, right: 7),
                      child: Container(
                        height: 12,
                        width: 1,
                        color: appPrimaryMaterialColor,
                      ),
                    ),
                    Text('Privacy Policy',
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            color: appPrimaryMaterialColor)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }

  _logOutMember() async {
    print("Calling");
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberId": "${sharedPrefs.memberId}",
          "playerId": "${sharedPrefs.playerId}",
        };
        print(
            "------------------------------------------------------------->${body}");
        Services.responseHandler(apiName: "api/member/memberLogout", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            setState(() {
              print(responseData.Data);
              isLoading = false;
            });
            sharedPrefs.logout();
            Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                    child: SignIn(), type: PageTransitionType.rightToLeft),
                (Route<dynamic> route) => false);
            Fluttertoast.showToast(
              msg: "You are Logout Successfully",
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity: ToastGravity.TOP,
            );
          } else {
            print(responseData);
            setState(() {
              isLoading = false;
            });
            // Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }

  _getMyFamilyMember() async {
    print("Calling");
    try {
      setState(() {
        isFamilyLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberId": "${sharedPrefs.memberId}",
          "societyId": "${sharedPrefs.societyId}",
          "wingId": "${sharedPrefs.wingId}",
          "flatId": "${sharedPrefs.flatId}",
        };
        print(
            "------------------------------------------------------------->${body}");
        Services.responseHandler(
                apiName: "api/member/getFamilyMembers", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              familyMemberList = responseData.Data;
              isFamilyLoading = false;
            });
            print("familyMemberList-------------------->$familyMemberList");
          } else {
            print(responseData);
            setState(() {
              // familyMemberList = responseData.Data;
              isFamilyLoading = false;
            });
            // Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isFamilyLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isFamilyLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }

  _getMyStaff() async {
    print("Calling");
    try {
      setState(() {
        isStaffLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
          "wingId": sharedPrefs.wingId,
          "flatId": sharedPrefs.flatId,
        };
        print(
            "------------------------------------------------------------->${body}");
        Services.responseHandler(
                apiName: "api/member/getAllStaffDetails", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              staffList = responseData.Data;
              isStaffLoading = false;
            });
            print("staffList-------------------->$staffList");
          } else {
            print(responseData);
            setState(() {
              // staffList = responseData.Data;
              isStaffLoading = false;
            });
            // Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isStaffLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isStaffLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }

  _getMyVehical() async {
    print("Calling");
    try {
      setState(() {
        isVehicleLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print("${sharedPrefs.memberId}");
        var body = {
          "memberId": "${sharedPrefs.memberId}",
        };
        print(
            "------------------------------------------------------------->${body}");
        Services.responseHandler(
                apiName: "api/member/getMemberVehicles", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              vehicleList = responseData.Data;
              isVehicleLoading = false;
            });
            print("vehicleList-------------------->$vehicleList");
          } else {
            print(responseData);
            setState(() {
              // vehicleList = responseData.Data;
              isVehicleLoading = false;
            });
            // Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isVehicleLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isVehicleLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }

  _memberDetail() async {
    try {
      setState(() {
        ismemberLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {"mobileNo": "${sharedPrefs.mobileNo}"};
        print(
            "------------------------------------------------------------->${body}");
        Services.responseHandler(
                apiName: "api/member/getMemberInformation", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              memberList = responseData.Data;
              ismemberLoading = false;
            });
            print("memberList-------------------->$memberList");
          } else {
            print(responseData);
            setState(() {
              // memberList = responseData.Data;
              ismemberLoading = false;
            });
            // Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            ismemberLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        ismemberLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }

  _getMyProperties() async {
    try {
      setState(() {
        isResidentLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberId": "${sharedPrefs.memberId}",
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/member/getMemberSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              myPropertyList = responseData.Data;
              isResidentLoading = false;
            });
            print("myPropertyList--------------${myPropertyList}");
          } else {
            print(responseData);
            setState(() {
              isResidentLoading = false;
            });
            // Fluttertoast.showToast(
            //   msg: "${responseData.Message}",
            //   backgroundColor: Colors.white,
            //   textColor: appPrimaryMaterialColor,
            // );
          }
        }).catchError((error) {
          setState(() {
            isResidentLoading = false;
          });
          // Fluttertoast.showToast(
          //   msg: "Error $error",
          //   backgroundColor: Colors.white,
          //   textColor: appPrimaryMaterialColor,
          // );
        });
      }
    } catch (e) {
      setState(() {
        isResidentLoading = false;
      });
      Fluttertoast.showToast(
        msg: "You aren't connected to the Internet !",
        backgroundColor: Colors.white,
        textColor: appPrimaryMaterialColor,
      );
    }
  }
}

class ShowDialog extends StatefulWidget {
  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  final TextEditingController txtfeedBack = new TextEditingController();
  bool isLoading = false;
  var rating;

  _feedBackToMaterAdmin() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberId": sharedPrefs.memberId,
          "message": txtfeedBack.text,
          "rating": rating,
        };
        print("$body");
        Services.responseHandler(apiName: "api/member/addMemberFeedback", body: body)
            .then((responseData) {
          print(responseData.Data);
          if (responseData.Data.length >  0) {
            setState(() {
              isLoading = false;
            });
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: "You Successfully Rate MyWatcher Application",
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity: ToastGravity.TOP,
            );
          } else {
            print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
            msg: "Error $error",
            backgroundColor: Colors.white,
            textColor: appPrimaryMaterialColor,
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "You aren't connected to the Internet !",
        backgroundColor: Colors.white,
        textColor: appPrimaryMaterialColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Support  &  Feedback',
                //overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Montserrat",
                  color: appPrimaryMaterialColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (ss) {
                rating = ss;
                print(ss);
              },
            ),
            SizedBox(
              height: 10,
            ),
            MyTextFormField(
                controller: txtfeedBack,
                maxLines: null,
                minLines: 2,
                lable: "Feedback",
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter Something";
                  }
                  return "";
                },
                hintText: "Type Feedback to MyWatcher"),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                    child: Text("Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.red[400].withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                RaisedButton(
                    child: Text("Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.green[400],
                    onPressed: () {
                      _feedBackToMaterAdmin();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
