import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/BottomNavigationBarCustomForAdmin.dart';
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
        body: RefreshIndicator(
          onRefresh: () {
            return _getAllNotice();
          },
          color: appPrimaryMaterialColor,
          child: Stack(
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
                            child: NoticesComponent(
                              noticeData: noticeList[index],
                              noticeApi: (){
                                _getAllNotice();
                              },
                            ),
                            // child: Card(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           // "Swimming Pool",
                            //           noticeList[index]["noticeTitle"],
                            //           style: TextStyle(
                            //             color: appPrimaryMaterialColor,
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 15,
                            //           ),
                            //         ),
                            //         Divider(
                            //           color: Colors.grey,
                            //         ),
                            //         Text(
                            //           noticeList[index]["noticeDescription"],
                            //           // "Notice about swimming pool which not clean from 1 week that it is hard to swim in that pool so do somthing about that",
                            //           style: TextStyle(
                            //             color: Colors.grey[600],
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 15,
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height: 10,
                            //         ),
                            //         GestureDetector(
                            //           onTap: () {
                            //             Navigator.push(
                            //                 context,
                            //                 PageTransition(
                            //                     child: NoticeBoardSubScreen(
                            //                       noticeData: noticeList[index],
                            //                       AllNoticeApi: () {
                            //                         _getAllNotice();
                            //                       },
                            //                     ),
                            //                     type: PageTransitionType
                            //                         .rightToLeft));
                            //           },
                            //           child: Container(
                            //             width: 100,
                            //             height: 35,
                            //             decoration: BoxDecoration(
                            //                 color: appPrimaryMaterialColor
                            //                     .withOpacity(0.2),
                            //                 borderRadius:
                            //                     BorderRadius.circular(6.0)),
                            //             child: Padding(
                            //               padding: const EdgeInsets.all(8.0),
                            //               child: Text(
                            //                 " View More",
                            //                 style: TextStyle(
                            //                   color: appPrimaryMaterialColor,
                            //                   fontSize: 14,
                            //                   fontWeight: FontWeight.bold,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //         // Padding(
                            //         //   padding: const EdgeInsets.only(top: 10.0),
                            //         //   child: SizedBox(
                            //         //     width: 100,
                            //         //     height: 35,
                            //         //     child: RaisedButton(
                            //         //       child: Text(
                            //         //         "View More",
                            //         //         style: TextStyle(
                            //         //           color: Colors.white,
                            //         //           fontSize: 12,
                            //         //           fontWeight: FontWeight.bold,
                            //         //         ),
                            //         //       ),
                            //         //       shape: RoundedRectangleBorder(
                            //         //           borderRadius: BorderRadius.circular(6)),
                            //         //       color: appPrimaryMaterialColor.withOpacity(0.8),
                            //         //       onPressed: () {
                            //         //         Navigator.push(
                            //         //             context,
                            //         //             PageTransition(
                            //         //                 child: NoticeBoardSubScreen(
                            //         //                   noticeData: noticeList[index],
                            //         //                   AllNoticeApi: (){
                            //         //                     _getAllNotice();
                            //         //                   },
                            //         //                 ),
                            //         //                 type: PageTransitionType.rightToLeft));
                            //         //       },
                            //         //     ),
                            //         //   ),
                            //         // ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
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
                            type: PageTransitionType.fade));
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add New Notice"),
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),

    );
  }
}


//notice component........................................................
class NoticesComponent extends StatefulWidget {
  var noticeData;
  Function noticeApi;

  NoticesComponent({
    this.noticeData,
    this.noticeApi,
  });

  @override
  _NoticesComponentState createState() => _NoticesComponentState();
}

class _NoticesComponentState extends State<NoticesComponent> {
  String dateData;
  String timeData;
  var time, time1;
  var date;
  String month;
  String monthName;

  @override
  void initState() {
    //dateData = " ${widget.notificationData["date"]}";
    funDate();
    funTime();
  }

  funDate() {
    dateData = "${widget.noticeData["dateTime"][0]}";
    date = dateData.split('/');
    print(date);
  }

  funTime() {
    timeData = "${widget.noticeData["dateTime"][1]}";
    time = timeData.split(':');
    time1 = timeData.split(" ");
    print(time);
    print(time1);
  }

  String funMonth(String mon) {
    if (mon == "01") {
      return month = "Jan";
    } else if (mon == "02") {
      return month = "Feb";
    } else if (mon == "03") {
      return month = "March";
    } else if (mon == "04") {
      return month = "April";
    } else if (mon == "05") {
      return month = "May";
    } else if (mon == "06") {
      return month = "June";
    } else if (mon == "07") {
      return month = "July";
    } else if (mon == "08") {
      return month = "Aug";
    } else if (mon == "09") {
      return month = "Sept";
    } else if (mon == "10") {
      return month = "Oct";
    } else if (mon == "11") {
      return month = "Nov";
    } else if (mon == "12") {
      return month = "Dec";
    } else {
      return month = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        //height: 210,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18),
              child: Text(
                "${widget.noticeData["noticeTitle"]}",
                style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                height: 0.3,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18, right: 18),
              child: Text(
                "${widget.noticeData["noticeDescription"]}",
                textAlign: TextAlign.justify,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 14, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " - Covid Checking",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: appPrimaryMaterialColor),
                  ),
                ],
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                height: 0.4,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: NoticeBoardSubScreen(
                                noticeData: widget.noticeData,
                                AllNoticeApi: () {
                                  widget.noticeApi();
                                },
                              ),
                              type: PageTransitionType
                                  .fade));
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          color: appPrimaryMaterialColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6.0)),
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
                  Container(
                    decoration: BoxDecoration(
                      color: appPrimaryMaterialColor[100],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        "${date[0]}" +
                            "-" +
                            "${funMonth(date[1])}" +
                            "-" +
                            "${date[2]}",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                    height: 33,
                    width: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: appPrimaryMaterialColor[100],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                          "${time1[0]}" + " " + "${time1[1]}",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: appPrimaryMaterialColor),
                        ),
                      ),
                      height: 33,
                      width: 86,
                    ),
                  ),

                  /*FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    height: 32,
                    color: appPrimaryMaterialColor[100],
                    onPressed: () {},
                    child: Text(
                      "22 Jan 2021",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: appPrimaryMaterialColor),
                    ),
                  ),*/
                  /* Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      height: 32,
                      color: appPrimaryMaterialColor[100],
                      onPressed: () {},
                      child: Text(
                        "02:46 PM",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//notice sub screen.........................................................
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
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity:ToastGravity.TOP,
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.noticeData["noticeTitle"],
                  style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
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
