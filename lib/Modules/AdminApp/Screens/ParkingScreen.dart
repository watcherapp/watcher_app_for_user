import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'dart:math' as math;

class ParkingScreen extends StatefulWidget {
  @override
  _ParkingScreenState createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  List wingList = [
    "A",
    "B",
    "C",
    "D",
    "E",
  ];
  bool isSelected = false;

  TabController _tabController;
  List<Widget> tabs;

  @override
  void initState() {
    tabs = [
      for (int i = 0; i < wingList.length; i++) ...[
        Tab(
          child: Container(
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: appPrimaryMaterialColor, width: 1)),
            child: Align(
              alignment: Alignment.center,
              child: Text("${wingList[i]}"),
            ),
          ),
        )
      ]
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          // appBar: AppBar(
          //   title: Text(
          //     "Parking Slots",
          //     style: TextStyle(fontFamily: 'Montserrat'),
          //   ),
          //   centerTitle: true,
          //   elevation: 0,
          //   backgroundColor: appPrimaryMaterialColor,
          // ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text(
              "Parking Slots",
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: appPrimaryMaterialColor,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                "Select Wing",
                style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Container(
                  height: 35,
                  child: TabBar(
                      controller: _tabController,
                      labelPadding: EdgeInsets.only(left: 9.0, right: 9.0),
                      // indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.grey[600],
                      labelColor: Colors.white,
                      isScrollable: true,
                      indicatorColor: appPrimaryMaterialColor,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: appPrimaryMaterialColor),
                      onTap: (index) {},
                      tabs: tabs),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      TabBarView(physics: BouncingScrollPhysics(), children: [
                    for (int i = 0; i < wingList.length; i++) ...[
                      Container(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              print("${wingList[i]}-10${index}");
                            },
                            child: Card(
                              // color: isSelected == false
                              //     ? Colors.white
                              //     : appPrimaryMaterialColor,
                              child: new Center(
                                child: Transform.rotate(
                                  angle: -math.pi / 4,
                                  child: Text(
                                    "${wingList[i]}-10${index}",
                                    style: TextStyle(
                                      color: appPrimaryMaterialColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // itemCount: 8,
                          itemCount: wingList.length,
                        ),
                      ),
                    ],
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: MyButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        context: context,
                        builder: (builder) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: BottomSheet(
                              wingList: wingList,
                            ),
                          );
                        });
                    print("hii");
                  },
                  title: "Assign",
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }
}

class BottomSheet extends StatefulWidget {
  List wingList;

  BottomSheet({this.wingList});

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  bool isSelectedWing = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      color: Colors.transparent,
      child: Container(
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     FlatButton(
            //       color:
            //           isSelectedWing ? appPrimaryMaterialColor : Colors.white,
            //       child: Text(
            //         "Wing Select",
            //         style: TextStyle(
            //             color: isSelectedWing
            //                 ? Colors.white
            //                 : appPrimaryMaterialColor),
            //       ),
            //       onPressed: () {
            //         setState(() {
            //           isSelectedWing = true;
            //           print("t");
            //         });
            //       },
            //     ),
            //     FlatButton(
            //       color:
            //           isSelectedWing ? Colors.white : appPrimaryMaterialColor,
            //       child: Text(
            //         "Flat Select",
            //         style: TextStyle(
            //             color: isSelectedWing
            //                 ? appPrimaryMaterialColor
            //                 : Colors.white),
            //       ),
            //       onPressed: () {
            //         setState(() {
            //           isSelectedWing = false;
            //           print("f");
            //         });
            //       },
            //     ),
            //     // TextButton(
            //     //   style: TextButton.styleFrom(
            //     //     backgroundColor: isSelectedWing ? appPrimaryMaterialColor : Colors.white,
            //     //   ),
            //     //   // color: isSelectedWing ? appPrimaryMaterialColor : Colors.white,
            //     //   child: Text(
            //     //     "Wing Select",
            //     //     style: TextStyle(
            //     //         color: isSelectedWing ? Colors.white : appPrimaryMaterialColor),
            //     //   ),
            //     //   onPressed: () {
            //     //     setState(() {
            //     //       isSelectedWing = true;
            //     //     });
            //     //   },
            //     // ),
            //     // TextButton(
            //     //   style: TextButton.styleFrom(
            //     //     backgroundColor: isSelectedWing ? Colors.white : appPrimaryMaterialColor,
            //     //   ),
            //     //   // color: isSelectedWing ? Colors.white : appPrimaryMaterialColor,
            //     //   child: Text(
            //     //     "Flat Select",
            //     //     style: TextStyle(
            //     //         color: isSelectedWing ? appPrimaryMaterialColor : Colors.white),
            //     //   ),
            //     //   onPressed: () {
            //     //     setState(() {
            //     //       isSelectedWing = false;
            //     //     });
            //     //   },
            //     // ),
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            // isSelectedWing
            //     ? Expanded(
            //         child: GridView.builder(
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 5),
            //           itemBuilder: (_, index) => GestureDetector(
            //             onTap: () {},
            //             child: Card(
            //                 child: Center(
            //               child: Text(
            //                 "${widget.wingList[index]}",
            //                 style: TextStyle(
            //                   color: appPrimaryMaterialColor,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 13,
            //                 ),
            //               ),
            //             )),
            //           ),
            //           itemCount: widget.wingList.length,
            //         ),
            //       )
            //     :
            Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          print("A-${index+1}");
                        },
                        child: Card(
                            child: new Center(
                          child: new Text(
                            "A-${index+1}",
                            style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        )),
                      ),
                      itemCount: widget.wingList.length,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 24.0, right: 10, left: 10, bottom: 5),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: RaisedButton(
                  child: Text("Asign",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: appPrimaryMaterialColor,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
