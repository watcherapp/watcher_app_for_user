import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/labelWithAddButton.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/Authentication/SignIn.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/AddComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/DailyHelperComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/FamilyMemberComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/MyResidentComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/MyVehicleComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/AddFamilyMember.dart';
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
  bool ismemberLoading;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getMyFamilyMember();
    _getMyStaff();
    _getMyVehical();
    _memberDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        appPrimaryMaterialColor),
                    //backgroundColor: Colors.white54,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
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
                                                fit: BoxFit.fill,
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
                                          myProfileFun: (){
                                            _memberDetail();
                                          },
                                          profileData: memberList,
                                        ),
                                        type: PageTransitionType
                                            .rightToLeft));
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
                          itemCount: length + 1,
                          itemBuilder: (context, index) {
                            if (index == length) {
                              return AddComponent(width: 100, onTap: () {});
                            } else {
                              return isLoading
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
                                  : MyResidentComponent();
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
                                              memberApi: (){
                                                _getMyFamilyMember();
                                              },
                                            ),
                                            type: PageTransitionType
                                                .rightToLeft));
                                  });
                            } else {
                              return isLoading
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
                                              staffDataApi: (){
                                                _getMyStaff();
                                              },
                                            ),
                                            type: PageTransitionType
                                                .rightToLeft));
                                  });
                            } else {
                              return isLoading
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
                          itemCount: length + 1,
                          itemBuilder: (context, index) {
                            if (index == length) {
                              return AddComponent(
                                  width: 100,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: VehicleScreen(),
                                            type: PageTransitionType
                                                .rightToLeft));
                                  });
                            } else {
                              return isLoading
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
                                  : MyVehicleComponent();
                            }
                          }),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12.0, right: 10, top: 23),
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
                      padding:
                          const EdgeInsets.only(left: 12.0, right: 10, top: 23),
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
                    Padding(
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12.0, right: 10, top: 23),
                      child: Row(
                        children: [
                          Image.asset("images/feedback.png", width: 23),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('Complaint',
                                //overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Montserrat",
                                    color: Colors.black87)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12.0, right: 10, top: 22),
                      child: Row(
                        children: [
                          Image.asset("images/share.png", width: 21),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('Tell a friend about Wather',
                                //overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Montserrat",
                                    color: Colors.black87)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sharedPrefs.logout();
                        Navigator.of(context).pushAndRemoveUntil(
                            PageTransition(
                                child: SignIn(),
                                type: PageTransitionType.rightToLeft),
                            (Route<dynamic> route) => false);
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
              ));
  }

  _getMyFamilyMember() async {
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
          "societyId": "${sharedPrefs.societyId}",
        };

        Services.responseHandler(
                apiName: "api/member/getFamilyMembers", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              familyMemberList = responseData.Data;
              isLoading = false;
            });
            print("familyMemberList-------------------->$familyMemberList");
          } else {
            print(responseData);
            setState(() {
              familyMemberList = responseData.Data;
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
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

  _getMyStaff() async {
    print("Calling");
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
          // "wingId" : sharedPrefs.wingId,
          // "flatId" : sharedPrefs.flatId,
        };

        Services.responseHandler(
                apiName: "api/member/getAllStaffDetails", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              staffList = responseData.Data;
              isLoading = false;
            });
            print("staffList-------------------->$staffList");
          } else {
            print(responseData);
            setState(() {
              staffList = responseData.Data;
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
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

  _getMyVehical() async {
    print("Calling");
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print("${sharedPrefs.memberId}");
        var body = {
          "memberId": "${sharedPrefs.memberId}",
        };
        Services.responseHandler(
                apiName: "api/member/getMemberVehicles", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              vehicleList = responseData.Data;
              isLoading = false;
            });
            print("vehicleList-------------------->$vehicleList");
          } else {
            print(responseData);
            setState(() {
              vehicleList = responseData.Data;
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
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

  _memberDetail() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {"mobileNo": "${sharedPrefs.mobileNo}"};
        print(
            "------------------------------------------------------------->${body}");
        setState(() {
          ismemberLoading = true;
        });
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
              memberList = responseData.Data;
              ismemberLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
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
}
