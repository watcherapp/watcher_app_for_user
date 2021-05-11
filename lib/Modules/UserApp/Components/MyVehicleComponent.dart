import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class MyVehicleComponent extends StatefulWidget {
  var vehicleData;

  MyVehicleComponent({
    this.vehicleData,
  });

  @override
  _MyVehicleComponentState createState() => _MyVehicleComponentState();
}

class _MyVehicleComponentState extends State<MyVehicleComponent> {

  bool isLoading = false;
  List parkingSlotList=[];

  @override
  void initState() {
    _myParkingSlots();
  }

  _myParkingSlots() async {
    print("Calling");
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print("${sharedPrefs.memberNo}");
        print("${sharedPrefs.flatId}");
        var body = {
          "memberNo": "${sharedPrefs.memberNo}",
          "flatId": "${sharedPrefs.flatId}",
        };
        print(body);
        Services.responseHandler(
            apiName: "api/member/getMemberParkingSlots", body: body)
            .then((responseData) {
          print(responseData.Data.length);
          if (responseData.Data.length > 0) {
            setState(() {
              parkingSlotList = responseData.Data;
              isLoading = false;
            });
            print(responseData.Data);
            print("parkingSlotList-------------------->$parkingSlotList");
          } else {
            print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
            color: appPrimaryMaterialColor[50],
            borderRadius: BorderRadius.circular(6.0)),
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.vehicleData["vehicleType"] == "Car"
                ? Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Image.asset(
                      "images/car.png",
                      width: 37,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Image.asset(
                      "images/bike.png",
                      width: 37,
                    ),
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Text("7515",
                      //     overflow: TextOverflow.ellipsis,
                      //     style: TextStyle(
                      //         fontSize: 14,
                      //         fontFamily: "Montserrat",
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.black87)),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: parkingSlotList.length > 0  ? Colors.green : Color(0xFFFF4F4F),
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child:  parkingSlotList.length > 0
                                ? Row(
                              children: [
                                Icon(
                                  Icons.verified_sharp,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                Text(
                                  " Approved",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            )
                                : Row(
                              children: [
                                Container(
                                  height: 12,
                                  width: 12,
                                  child: Image.asset(
                                    "images/pendingApproval.png",
                                  ),
                                ),
                                Text(
                                  " Not Approved",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.green,
                      //       borderRadius: BorderRadius.circular(4.0)),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(4.0),
                      //     child: Row(
                      //       children: [
                      //         Icon(
                      //           Icons.verified_sharp,
                      //           size: 14,
                      //           color: Colors.white,
                      //         ),
                      //         Text(
                      //           " Approved",
                      //           style: TextStyle(
                      //               fontSize: 10,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.white),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 30),
                    child: Text("${widget.vehicleData["vehicleNo"]}",
                        style: TextStyle(
                            fontFamily: "Montserrat-Bold",
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
