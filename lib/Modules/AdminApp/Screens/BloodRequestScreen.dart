import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class BloodRequestScreen extends StatefulWidget {
  @override
  _BloodRequestScreenState createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  List bloodRequestList = [];
  bool isLoading = false;

  @override
  void initState() {
    _getAllBloodRequest();
  }

  _getAllBloodRequest() async {
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
                apiName: "api/member/getAllBloodRequest", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            bloodRequestList = responseData.Data;
            setState(() {
              isLoading = false;
            });
            // Navigator.pop(context);
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
          "All Blood Request",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
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
                  ),
                )
              : bloodRequestList.length > 0
                  ? ListView.builder(
                      itemCount: bloodRequestList.length,
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
                                      child: Center(
                                        child: Text(
                                          "${bloodRequestList[index]["requestedBloodGroup"]}",
                                          style: TextStyle(
                                            color: appPrimaryMaterialColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${bloodRequestList[index]["Member"][0]["firstName"]} ${bloodRequestList[index]["Member"][0]["lastName"]}",
                                        style: TextStyle(
                                            color: appPrimaryMaterialColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),

                                      // Text('B1 - 07'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        bloodRequestList[index]["Member"][0]
                                            ["mobileNo1"],
                                      ),
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
                    )
                  : Center(
                      child: Text("No Blood Request Found"),
                    ),
          Positioned(
            bottom: 30,
            right: 10,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: BloodRequestSubScreen(
                          getBloodReqData: (){
                            _getAllBloodRequest();
                          },
                        ),
                        type: PageTransitionType.rightToLeft));
                setState(() {});
              },
              icon: Icon(Icons.add),
              label: Text("Add Request"),
            ),
          ),
        ],
      ),
    );
  }
}

class BloodRequestSubScreen extends StatefulWidget {
  Function getBloodReqData;

  BloodRequestSubScreen({
    this.getBloodReqData,
  });

  @override
  _BloodRequestSubScreenState createState() => _BloodRequestSubScreenState();
}

class _BloodRequestSubScreenState extends State<BloodRequestSubScreen> {
  TextEditingController txtHospitalName = new TextEditingController();
  TextEditingController txtHospitalEmail = new TextEditingController();
  TextEditingController txtHospitalMoNo = new TextEditingController();
  TextEditingController txtHospitalAdress = new TextEditingController();

  List bloodGroupList = [
    "A+",
    "B+",
    "AB+",
    "O+",
    "A-",
    "B-",
    "AB-",
    "O-",
  ];
  String bloodGroop;
  int isSelected = -1;
  bool isLoading = false;

  _addBloodRequest() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "requestMemberId": sharedPrefs.memberId,
          "societyId": sharedPrefs.societyId,
          "requestedBloodGroup": bloodGroop,
          "hospitalName": txtHospitalName.text,
          "hospitalEmail": txtHospitalEmail.text,
          "hospitalContactNo": txtHospitalMoNo.text,
          "completeAddress": txtHospitalAdress.text,
          "lat": "21.0214512",
          "long": "72.05415210",
        };
        Services.responseHandler(
                apiName: "api/member/addBloodRequest", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            setState(() {
              isLoading = false;
            });
            widget.getBloodReqData();
            Fluttertoast.showToast(
              msg: "Your Blood Request Add Successfully ",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
            Navigator.pop(context);
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
          title: Text("Blood Request"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Select Blood Group",
                    style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = index;
                          });
                          bloodGroop = bloodGroupList[index];
                          print(bloodGroop);
                          // print("${bloodGroupList[index]}");
                        },
                        child: Card(
                            color: isSelected == index
                                ? appPrimaryMaterialColor
                                : Colors.white,
                            child: new Center(
                              child: new Text(
                                bloodGroupList[index],
                                style: TextStyle(
                                  color: isSelected == index
                                      ? Colors.white
                                      : appPrimaryMaterialColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            )),
                      ),
                      itemCount: 8,
                    ),
                  ),
                  MyTextFormField(
                      controller: txtHospitalName,
                      lable: "Hospital Name",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Hospital Name";
                        }
                        return "";
                      },
                      hintText: "Enter Hospital Name"),
                  SizedBox(
                    height: 3,
                  ),
                  MyTextFormField(
                      controller: txtHospitalEmail,
                      lable: "Hospital Email",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Hospital Email";
                        }
                        return "";
                      },
                      hintText: "Enter Hospital Email"),
                  SizedBox(
                    height: 3,
                  ),
                  MyTextFormField(
                      controller: txtHospitalMoNo,
                      lable: "Hospital Contect No",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Hospital Contect No";
                        }
                        return "";
                      },
                      hintText: "Enter Hospital Contect No"),
                  SizedBox(
                    height: 3,
                  ),
                  MyTextFormField(
                      controller: txtHospitalAdress,
                      lable: "Hospital Address",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Hospital Address";
                        }
                        return "";
                      },
                      hintText: "Enter Hospital Address"),
                  MyButton(
                    onPressed: () {
                      _addBloodRequest();
                    },
                    title: "Make Blood Request",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
