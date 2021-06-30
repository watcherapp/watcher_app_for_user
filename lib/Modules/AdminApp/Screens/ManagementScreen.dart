import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/BottomNavigationBarCustomForAdmin.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/ManagementComponent.dart';

class ManagementScreen extends StatefulWidget {
  @override
  _ManagementScreenState createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  bool isLoading = false;
  List getAllAdminData = [];

  _getAllWingsMember() async {
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
        };
        print("$body");
        getAllAdminData.clear();
        Services.responseHandler(
                apiName: "api/admin/getSocietyAdmin", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              getAllAdminData = responseData.Data;
              print("Wings----------------->$getAllAdminData");
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
    _getAllWingsMember();
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
          "Management Screen",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _getAllWingsMember();
        },
        color: appPrimaryMaterialColor,
        child: Stack(
          children: [
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
                : getAllAdminData.length > 0
                    ? Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: ListView.builder(
                        // shrinkWrap: true,
                        // physics: BouncingScrollPhysics(),
                        // scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) => Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: ManagementComponent(
                            memberData: getAllAdminData[index],
                            memberDataApi: () {
                              _getAllWingsMember();
                            },
                          ),
                        ),
                        // itemCount: 8,
                        itemCount: getAllAdminData.length,
                      ),
                    )
                    : Center(
                        child: Text("No Member Found"),
                      ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),
    );
  }
}
