import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
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
          "societyId": "60129950e19dc51744dd7cfe",
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
              allEmergencyList = responseData.Data;
            });
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
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

            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
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
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
              // backgroundColor: Colors.red,
              valueColor:
                  new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
            ))
          : ListView.builder(
              padding: EdgeInsets.only(top: 5, bottom: 18),
              scrollDirection: Axis.vertical,
              itemCount: allEmergencyList.length,
              itemBuilder: (BuildContext context, int index) {
                return EmergencyComponent(
                  allEmergencyList: allEmergencyList[index],
                  GetEmergencyApi:(){
                    _getAllEmergency();
                  },
                );
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: FloatingActionButton(
          // isExtended: true,
          child: Icon(
            Icons.add,
            size: 26,
          ),
          backgroundColor: appPrimaryMaterialColor,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: AddEmergencyScreen(),
                    type: PageTransitionType.rightToLeft));
            setState(() {});
          },
        ),
      ),
    );
  }
}
