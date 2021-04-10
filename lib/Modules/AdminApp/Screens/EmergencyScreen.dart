import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/EmergencyComponent.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AddEmergencyScreen.dart';

class EmergencyScreen extends StatefulWidget {
  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  List allEmergencyList = [];
  bool isLoading = false;

  @override
  void initState() {
    _getAllEmergency();
  }

  //get...
  _getAllEmergency() async {
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
        Services.responseHandler(
                apiName: "api/admin/getAllEmergencyContacts", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print("allEmergencyList-->${responseData.Data}");
            setState(() {
              isLoading = false;
              allEmergencyList = responseData.Data;
            });
          } else {
            print(responseData);
            setState(() {
              isLoading = false;
              allEmergencyList = responseData.Data;
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

  //upDate...
  _updateEmergency() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "emergencyContactId": "601936b52168562de8c753f4",
          "contactName": "Fire",
          "contactNo": "102"
        };
        Services.responseHandler(
                apiName: "api/admin/updateEmergencyContacts", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            allEmergencyList = responseData.Data;
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Emergency",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Stack(
        children: [
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                  // backgroundColor: Colors.red,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      appPrimaryMaterialColor),
                ))
              : allEmergencyList.length > 0
                  ? ListView.builder(
                      padding: EdgeInsets.only(top: 5, bottom: 18),
                      scrollDirection: Axis.vertical,
                      itemCount: allEmergencyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return EmergencyComponent(
                          allEmergencyList: allEmergencyList[index],
                          GetEmergencyApi: () {
                            _getAllEmergency();
                          },
                        );
                      })
                  : Center(
                      child: Text("No Emergency Found"),
                    ),
          Positioned(
            bottom: 30,
            right: 10,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: AddEmergencyScreen(),
                        type: PageTransitionType.rightToLeft));
                setState(() {});
              },
              icon: Icon(Icons.add),
              label: Text("Add Emergency"),
            ),
          ),
        ],
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 12.0),
      //   child: FloatingActionButton(
      //     // isExtended: true,
      //     child: Icon(
      //       Icons.add,
      //       size: 26,
      //     ),
      //     backgroundColor: appPrimaryMaterialColor,
      //     onPressed: () {
      //       Navigator.push(
      //           context,
      //           PageTransition(
      //               child: AddEmergencyScreen(),
      //               type: PageTransitionType.rightToLeft));
      //       setState(() {});
      //     },
      //   ),
      // ),
    );
  }
}
