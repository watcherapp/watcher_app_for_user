import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:watcher_app_for_user/CommonWidgets/BottomNavigationBarWithFab.dart';
import 'package:watcher_app_for_user/Constants/ClassList.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Providers/IndexCountProvider.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ComplaintsScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/MemberApprovelScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/EmergencyScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/InteractionScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/MemberDirectoryScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AdvertisementScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/HelpDeskScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/MyProfile.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/MyVisitors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ParkingScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ManagementScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/WatcherScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ChattingScreeen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AdminHomeScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/MyWatcherScreen.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List screenList = [
    MyWatcherScreen(),
    MyVisitors(),
    AdminHomeScreen(),
    ChattingScreeen(),
    MyProfile(),
  ];

  // List dashFields = [
  //   {
  //     "label": "Complaints",
  //     "img": "images/complain.png",
  //     "screenName": ComplaintsScreen(),
  //   },
  //   {
  //     "label": "Directory",
  //     "img": "images/directory1.png",
  //     "screenName": InteractionScreen(),
  //   },
  //   {
  //     "label": "Parking",
  //     "img": "images/car.png",
  //     "screenName": ParkingScreen(),
  //   },
  //   {
  //     "label": "My Building",
  //     "img": "images/building.png",
  //     "screenName": InteractionScreen(),
  //   },
  //   {
  //     "label": "Emergency",
  //     "img": "images/alarm.png",
  //     "screenName": EmergencyScreen(),
  //   },
  //   {
  //     "label": "Advertisement",
  //     "img": "images/ad-campaign.png",
  //     "screenName": AdvertisementScreen(),
  //   },
  //   {
  //     "label": "Management",
  //     "img": "images/team.png",
  //     "screenName": ManagementScreen(),
  //   },
  //   {
  //     "label": "Interaction",
  //     "img": "images/chat.png",
  //     "screenName": InteractionScreen(),
  //   },
  //   {
  //     "label": "Help Desk",
  //     "img": "images/communications.png",
  //     "screenName": HelpDeskScreen(),
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<IndexCountProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   backgroundColor: appPrimaryMaterialColor,
      //   title: Container(
      //     width: 220,
      //     child: FlatButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context,
      //               PageTransition(
      //                   child: MyProperties(),
      //                   type: PageTransitionType.bottomToTop));
      //         },
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           // crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             SizedBox(),
      //             Text(
      //               "Xyz",
      //               style: TextStyle(
      //                   color: Colors.white, fontWeight: FontWeight.bold),
      //             ),
      //             Icon(
      //               Icons.keyboard_arrow_down_sharp,
      //               color: Colors.white,
      //             )
      //           ],
      //         ),
      //         shape: RoundedRectangleBorder(
      //             side: BorderSide(
      //                 color: Colors.white, width: 1, style: BorderStyle.solid),
      //             borderRadius: BorderRadius.circular(5))),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 4.0),
      //       child: IconButton(
      //           icon: Icon(
      //             Icons.notifications,
      //             color: Colors.white,
      //           ),
      //           onPressed: () {}),
      //     )
      //   ],
      // ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(height: 10,),
      //       /* Padding(
      //         padding: const EdgeInsets.only(left: 13.0, right: 13, top: 20),
      //         child: Container(
      //             height: 55,
      //             width: MediaQuery.of(context).size.width,
      //             decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 border: Border.all(color: Colors.white, width: 1.5),
      //                 borderRadius: BorderRadius.all(Radius.circular(9.0)),
      //                 boxShadow: [
      //                   BoxShadow(
      //                       color: Colors.grey.withOpacity(0.2),
      //                       blurRadius: 2.0,
      //                       spreadRadius: 2.0,
      //                       offset: Offset(3.0, 5.0))
      //                 ]),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 11.0),
      //                   child: Text(
      //                     "28 Days remaning",
      //                     textAlign: TextAlign.center,
      //                     style: TextStyle(
      //                         color: Colors.black,
      //                         fontSize: 13,
      //                         fontWeight: FontWeight.w600,
      //                         fontFamily: 'Montserrat'),
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(right: 11.0),
      //                   child: Text(
      //                     "View Pricing",
      //                     textAlign: TextAlign.center,
      //                     style: TextStyle(
      //                         color: appPrimaryMaterialColor,
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.bold,
      //                         fontFamily: 'Montserrat'),
      //                   ),
      //                 ),
      //               ],
      //             )),
      //       ),*/
      //       SizedBox(
      //         height: 20,
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Share.share(
      //               '02541655 Share above code with building members to join xyz.');
      //         },
      //         child: Padding(
      //           padding: const EdgeInsets.only(left: 13.0, right: 13),
      //           child: Container(
      //               height: 95,
      //               width: MediaQuery.of(context).size.width,
      //               decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   border: Border.all(color: Colors.white, width: 1.5),
      //                   borderRadius: BorderRadius.all(Radius.circular(9.0)),
      //                   boxShadow: [
      //                     BoxShadow(
      //                         color: Colors.grey.withOpacity(0.2),
      //                         blurRadius: 2.0,
      //                         spreadRadius: 2.0,
      //                         offset: Offset(3.0, 5.0))
      //                   ]),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Expanded(
      //                     child: Column(
      //                       children: [
      //                         Padding(
      //                           padding: const EdgeInsets.only(left: 11.0),
      //                           child: Text(
      //                             "0160203220",
      //                             style: TextStyle(
      //                                 color: appPrimaryMaterialColor,
      //                                 fontSize: 15,
      //                                 fontWeight: FontWeight.bold,
      //                                 fontFamily: 'Montserrat'),
      //                           ),
      //                         ),
      //                         Padding(
      //                           padding: const EdgeInsets.only(
      //                               left: 11.0, right: 10),
      //                           child: Text(
      //                             "Share above code with building members to join xyz,",
      //                             textAlign: TextAlign.start,
      //                             style: TextStyle(
      //                                 color: Colors.black,
      //                                 fontSize: 11,
      //                                 fontWeight: FontWeight.w600,
      //                                 fontFamily: 'Montserrat'),
      //                           ),
      //                         ),
      //                       ],
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     ),
      //                   ),
      //                   Padding(
      //                       padding:
      //                           const EdgeInsets.only(right: 25.0, left: 8),
      //                       child: Icon(
      //                         Icons.share,
      //                         color: appPrimaryMaterialColor,
      //                         size: 32,
      //                       )),
      //                 ],
      //               )),
      //         ),
      //       ),
      //       GridView.builder(
      //         shrinkWrap: true,
      //         physics: NeverScrollableScrollPhysics(),
      //         padding: EdgeInsets.only(top: 8, left: 11, right: 11),
      //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 3,
      //             childAspectRatio: 1,
      //             crossAxisSpacing: 4.0,
      //             mainAxisSpacing: 3.0),
      //         itemBuilder: (BuildContext context, int index) {
      //           return dashBox(
      //             dashFields[index]["label"],
      //             dashFields[index]["img"],
      //             dashFields[index]["screenName"],
      //           );
      //         },
      //         itemCount: dashFields.length,
      //       ),
      //       SizedBox(
      //         height: 12,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 13.0, right: 13),
      //         child: Container(
      //             height: 80,
      //             width: MediaQuery.of(context).size.width,
      //             decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 border: Border.all(color: Colors.white, width: 1.5),
      //                 borderRadius: BorderRadius.all(Radius.circular(9.0)),
      //                 boxShadow: [
      //                   BoxShadow(
      //                       color: Colors.grey.withOpacity(0.2),
      //                       blurRadius: 2.0,
      //                       spreadRadius: 2.0,
      //                       offset: Offset(3.0, 5.0))
      //                 ]),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Image.asset(
      //                   "images/gate.png",
      //                   width: 38,
      //                   color: appPrimaryMaterialColor,
      //                 ),
      //                 FittedBox(
      //                   // fit: BoxFit.contain,
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(3.0),
      //                     child: Text(
      //                       "Watcher",
      //                       textAlign: TextAlign.center,
      //                       style: TextStyle(
      //                           color: appPrimaryMaterialColor,
      //                           fontSize: 12,
      //                           fontFamily: 'Montserrat',
      //                           fontWeight: FontWeight.w600),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             )),
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          "Hey, " + "${sharedPrefs.memberName}",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 0.0, right: 0.0),
              child: screenList[provider.bottomBarCurrentIndex],
            ),
          ),
        ],
      ),
//       drawer: Drawer(
//         child: ListView(
// //          padding: EdgeInsets.zero,
//           children: <Widget>[
//             Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Image.asset(
//                     "images/perso-outline.png",
//                     color: Colors.white,
//                     width: 160,
//                   ),
//                   Text("Megha Solanki",
//                       style: (TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                           fontFamily: 'Montserrat',
//                           fontWeight: FontWeight.w600))),
//                 ],
//               ),
//               color: appPrimaryMaterialColor,
//               height: MediaQuery.of(context).size.height / 3.2,
//               width: MediaQuery.of(context).size.width,
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.push(
//                     context,
//                     PageTransition(
//                         child: MyProfile(),
//                         type: PageTransitionType.rightToLeft));
//               },
//               child: Container(
//                 color: Colors.white,
//                 width: MediaQuery.of(context).size.width,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(left: 22.0, top: 25, bottom: 15),
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         "images/d1user.png",
//                         width: 18,
//                         color: appPrimaryMaterialColor,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20.0),
//                         child: Text(
//                           "Profile",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             //fontFamily: 'Montserrat',
//                             fontSize: 14,
//                             // color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Divider(
//               height: 0.5,
//               indent: 20,
//               color: Colors.grey,
//             ),
//             Container(
//               color: Colors.white,
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 22.0, top: 18, bottom: 15),
//                 child: Row(
//                   children: [
//                     Image.asset(
//                       "images/dfile.png",
//                       width: 19,
//                       color: appPrimaryMaterialColor,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: Text(
//                         "Tearms and Condition",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           //fontFamily: 'Montserrat',
//                           fontSize: 14,
//                           // color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Divider(
//               height: 0.5,
//               indent: 20,
//               color: Colors.grey,
//             ),
//             Container(
//               color: Colors.white,
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 22.0, top: 18, bottom: 15),
//                 child: Row(
//                   children: [
//                     Image.asset(
//                       "images/logout.png",
//                       width: 18,
//                       color: appPrimaryMaterialColor,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: Text(
//                         "Logout",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           //fontFamily: 'Montserrat',
//                           fontSize: 14,
//                           // color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Divider(
//               height: 0.5,
//               indent: 20,
//               color: Colors.grey,
//             )
//
//             /* ListTile(
//               leading: Icon(Icons.home, color: Colors.grey[700]),
//               title: Text(
//                 "Home",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Montserrat',
//                     color: Colors.black),
//               ),
//             ),
//             Divider(
//               thickness: 1,
//             ),
//             ListTile(
//               leading: Icon(Icons.filter_none, color: Colors.grey[700]),
//               title: Text(
//                 "Tearm & Condition",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Montserrat',
//                     color: Colors.black),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.filter_none, color: Colors.grey[700]),
//               title: Text(
//                 "Logout",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Montserrat',
//                     color: Colors.black),
//               ),
//             ),*/
//           ],
//         ),
//       ),
      bottomNavigationBar: BottomNavigationBarWithFab(
        notchedShape: CircularNotchedRectangle(),
        height: 56,
        selectedColor: appPrimaryMaterialColor,
        unSelectedColor: Colors.grey,
        items: [
          BottomBarItem(icon: CupertinoIcons.profile_circled, title: "Watcher"),
          BottomBarItem(icon: CupertinoIcons.person_2_alt, title: "Visitors"),
          BottomBarItem(
              icon: CupertinoIcons.home,
              title: "Home",
              imageIcon: "images/Watcherlogo.png"),
          BottomBarItem(
              icon: CupertinoIcons.chat_bubble_2_fill, title: "Hello"),
          BottomBarItem(icon: CupertinoIcons.add, title: "More"),
        ],
      ),
      /*StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        itemCount: dashFields.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, int index) {
          return dashBox(
            dashFields[index]["label"],
            dashFields[index]["img"],
          );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      ),*/
    );
  }
//
// Widget dashBox(String label, String img, Widget screenName) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.push(
//           context,
//           PageTransition(
//               child: screenName, type: PageTransitionType.rightToLeft));
//     },
//     child: Padding(
//       padding: const EdgeInsets.only(top: 5.0, bottom: 5, right: 3, left: 3),
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.13,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.white, width: 1.5),
//             borderRadius: BorderRadius.all(Radius.circular(7.0)),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   blurRadius: 2.0,
//                   spreadRadius: 2.0,
//                   offset: Offset(3.0, 5.0))
//             ]),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               img,
//               width: 37,
//               color: appPrimaryMaterialColor,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 5.0),
//               child: FittedBox(
//                 // fit: BoxFit.contain,
//                 child: Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: Text(
//                     label,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: appPrimaryMaterialColor,
//                         fontSize: 12,
//                         fontFamily: 'Montserrat',
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}

class AdminDashbordComponent extends StatefulWidget {
  @override
  _AdminDashbordComponentState createState() => _AdminDashbordComponentState();
}

class _AdminDashbordComponentState extends State<AdminDashbordComponent> {
  List dashFields = [
    {
      "label": "Complaints",
      "img": "images/complain.png",
      "screenName": ComplaintsScreen(),
    },
    {
      "label": "Directory",
      "img": "images/directory1.png",
      "screenName": MemberDirectoryScreen(),
    },
    {
      "label": "Parking",
      "img": "images/car.png",
      "screenName": ParkingScreen(),
    },
    {
      "label": "My Building",
      "img": "images/building.png",
      "screenName": MemberApprovelScreen(),
    },
    {
      "label": "Emergency",
      "img": "images/alarm.png",
      "screenName": EmergencyScreen(),
    },
    {
      "label": "Advertisement",
      "img": "images/ad-campaign.png",
      "screenName": AdvertisementScreen(),
    },
    {
      "label": "Management",
      "img": "images/team.png",
      "screenName": ManagementScreen(),
    },
    {
      "label": "Interaction",
      "img": "images/chat.png",
      "screenName": InteractionScreen(),
    },
    {
      "label": "Help Desk",
      "img": "images/communications.png",
      "screenName": HelpDeskScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            /* Padding(
              padding: const EdgeInsets.only(left: 13.0, right: 13, top: 20),
              child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(3.0, 5.0))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 11.0),
                        child: Text(
                          "28 Days remaning",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 11.0),
                        child: Text(
                          "View Pricing",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ],
                  )),
            ),*/
            // SizedBox(
            //   height: 20,
            // ),
            GestureDetector(
              onTap: () {
                Share.share(
                    '${sharedPrefs.societyCode} Share above code with building members to join ${sharedPrefs.societyName}.');
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13),
                child: Container(
                    height: 95,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 2.0,
                              spreadRadius: 2.0,
                              offset: Offset(3.0, 5.0))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 11.0),
                                child: Text(
                                  // "0160203220",
                                  "${sharedPrefs.societyCode}",
                                  style: TextStyle(
                                      color: appPrimaryMaterialColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 11.0, right: 10),
                                child: Text(
                                  "Share above code with building members to join ${sharedPrefs.societyName},",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(right: 25.0, left: 8),
                            child: Icon(
                              Icons.share,
                              color: appPrimaryMaterialColor,
                              size: 32,
                            )),
                      ],
                    )),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 8, left: 11, right: 11),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 3.0),
              itemBuilder: (BuildContext context, int index) {
                return dashBox(
                  dashFields[index]["label"],
                  dashFields[index]["img"],
                  dashFields[index]["screenName"],
                );
              },
              itemCount: dashFields.length,
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: WatcherScreen(),
                        type: PageTransitionType.rightToLeft));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13),
                child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 2.0,
                              spreadRadius: 2.0,
                              offset: Offset(3.0, 5.0))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/gate.png",
                          width: 38,
                          color: appPrimaryMaterialColor,
                        ),
                        FittedBox(
                          // fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              "Watcher",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: appPrimaryMaterialColor,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashBox(String label, String img, Widget screenName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: screenName, type: PageTransitionType.rightToLeft));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5, right: 3, left: 3),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                    offset: Offset(3.0, 5.0))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img,
                width: 37,
                color: appPrimaryMaterialColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: FittedBox(
                  // fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
