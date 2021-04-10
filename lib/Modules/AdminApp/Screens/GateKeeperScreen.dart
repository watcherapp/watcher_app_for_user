import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class GateKeeperScreen extends StatefulWidget {
  @override
  _GateKeeperScreenState createState() => _GateKeeperScreenState();
}

class _GateKeeperScreenState extends State<GateKeeperScreen> {

  bool isLoading = false;
  List gateKeeperList = [];

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
          "societyId": sharedPrefs.societyId,
        };
        print("$body");
        Services.responseHandler(
            apiName: "api/admin/getAllRequestListOfGuard", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            gateKeeperList = responseData.Data;
            print(gateKeeperList);
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
          "Gate Keepers",
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
        itemCount: gateKeeperList.length,
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
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) => ShowDialog());
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
                      gateKeeperList[index]["staffImage"],
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
                          "${gateKeeperList[index]["firstName"]} " +
                              "${gateKeeperList[index]["lastName"]}",
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
                          gateKeeperList[index]["mobileNo1"],
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
                        print(gateKeeperList[index]["mobileNo1"]);
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
                        //           helperData: amenitiesList[index],
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
