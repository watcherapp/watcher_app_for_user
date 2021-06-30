import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/MyProperties.dart';

class EntryConfirmationPopup extends StatefulWidget {
  var visitorData;

  EntryConfirmationPopup({
    this.visitorData,
  });

  @override
  _EntryConfirmationPopupState createState() => _EntryConfirmationPopupState();
}

class _EntryConfirmationPopupState extends State<EntryConfirmationPopup> {

  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("visitor data========>${widget.visitorData}");
  }

  _approveGuest() async {
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
          "isApprove": true,
          "entryId": "${widget.visitorData["EntryId"]}",
        };
        print(
            "------------------------------------------------------------->${body}");
        Services.responseHandler(
            apiName: "api/member/unknownVisitorApproval", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            print(responseData.Message);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "You are Successfully Approve Guest",
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity: ToastGravity.TOP,
            );
            // Navigator.pop(context);
            // Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: MyProperties(),
                type: PageTransitionType.bottomToTop,
              ),
            );
          } else {
            print(responseData);
            setState(() {
              // familyMemberList = responseData.Data;
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

  _disapproveGuest() async {
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
          "isApprove": false,
          "entryId": "${widget.visitorData["EntryId"]}",
        };
        print(
            "------------------------------------------------------------->${body}");
        Services.responseHandler(
            apiName: "api/member/unknownVisitorApproval", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            print(responseData.Message);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "You are Successfully Disapprove Guest",
              // backgroundColor: Colors.green,
              backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity: ToastGravity.TOP,
            );
            // Navigator.pop(context);
            // Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: MyProperties(),
                type: PageTransitionType.bottomToTop,
              ),
            );
          } else {
            print(responseData);
            setState(() {
              // familyMemberList = responseData.Data;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 32, 82, 0.7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Center(
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 150,
                            ),
                            Text(
                              "Guest is waiting At Gate",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${widget.visitorData["Name"]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.grey[800]),
                                ),
                                Text(
                                  "${widget.visitorData["ContactNo"]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.grey[800]),
                                ),
                                // SizedBox(
                                //   width: 30,
                                // ),
                                // Row(
                                //   children: [
                                //     GestureDetector(
                                //       onTap: () {},
                                //       child: Column(
                                //         children: <Widget>[
                                //           Image.asset('images/icons/success.png',
                                //               width: 40, height: 40),
                                //         ],
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 15,
                                //     ),
                                //     GestureDetector(
                                //       onTap: () {},
                                //       child: Column(
                                //         children: <Widget>[
                                //           Image.asset('images/icons/success.png',
                                //               width: 40, height: 40),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  widget.visitorData["Image"] != null || widget.visitorData["Image"] != ""
                      ? Positioned(
                          left: 20,
                          right: 20,
                          child: Column(
                            children: [
                              AvatarGlow(
                                glowColor: Colors.orangeAccent,
                                endRadius: 90.0,
                                duration: Duration(milliseconds: 2000),
                                repeat: true,
                                showTwoGlows: true,
                                repeatPauseDuration:
                                    Duration(milliseconds: 100),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Container(
                                    height: 100.0,
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
                                          API_URL +
                                              "${widget.visitorData["Image"]}",
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Positioned(
                          left: 20,
                          right: 20,
                          child: Column(
                            children: [
                              AvatarGlow(
                                glowColor: Colors.orangeAccent,
                                endRadius: 90.0,
                                duration: Duration(milliseconds: 2000),
                                repeat: true,
                                showTwoGlows: true,
                                repeatPauseDuration:
                                    Duration(milliseconds: 100),
                                child: CircleAvatar(
                                  radius: 60,
                                  child: ClipOval(
                                    child: Image.network(
                                      "https://randomuser.me/api/portraits/men/11.jpg",
                                      // API_URL +
                                      //     "${widget.visitorData["Image"]}",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  //company image
                  // Positioned(
                  //   top: 80,
                  //   left: 20,
                  //   right: -180,
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.transparent,
                  //     // maxRadius: 30,
                  //     radius: 30,
                  //     child: Container(
                  //       // height: 60,
                  //       // width: 60,
                  //       child: Image.network(
                  //         "images/icons/success.png",
                  //         width: 60,
                  //         height: 60,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    bottom: -25,
                    left: 20,
                    right: -180,
                    child: GestureDetector(
                      onTap: () {
                        _approveGuest();
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(65)),
                                child: Image.asset("images/icons/success.png")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "APPROVE",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: -25,
                  //   left: 20,
                  //   right: 20,
                  //   child: GestureDetector(
                  //     onTap: () {},
                  //     child: Column(
                  //       children: [
                  //         CircleAvatar(
                  //           backgroundColor: Colors.transparent,
                  //           radius: 25,
                  //           child: ClipRRect(
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(65)),
                  //               child: Image.asset("images/icons/success.png")),
                  //         ),
                  //         SizedBox(
                  //           height: 10,
                  //         ),
                  //         Text(
                  //           "LEAVE AT GATE",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 12,
                  //               color: Colors.white),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    bottom: -25,
                    left: -180,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        _disapproveGuest();
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(65)),
                                child: Image.asset("images/error.png")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "DENY",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Image.asset('images/logomini.png', width: 100, height: 100),
          ],
        ),
      ),
    );
  }
}
