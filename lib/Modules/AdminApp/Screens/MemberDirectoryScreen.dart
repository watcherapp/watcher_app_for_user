import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/MemberDirectoryComponent.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class MemberDirectoryScreen extends StatefulWidget {
  @override
  _MemberDirectoryScreenState createState() => _MemberDirectoryScreenState();
}

class _MemberDirectoryScreenState extends State<MemberDirectoryScreen> {
  List getAllWingList = [];
  List getAllWingMemberData = [];
  bool isLoading = false;
  int selectedW = -1;

  @override
  void initState() {
    _getAllWings();
  }

  _getAllWings() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(sharedPrefs.societyCode);
        var body = {
          "societyCode": sharedPrefs.societyCode,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/getAllWingsOfSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              getAllWingList = responseData.Data;
              print("Wings----------------->$getAllWingList");
              isLoading = false;
            });
            _getAllWingsMember(wingId: getAllWingList[0]["_id"]);
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

  _getAllWingsMember({String wingId}) async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(sharedPrefs.societyCode);
        var body = {
          "societyId": sharedPrefs.societyId,
          "wingId": wingId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/member/getWingMembers", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              getAllWingMemberData = responseData.Data;
              print("Wings----------------->$getAllWingMemberData");
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
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.notifications_active_rounded),
        //     onPressed: () {},
        //   ),
        // ],
        title: Text(
          "Member Directory",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Select Building",
              style: TextStyle(
                  color: appPrimaryMaterialColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              // width: 100,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 5, bottom: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: getAllWingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedW = index;
                            _getAllWingsMember(
                                wingId: getAllWingList[index]["_id"]);
                          });
                          // _getAllFlats(wingId: getAllWingList[index]["_id"]);
                          print("${getAllWingList[index]["wingName"]}");
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Card(
                            color: selectedW == index
                                ? appPrimaryMaterialColor
                                : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 10, right: 10, bottom: 8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      child: Image(
                                        color: selectedW == index
                                            ? Colors.white
                                            : appPrimaryMaterialColor,
                                        image: AssetImage(
                                          "images/building.png",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("${getAllWingList[index]["wingName"]}",
                                        style: TextStyle(
                                          color: selectedW == index
                                              ? Colors.white
                                              : appPrimaryMaterialColor,
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // decoration: BoxDecoration(
                          //   color: selectedF == index
                          //       ? appPrimaryMaterialColor
                          //       : Colors.white,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                        ),
                      ),
                    );
                  }),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //       children: getAllWingList.map((data) {
            //     return Padding(
            //       padding: EdgeInsets.only(left: 7),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           GestureDetector(
            //             child: Container(
            //               height: 100,
            //               width: 100,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               child: Padding(
            //                 padding: EdgeInsets.all(2),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Container(
            //                       height: 40,
            //                       width: 40,
            //                       child: Image(
            //                         color: appPrimaryMaterialColor,
            //                         image: AssetImage(
            //                           "images/building.png",
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //                     Text(
            //                       data["wingName"],
            //                       style: TextStyle(
            //                           color: appPrimaryMaterialColor,
            //                           // fontWeight: FontWeight.bold,
            //                           fontSize: 13),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             onTap: () {
            //               print(data["lable"]);
            //               // launchUrl("tel:9879208321");
            //             },
            //           )
            //         ],
            //       ),
            //     );
            //   }).toList()),
            // ),
            SizedBox(
              height: 10,
            ),
            isLoading
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
                : Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: ListView.builder(
                      itemBuilder: (_, index) => Container(
                        height: 120,
                        child: MemberDirectoryComponent(
                          memberData: getAllWingMemberData[index],
                        ),
                        // child: Card(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(5.0),
                        //     child: Row(
                        //       children: [
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         getAllWingMemberData[index]["memberImage"] ==
                        //                     null ||
                        //                 getAllWingMemberData[index]
                        //                         ["memberImage"] ==
                        //                     ""
                        //             ? Image.asset(
                        //                 'images/user.png',
                        //                 width: 70,
                        //                 height: 70,
                        //               )
                        //             : Padding(
                        //                 padding:
                        //                     const EdgeInsets.only(top: 3.0),
                        //                 child: Container(
                        //                   height: 70.0,
                        //                   width: 70,
                        //                   decoration: BoxDecoration(
                        //                     // borderRadius: BorderRadius.circular(30),
                        //                     color: Colors.white,
                        //                     shape: BoxShape.circle,
                        //                     border: Border.all(
                        //                         width: 0.2,
                        //                         color: appPrimaryMaterialColor),
                        //                     image: DecorationImage(
                        //                       image: NetworkImage(
                        //                         API_URL +
                        //                             getAllWingMemberData[index]
                        //                                 ["memberImage"],
                        //                       ),
                        //                       fit: BoxFit.fill,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //         SizedBox(
                        //           width: 15,
                        //         ),
                        //         Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Text(
                        //               "${getAllWingMemberData[index]["firstName"]} ${getAllWingMemberData[index]["lastName"]}",
                        //               style: TextStyle(
                        //                   color: appPrimaryMaterialColor,
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 14),
                        //             ),
                        //             SizedBox(
                        //               height: 5,
                        //             ),
                        //             Text(
                        //                 "${getAllWingMemberData[index]["FlatData"][0]["flatNo"]}"),
                        //             SizedBox(
                        //               height: 2,
                        //             ),
                        //             Text(
                        //                 '${getAllWingMemberData[index]["mobileNo1"]}'),
                        //             SizedBox(
                        //               height: 2,
                        //             ),
                        //             Text('Resident'),
                        //           ],
                        //         ),
                        //         SizedBox(
                        //           width: 105,
                        //         ),
                        //         IconButton(
                        //           icon: Icon(Icons.message),
                        //           iconSize: 25,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ),
                      // itemCount: 8,
                      itemCount: getAllWingMemberData.length,
                    ),
                  ),
            // Card(
            //   child: Padding(
            //     padding: const EdgeInsets.all(5.0),
            //     child: ListTile(
            //       leading:
            //           Image.asset('images/user.png', width: 60, height: 60),
            //       title: Text('smit vaghani'),
            //       subtitle: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('B1 - 07'),
            //           Text('8735069293'),
            //           Text('Resident'),
            //         ],
            //       ),
            //       // trailing: SizedBox(
            //       //   width: 130,
            //       //   height: 40,
            //       //   child: RaisedButton(
            //       //       child: Text(
            //       //         "Request Number",
            //       //         style: TextStyle(
            //       //             color: Colors.white,
            //       //             fontSize: 11,
            //       //             fontWeight: FontWeight.bold),
            //       //       ),
            //       //       shape: RoundedRectangleBorder(
            //       //           borderRadius: BorderRadius.circular(6)),
            //       //       color: appPrimaryMaterialColor,
            //       //       onPressed: () {}),
            //       // ),
            //       trailing: IconButton(
            //         icon: Icon(Icons.message),
            //         iconSize: 25,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
