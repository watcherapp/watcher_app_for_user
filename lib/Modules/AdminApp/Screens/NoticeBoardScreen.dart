import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AddNewNoticeScreen.dart';

class NoticeBoardScreen extends StatefulWidget {
  @override
  _NoticeBoardScreenState createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  bool isLoading = false;
  List noticeList = [];

  _getAllNotice() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/admin/getSocietyNotice", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            noticeList = responseData.Data;
            setState(() {
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

  @override
  void initState() {
    _getAllNotice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text(
            "Notice Board",
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: appPrimaryMaterialColor,
        ),
        body: Stack(
          children: [
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          appPrimaryMaterialColor),
                      //backgroundColor: Colors.white54,
                    ),
                  )
                : noticeList.length > 0
                    ? ListView.builder(
                        itemCount: noticeList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                            right: 5,
                            left: 5,
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // "Swimming Pool",
                                    noticeList[index]["noticeTitle"],
                                    style: TextStyle(
                                      color: appPrimaryMaterialColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    noticeList[index]["noticeDescription"],
                                    // "Notice about swimming pool which not clean from 1 week that it is hard to swim in that pool so do somthing about that",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: NoticeBoardSubScreen(
                                                noticeData: noticeList[index],
                                                AllNoticeApi: () {
                                                  _getAllNotice();
                                                },
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeft));
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: appPrimaryMaterialColor
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          " View More",
                                          style: TextStyle(
                                            color: appPrimaryMaterialColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 10.0),
                                  //   child: SizedBox(
                                  //     width: 100,
                                  //     height: 35,
                                  //     child: RaisedButton(
                                  //       child: Text(
                                  //         "View More",
                                  //         style: TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize: 12,
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       ),
                                  //       shape: RoundedRectangleBorder(
                                  //           borderRadius: BorderRadius.circular(6)),
                                  //       color: appPrimaryMaterialColor.withOpacity(0.8),
                                  //       onPressed: () {
                                  //         Navigator.push(
                                  //             context,
                                  //             PageTransition(
                                  //                 child: NoticeBoardSubScreen(
                                  //                   noticeData: noticeList[index],
                                  //                   AllNoticeApi: (){
                                  //                     _getAllNotice();
                                  //                   },
                                  //                 ),
                                  //                 type: PageTransitionType.rightToLeft));
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text("No Notice Found"),
                      ),
            Positioned(
              bottom: 30,
              right: 30,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: AddNewNoticeScreen(
                            getAllNoticeApi: () {
                              _getAllNotice();
                            },
                          ),
                          type: PageTransitionType.rightToLeft));
                },
                icon: Icon(Icons.add),
                label: Text("Add New Notice"),
              ),
            ),
          ],
        ));
  }
}

class NoticeBoardSubScreen extends StatefulWidget {
  var noticeData;
  Function AllNoticeApi;

  NoticeBoardSubScreen({
    this.noticeData,
    this.AllNoticeApi,
  });

  @override
  _NoticeBoardSubScreenState createState() => _NoticeBoardSubScreenState();
}

class _NoticeBoardSubScreenState extends State<NoticeBoardSubScreen> {
  bool isLoading = false;

  _deleteNotice() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "noticeId": widget.noticeData["_id"],
        };
        print("$body");
        Services.responseHandler(apiName: "api/admin/deleteNotice", body: body)
            .then((responseData) {
          if (responseData.Data != 0) {
            print(responseData.Data);
            widget.AllNoticeApi();
            Fluttertoast.showToast(
              msg: "Your Notice deleted Successfully.",
            );
            Navigator.pop(context);
            setState(() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Notice Board",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                      API_URL + widget.noticeData["noticeImage"],
                      // "https://graphicsfamily.com/wp-content/uploads/edd/2020/11/Tasty-Food-Web-Banner-Design-scaled.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.noticeData["noticeTitle"],
                    style: TextStyle(
                      color: appPrimaryMaterialColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.noticeData["noticeDescription"],
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Date : ${widget.noticeData["dateTime"][0]}",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlineButton(
                    child: new Text(
                      "Delete Notice",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      _deleteNotice();
                    },
                    borderSide: BorderSide(color: Colors.red),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
