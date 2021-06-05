import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/UpdateProfile.dart';
import 'package:watcher_app_for_user/Modules/Authentication/SignIn.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List dataList = [];
  bool isLoading = false;

  @override
  void initState() {
    _getAllMemberData();
  }

  _getAllMemberData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(sharedPrefs.mobileNo);
        var body = {
          "mobileNo": sharedPrefs.mobileNo,
        };
        Services.responseHandler(
                apiName: "api/member/getMemberInformation", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            setState(() {
              dataList = responseData.Data;
              print(dataList);
              isLoading = false;
            });
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
        Services.responseHandler(
            apiName: "api/member/memberLogout", body: body)
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
              msg:
              "You are Logout Successfully",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
          } else {
            print(responseData);
            setState(() {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Container(),
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: UpdateProfile(
                        profileData: dataList,
                        myProfileFun: (){
                          _getAllMemberData();
                        },
                      ),
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
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                // backgroundColor: Colors.red,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
              ),
            )
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      "${dataList[0]["memberImage"]}" != ""
                          // ||
                          //     "${dataList[0]["memberImage"]}" != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Container(
                                height: 150.0,
                                width: MediaQuery.of(context).size.width / 1,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 0.2,
                                      color: appPrimaryMaterialColor),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      API_URL + dataList[0]["memberImage"],
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            )
                          // Image.network(
                          //         API_URL + dataList[0]["memberImage"],
                          //         width: 170,
                          //   height: 100,
                          //       )
                          : Image.asset(
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
                    child: Text(
                        "${dataList[0]["firstName"]} ${dataList[0]["lastName"]}",
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
                          "${dataList[0]["mobileNo1"]}",
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
                          "${dataList[0]["emailId"]}",
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
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: ListTile(
                    leading: Image.asset(
                      "images/dfile.png",
                      width: 20,
                      color: appPrimaryMaterialColor,
                    ),
                    title: Text(
                      "Tearms and Condition",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        // color: Colors.black),
                      ),
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
                GestureDetector(
                  onTap: () {
                    _logOutMember();
                    // sharedPrefs.logout();
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     PageTransition(
                    //         child: SignIn(),
                    //         type: PageTransitionType.rightToLeft),
                    //     (Route<dynamic> route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: ListTile(
                      leading: Image.asset(
                        "images/logout.png",
                        width: 20,
                        color: appPrimaryMaterialColor,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          // color: Colors.black),
                        ),
                      ),
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
