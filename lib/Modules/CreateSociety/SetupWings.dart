import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/MyProperties.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/ParticularWingSetup.dart';

class SetupWings extends StatefulWidget {
  int wingsCount;
  var societyId;

  // var isSetUp;

  SetupWings({
    this.wingsCount,
    this.societyId,
    // this.isSetUp,
  });

  @override
  _SetupWingsState createState() => _SetupWingsState();
}

class _SetupWingsState extends State<SetupWings> {
  List wingList = [];

  createWings() {
    print("----------->${widget.wingsCount}");
    int alphabet = "A".codeUnits.first;
    List temp = [];
    // wingList.clear();
    for (int i = 0; i < widget.wingsCount; i++) {
      temp.add(String.fromCharCode(alphabet++));
    }
    print(temp.toString());
    setState(() {
      wingList = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    createWings();
    _getAllWings();
  }

  bool isLoading = false;
  List getAllWingList = [];
  int count;

  calculateCount() {
    count = 0;
    for (int i = 0; i < getAllWingList.length; i++) {
      if (getAllWingList[i]["isSetup"] == true) {
        count++;
      }
    }
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
          "societyId": widget.societyId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/getAllWingsOfSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              getAllWingList = responseData.Data;
              print("Wings----------------->$getAllWingList");
              calculateCount();
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
    print(count);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Setup Wings"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: getAllWingList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    print(getAllWingList[index]["_id"]);
                    Navigator.push(
                        context,
                        PageTransition(
                            child: ParticularWingSetup(
                                wingName: getAllWingList[index]["wingName"],
                                societyId: widget.societyId,
                                wingCount: widget.wingsCount,
                                wingId: getAllWingList[index]["_id"]),
                            type: PageTransitionType.rightToLeft));
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Text("${getAllWingList[index]["wingName"]}",
                            style:
                                TextStyle(fontSize: 22, color: Colors.black)),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: getAllWingList[index]["isSetup"] == false
                            ? Icon(
                                Icons.info_outline,
                                color: Colors.redAccent,
                                size: 18,
                              )
                            : Icon(
                                Icons.check_circle_rounded,
                                size: 18,
                                color: Colors.green,
                              ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: count == getAllWingList.length
          ? Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
              child: MyButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: MyProperties(),
                            type: PageTransitionType.rightToLeft));
                  },
                  title: "Finish"),
            )
          : null,
    );
  }
}
