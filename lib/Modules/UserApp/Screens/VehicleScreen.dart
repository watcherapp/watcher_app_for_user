import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/ClassList/Vehicle.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class VehicleScreen extends StatefulWidget {
  Function myVehicleApi;

  VehicleScreen({
    this.myVehicleApi,
  });

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;
  List parkingSlotList = [];
  List<Vehicle> vehicleList = [
    Vehicle(icon: "images/car.png", name: "Car", isSelected: false),
    Vehicle(icon: "images/bike.png", name: "Bike", isSelected: false),
  ];
  String selectedVehicle = "";
  TextEditingController txtvehicleNo = new TextEditingController();

  @override
  void initState() {
    // _myParkingSlots();
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
            // Fluttertoast.showToast(msg: "${responseData.Message}");
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

  _addVehicleOnParkingSlots() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberId": "${sharedPrefs.memberId}",
          "vehicleType": selectedVehicle,
          "vehicleNo": txtvehicleNo.text,
        };
        print(body);
        Services.responseHandler(apiName: "api/member/addVehicles", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            setState(() {
              isLoading = false;
            });
            print(responseData.Data);
            Fluttertoast.showToast(
              msg: "Your Vehicle Added Successfully.",
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity:ToastGravity.TOP,
            );
            widget.myVehicleApi();
            Navigator.pop(context);
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("Add Vehicle"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            // Container(
            //   height: 300,
            //   child: GridView.builder(
            //       shrinkWrap: true,
            //       itemCount: parkingSlotList.length,
            //       padding:
            //           EdgeInsets.only(top: 25, left: 11, right: 11, bottom: 10),
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 5,
            //           childAspectRatio: 1,
            //           crossAxisSpacing: 0.5,
            //           mainAxisSpacing: 0.5),
            //       itemBuilder: (BuildContext context, int index) {
            //         return Padding(
            //           padding: const EdgeInsets.only(top: 7, right: 3, left: 3),
            //           child: Container(
            //             color: Colors.grey[200],
            //             child: Padding(
            //               padding: const EdgeInsets.all(5.0),
            //               child: DottedBorder(
            //                   color: Colors.grey,
            //                   dashPattern: [4],
            //                   //padding: EdgeInsets.all(6.0),
            //                   child: Container(
            //                       decoration: BoxDecoration(
            //                         // borderRadius: BorderRadius.circular(30),
            //                         shape: BoxShape.rectangle,
            //
            //                         /* border: Border.all(
            //                                     width: 0.2,
            //                                     color: appPrimaryMaterialColor),*/
            //                       ),
            //                       child: Center(
            //                         child: MyVerticleText(
            //                           text: "${parkingSlotList[index]["parkingNo"]}",
            //                         ),
            //                       ))),
            //             ),
            //           ),
            //         );
            //       }),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: vehicleList.map((value) {
                int index = vehicleList.indexOf(value);
                return Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: SizedBox(
                    width: 100,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: vehicleList[index].isSelected
                                ? appPrimaryMaterialColor
                                : Colors.grey,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            vehicleList
                                .forEach((gender) => gender.isSelected = false);
                            vehicleList[index].isSelected = true;
                            selectedVehicle = vehicleList[index].name;
                          });
                          print(selectedVehicle);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            children: [
                              Image.asset(
                                vehicleList[index].icon,
                                color: vehicleList[index].isSelected
                                    ? appPrimaryMaterialColor
                                    : Colors.grey,
                                width: 20,
                                height: 25,
                              ),
                              Text(vehicleList[index].name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: vehicleList[index].isSelected
                                          ? appPrimaryMaterialColor
                                          : Colors.grey)),
                            ],
                          ),
                        )),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "VehicleNo name can't be empty";
                  } else {
                    return null;
                  }
                },
                controller: txtvehicleNo,
                lable: "Vehicle No",
                hintText: "Enter Vehicle No",
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
        child: MyButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _addVehicleOnParkingSlots();
              }
            },
            title: "Save"),
      ),
    );
  }
}

class MyVerticleText extends StatelessWidget {
  final String text;

  MyVerticleText({this.text});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 30,
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      children: text
          .split("")
          .map((string) => Text(string, style: TextStyle(fontSize: 9)))
          .toList(),
    );
  }
}
//transform: Matrix4.skewX(0.1)..rotateX(3.14 / 8.0),
