import 'dart:developer';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vibration/vibration.dart';
import 'package:video_player/video_player.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ComplaintsScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/BottomNavigationBarCustom.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/MyVisitorListComponent.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/ComplainsScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/NoticesScreen.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UserEmergencyScreen.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  VideoPlayerController _controller;
  PageController _pageController;
  Future<void> _initializeVideoPlayerFuture;
  bool isVisitorLoading = false;
  List myGuestList = [];
  int x = -1;
  int vi = 0;

  DateTime selectedFromDate = DateTime.now();
  var dateFormate = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _pageController = PageController();

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
            // Fluttertoast.showToast(msg: "${responseData.Message}");
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

  // Platform messages are asynchronous, so we initialize in an async method.

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
      "image": "images/complain.png",
      "title": "Complains",
      "screenName": ComplainsScreen(),
    },
    {
      "image": "images/ad-campaign.png",
      "title": "Advertisement",
      "screenName": NoticesScreen(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 6.0, right: 6.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding:
                        const EdgeInsets.only(left: 8.0, bottom: 6.0, top: 8.0),
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
                                    type: PageTransitionType.fade));
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, bottom: 6.0, top: 8.0, right: 8),
                        child: Text(
                          "My Visitors",
                          style: fontConstants.listTitles,
                        ),
                      ),
                      myGuestList.length > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.skip_previous_outlined),
                                  onPressed: () {
                                    if (vi <= 0) {
                                      vi = 0;
                                    } else {
                                      vi--;
                                    }
                                    print("--->${vi}");
                                    if (_pageController.hasClients) {
                                      _pageController.animateToPage(
                                        vi,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                IconButton(
                                  icon: Icon(Icons.skip_next_outlined),
                                  onPressed: () {
                                    if (vi >= myGuestList.length - 1) {
                                      vi = myGuestList.length - 1;
                                    } else {
                                      vi++;
                                    }
                                    print("--->${vi}");
                                    if (_pageController.hasClients) {
                                      _pageController.animateToPage(
                                        vi,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                )
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  // Container(
                  //   color: Colors.red,
                  //   child: Center(
                  //     child: RaisedButton(
                  //       color: Colors.white,
                  //       onPressed: () {
                  //         if (_pageController.hasClients) {
                  //           _pageController.animateToPage(
                  //             1,
                  //             duration: const Duration(milliseconds: 400),
                  //             curve: Curves.easeInOut,
                  //           );
                  //         }
                  //       },
                  //       child: Text('Next'),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   color: Colors.blue,
                  //   child: Center(
                  //     child: RaisedButton(
                  //       color: Colors.white,
                  //       onPressed: () {
                  //         if (_pageController.hasClients) {
                  //           _pageController.animateToPage(
                  //             0,
                  //             duration: const Duration(milliseconds: 400),
                  //             curve: Curves.easeInOut,
                  //           );
                  //         }
                  //       },
                  //       child: Text('Previous'),
                  //     ),
                  //   ),
                  // ),
                  myGuestList.length > 0
                      ? SizedBox(
                          height: 310,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: myGuestList.length,
                            itemBuilder: (BuildContext context, int index) {
                              print(myGuestList.length);
                              print(index);
                              return MyVisitorListComponent(
                                visitorData: myGuestList[index],
                                index: index,
                              );
                            },
                          ),
                        )
                      : SizedBox(
                          height: 310,
                          child: Center(
                            child: Text("No Visitor Entry found on your flat"),
                          ),
                        ),
                ],
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01,
                right: MediaQuery.of(context).size.width * 0.08,
                child: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => ShowDialog());
                  },
                  backgroundColor: Colors.red[200],
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red[400],
                          borderRadius: BorderRadius.circular(100.0)),
                      width: 40,
                      height: 40,
                      child: Center(
                          child: Text(
                        "SOS",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ))),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(
          // index2: 2,
          ),
    );
  }
}

class ShowDialog extends StatefulWidget {
  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  TextEditingController typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  List wingList = [];
  String wingName;

  // String wing_Type;

  List wing_Type;
  List wingId = [];

  var wing = "";
  int isSelect = -1;

  _getAllWings() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": "${sharedPrefs.societyId}",
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/getAllWingsOfSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              wingList = responseData.Data;
              print("Wings----------------->$wingList");
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

  _sendSos() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body;
        print("wingId");
        print(wingId);
        wingId.isEmpty == true
            ? body = {
                "senderId": sharedPrefs.memberId,
                "message": typeController.text,
                "description": descriptionController.text,
                "gmapLink": "googlemap.com",
                "sendBy": 0,
                "societyId": "${sharedPrefs.societyId}",
              }
            : body = {
                "senderId": sharedPrefs.memberId,
                "message": typeController.text,
                "description": descriptionController.text,
                "gmapLink": "googlemap.com",
                "sendBy": 0,
                "wingIdList": wingId,
                "societyId": "${sharedPrefs.societyId}",
              };

        print("$body");
        wingList.clear();
        Services.responseHandler(apiName: "api/member/sendSOS", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "SOS Raised Successfully",
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity: ToastGravity.TOP,
            );
            // wingList.clear();
            typeController.clear();
            descriptionController.clear();
            Navigator.pop(context);
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
    _getAllWings();
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
            Text(
              'Raise SOS',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.report,
              size: 33,
              color: Colors.red,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                    child: Text(
                      "Select Wing",
                      style: fontConstants.formFieldLabel,
                    ),
                  ),
                  MultiSelectDialogField(
                    items: wingList
                        .map((wingData) =>
                            MultiSelectItem(wingData, wingData["wingName"]))
                        .toList(),
                    listType: MultiSelectListType.LIST,
                    onSelectionChanged: (values) {
                      wing_Type = values;

                      // for(int i=0;i<wing_Type.length;i++) {
                      //   if(wing_Type[i]["_id"]==values[i]["_id"]){
                      //
                      //   }
                      // }
                    },
                    onConfirm: (values) {
                      wingId.clear();
                      // print(values);
                      for (int i = 0; i < values.length; i++) {
                        wingId.add(values[i]["_id"]);
                      }
                      print(wingId);
                    },
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    buttonIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    buttonText: Text(
                      "Select Wing",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 3.0, right: 3),
              //   child: DialogOpenFormField(
              //       lable: "Select Wing",
              //       hintLable: "Wing Name",
              //       value: wingName,
              //       onTap: () {
              //         print("click");
              //         FocusScope.of(context).unfocus();
              //         showDialog(
              //           builder: (context) => Padding(
              //             padding: const EdgeInsets.only(top: 4.0),
              //             child: MyDropDown(
              //                 isSearchable: false,
              //                 dropDownTitle: "Select Relation",
              //                 dropDownData: wingList,
              //                 onSelectValue: (value) {
              //                   setState(() {
              //                     wingName = value;
              //                   });
              //                 }),
              //           ),
              //           context: context,
              //         );
              //       }),
              // ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3),
                child: MyTextFormField(
                  lable: "Type Emergency",
                  controller: typeController,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter type of Emergency";
                    }
                    return "";
                  },
                  hintText: "Type Emergency",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3),
                child: MyTextFormField(
                  lable: "Suggest an Response",
                  controller: descriptionController,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter relevent Response";
                    }
                    return "";
                  },
                  hintText: "Stay Calm and Indoors",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11.0, right: 11),
                child: MyButton(
                    title: "Raise an SOS",
                    onPressed: () {
                      _sendSos();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
