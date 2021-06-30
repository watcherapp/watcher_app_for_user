import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/FlatStatusColorsWithLabel.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/Component/FlatSelactionComponent2.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/MyProperties.dart';

class SelectWingAndFlat extends StatefulWidget {
  String SocietyCode;

  SelectWingAndFlat({
    this.SocietyCode,
  });

  @override
  _SelectWingAndFlatState createState() => _SelectWingAndFlatState();
}

class _SelectWingAndFlatState extends State<SelectWingAndFlat> {
  ScrollController controller = new ScrollController();
  bool isLoading = false;
  String wingId;
  String flatId;
  String flatStatus = "Owner";
  int selectedW = -1;
  int selectedF = -1;
  int selectedS = 3;
  List getAllWingList = [];
  List getAllFlatList = [];
  List dataList = [
    {"label": "Dead", "Color": Colors.grey},
    {"label": "Vacant", "Color": Colors.redAccent},
    {"label": "Rent", "Color": Colors.lightGreen},
    {"label": "Owner", "Color": appPrimaryMaterialColor},
  ];

  @override
  void initState() {
    _getAllWings();
    // _getAllFlats();
  }

  _getAllWings() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          // "societyCode": "SOC-990854",
          "societyCode": widget.SocietyCode,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/getAllWingsOfSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              getAllWingList = responseData.Data;
              print("Wings----------------->$getAllWingList");
              isLoading = false;
            });
            _getAllFlats(wingId: getAllWingList[0]["_id"]);
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

  _getAllFlats({String wingId}) async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": getAllWingList[0]["societyId"],
          "wingId": wingId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/getFlatsOfSocietyWing", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            getAllFlatList = responseData.Data;
            print("Flats----------------->$getAllFlatList");
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

  //not Complete............................
  _joinSociety() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyCode": widget.SocietyCode,
          "wingId": wingId,
          "memberId": sharedPrefs.memberId,
          "flatId": flatId,
          "flatStatus": flatStatus,
        };
        print("$body");
        Services.responseHandler(apiName: "api/society/joinSociety", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            // getAllFlatList = responseData.Data;
            // print("Flats----------------->$getAllFlatList");
            setState(() {
              isLoading = false;
            });
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: MyProperties(),
                    type: PageTransitionType.rightToLeft),
                (Route<dynamic> route) => false);
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
        title: Text(
          "Select Wing And Flat",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Select Your Wing",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Container(
            height: 90,
            // width: 100,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 5, bottom: 18),
                scrollDirection: Axis.horizontal,
                itemCount: getAllWingList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedW = index;
                          wingId = getAllWingList[index]["_id"];
                        });
                        _getAllFlats(wingId: getAllWingList[index]["_id"]);
                        print("${getAllWingList[index]["wingName"]}");
                      },
                      child: Container(
                        width: 70,
                        child: Card(
                          color: selectedW == index
                              ? appPrimaryMaterialColor
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 10, right: 10, bottom: 8),
                            child: Align(
                              alignment: Alignment.center,
                              child:
                                  Text("${getAllWingList[index]["wingName"]}",
                                      style: TextStyle(
                                        color: selectedW == index
                                            ? Colors.white
                                            : appPrimaryMaterialColor,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                      )),
                            ),
                          ),
                        ),
                        // decoration: BoxDecoration(
                        //   color: selectedF == index
                        //       ? appPrimaryMaterialColor
                        //       : Colors.white,
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Select Your Flat",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Container(
            height: 50,
            // height: MediaQuery.of(context).size.height * 0.07,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              // gridDelegate:
              //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedS = index;
                    flatStatus = index.toString();
                    print(flatStatus);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Container(
                    width: 90,
                    child: Card(
                      color: selectedS == index
                          ? appPrimaryMaterialColor
                          : Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: dataList[index]["Color"],
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                    color: Colors.white,
                                    //                   <--- border color
                                    width: 1.0,
                                  ),
                                ),
                                height: 15,
                                width: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  "${dataList[index]["label"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: selectedS == index
                                        ? Colors.white
                                        : appPrimaryMaterialColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: 4,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // FlatStatusColorsWithLabel(),
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
              : Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Scrollbar(
                    thickness: 3,
                    isAlwaysShown: true,
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedF = index;
                              flatId = getAllFlatList[index]["_id"];
                              print("${getAllFlatList[index]["_id"]}");
                            });
                          },
                          child: Container(
                            width: 70,
                            child: Card(
                              color: selectedF == index
                                  ? appPrimaryMaterialColor
                                  : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 10, right: 10, bottom: 8),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("${getAllFlatList[index]["flatNo"]}",
                                      style: TextStyle(
                                        color: selectedF == index
                                            ? Colors.white
                                            : appPrimaryMaterialColor,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                      )),
                                ),
                              ),
                            ),
                            // decoration: BoxDecoration(
                            //   color: selectedF == index
                            //       ? appPrimaryMaterialColor
                            //       : Colors.white,
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                          ),
                          // child: FlatSelactionComponent2(
                          //   floorData: getAllFlatList[index],
                          //   onChange: () {
                          //
                          //   },
                          // ),
                        ),
                        // itemCount: 8,
                        itemCount: getAllFlatList.length,
                      ),
                    ),
                  ),
                ),
              ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: MyButton(
          //     onPressed: () {
          //       _joinSociety();
          //     },
          //     title: "Select",
          //   ),
          // )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
        child: MyButton(
            onPressed: () {
              if (wingId == null) {
                Fluttertoast.showToast(
                  gravity: ToastGravity.TOP,
                  textColor: Colors.white,
                  backgroundColor: Color(0xFFFF4F4F),
                  msg: "Please Select Wing of Society.",
                );
              } else if (flatId == null) {
                Fluttertoast.showToast(
                  gravity: ToastGravity.TOP,
                  textColor: Colors.white,
                  backgroundColor: Color(0xFFFF4F4F),
                  msg: "Please Select Flat of Society.",
                );
              } else if (flatStatus == null) {
                Fluttertoast.showToast(
                  gravity: ToastGravity.TOP,
                  textColor: Colors.white,
                  backgroundColor: Color(0xFFFF4F4F),
                  msg: "Please Select Residence type.",
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => ShowDialog(
                    joinApi: () {
                      _joinSociety();
                    },
                  ),
                );
              }
            },
            title: "Join"),
      ),
    );
  }
}

class ShowDialog extends StatefulWidget {
  Function joinApi;

  ShowDialog({
    this.joinApi,
  });

  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Join the Society',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appPrimaryMaterialColor),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to Join this flat.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                // color: appPrimaryMaterialColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                    child: Text("No",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.red[400].withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
                      print("No");
                    }),
                RaisedButton(
                    child: Text("Yes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.green[400],
                    onPressed: () {
                      widget.joinApi();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
