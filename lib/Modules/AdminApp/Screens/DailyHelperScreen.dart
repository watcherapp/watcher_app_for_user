import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class DailyHelperScreen extends StatefulWidget {
  @override
  _DailyHelperScreenState createState() => _DailyHelperScreenState();
}

class _DailyHelperScreenState extends State<DailyHelperScreen> {
  bool isLoading = false;
  List amenitiesList = [];

  @override
  void initState() {
    _getAllStaff();
  }

  _getAllStaff() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": societyId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/admin/getSocietyStaff", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            amenitiesList = responseData.Data;
            print(amenitiesList);
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
        title: Text(
          "Daily Helper",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor:
          new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
        ),
      )
          : ListView.builder(
        itemCount: amenitiesList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            right: 5,
            left: 5,
          ),
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         child: DailyHelperSubScreen(),
              //         type: PageTransitionType.rightToLeft));
              showDialog(
                  context: context,
                  builder: (BuildContext context) => ShowDialog());
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    // Image.asset('images/user.png', width: 50, height: 50),
                    Image.network(
                      amenitiesList[index]["staffImage"],
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${amenitiesList[index]["firstName"]} " +
                              "${amenitiesList[index]["lastName"]}",
                          style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Text('B1 - 07'),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          amenitiesList[index]["mobileNo1"],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        // Text('Resident'),
                      ],
                    ),
                    SizedBox(
                      width: 105,
                    ),
                    IconButton(
                      onPressed: () {
                        print(amenitiesList[index]["mobileNo1"]);
                      },
                      icon: Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                      iconSize: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         child: DailyHelperSubScreen(
                        //           helperData: amenitiesList[index]["workingLocation"][index],
                        //         ),
                        //         type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "images/rightArrow.png",
                          color: appPrimaryMaterialColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShowDialog extends StatefulWidget {
  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  List dialogList = [
    "A-101",
    "A-102",
    "A-103",
    "A-104",
    "A-105",
    "A-106",
    "A-107",
    "A-108",
    "A-109",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: 500,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: Center(
          child: Text(
            'Sunny More',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: appPrimaryMaterialColor,
            ),
          ),
        ),
        content: Container(
          width: 200,
          height: 200,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                print("${dialogList[index]}");
              },
              child: Card(
                  child: new Center(
                child: new Text(
                  "${dialogList[index]}",
                  style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              )),
            ),
            itemCount: dialogList.length,
          ),
        ),
        // content: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Column(
        //       children: dialogList.map((data) {
        //         return GridView.builder(
        //           shrinkWrap: true,
        //           // physics: NeverScrollableScrollPhysics(),
        //           padding: EdgeInsets.only(top: 8, left: 11, right: 11),
        //           // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           //   crossAxisCount: 4,
        //           //   // childAspectRatio: 1.5,
        //           //   // crossAxisSpacing: 4.0,
        //           //   // mainAxisSpacing: 3.0,
        //           // ),
        //           itemBuilder: (BuildContext context, int index) {
        //             return Text(data[index]);
        //           },
        //           itemCount: 2,
        //         );
        //       }).toList(),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class DailyHelperSubScreen extends StatefulWidget {
  var helperData;

  DailyHelperSubScreen({
    this.helperData,
  });

  @override
  _DailyHelperSubScreenState createState() => _DailyHelperSubScreenState();
}

class _DailyHelperSubScreenState extends State<DailyHelperSubScreen> {
  bool isLoading = false;
  List flatList =[];


  @override
  void initState() {
    _getFlatData();
  }

  _getFlatData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": societyId,
          "wingId" : widget.helperData["flatId"]["wingId"]["_id"],
          "flatId" : widget.helperData["flatId"]["_id"],
        };
        print("$body");
        Services.responseHandler(
            apiName: "api/admin/getMembersOfFlat", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            flatList = responseData.Data;
            print(flatList);
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
        title: Text(
          "Sunny More",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            right: 5,
            left: 5,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "A-10${index}",
                          style: TextStyle(
                            color: appPrimaryMaterialColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Smit vaghani',
                          style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),

                        // Text('B1 - 07'),
                        SizedBox(
                          height: 2,
                        ),
                        Text('8735069293'),
                        SizedBox(
                          height: 2,
                        ),
                        // Text('Resident'),
                      ],
                    ),
                    SizedBox(
                      width: 130,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
