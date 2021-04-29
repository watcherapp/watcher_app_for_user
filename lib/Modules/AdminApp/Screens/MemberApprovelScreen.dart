import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/MemberDirectoryComponent.dart';

class MemberApprovelScreen extends StatefulWidget {
  @override
  _MemberApprovelScreenState createState() => _MemberApprovelScreenState();
}

class _MemberApprovelScreenState extends State<MemberApprovelScreen> {
  List getAllWingList = [];
  List getAllWingMemberData = [];
  List dataList = [];
  bool isLoading = false;
  int selectedW = -1;
  String wingId;
  String flatId;

  @override
  void initState() {
    _getAllWings();
  }

  _getAllWings() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(sharedPrefs.societyCode);
        var body = {
          "societyCode": sharedPrefs.societyCode,
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
            _getAllWingsMember(wingId: getAllWingList[0]["_id"]);
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

  _getAllWingsMember({String wingId}) async {
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
          "wingId": wingId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/member/getWingMembers", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              getAllWingMemberData = responseData.Data;
              // print("Wings----------------->$dataList");
              // for(int i=0;i< dataList.length; i++){
              //   if(dataList[i]["society"]["isApprove"] == false){
              //     getAllWingMemberData.add(dataList);
              //   }
              // }
              // print("finalList---------------${getAllWingMemberData}");
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Select Building",
              style: TextStyle(
                  color: appPrimaryMaterialColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
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
                            _getAllWingsMember(
                                wingId: getAllWingList[index]["_id"]);
                            wingId = getAllWingList[index]["_id"];
                          });
                          // _getAllFlats(wingId: getAllWingList[index]["_id"]);
                          print("${getAllWingList[index]["wingName"]}");
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Card(
                            color: selectedW == index
                                ? appPrimaryMaterialColor
                                : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 10, right: 10, bottom: 8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      child: Image(
                                        color: selectedW == index
                                            ? Colors.white
                                            : appPrimaryMaterialColor,
                                        image: AssetImage(
                                          "images/building.png",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("${getAllWingList[index]["wingName"]}",
                                        style: TextStyle(
                                          color: selectedW == index
                                              ? Colors.white
                                              : appPrimaryMaterialColor,
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
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
                : getAllWingMemberData.length == 0
                    ? Center(
                        child: Text("No Member Request Found",
                            style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            )),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: ListView.builder(
                          itemBuilder: (_, index) => MemberDirectoryComponent(
                            memberData: getAllWingMemberData[index],
                            memberDataApi: () {
                              _getAllWingsMember();
                            },
                          ),
                          // itemCount: 8,
                          itemCount: getAllWingMemberData.length,
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

class MemberDirectoryComponent extends StatefulWidget {
  var memberData;
  Function memberDataApi;

  MemberDirectoryComponent({
    this.memberData,
    this.memberDataApi,
  });

  @override
  _MemberDirectoryComponentState createState() =>
      _MemberDirectoryComponentState();
}

class _MemberDirectoryComponentState extends State<MemberDirectoryComponent> {
  bool isLoading = false;

  _memberApprove({String approve}) async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(sharedPrefs.societyCode);
        var body = {
          "memberId": widget.memberData["_id"],
          "isApprove": approve,
          "societyId": sharedPrefs.societyId,
          "wingId" : widget.memberData["society"]["wingId"],
          "flatId" : widget.memberData["society"]["flatId"],
          "propertyManagerId": sharedPrefs.memberId,
        };
        print("$body");
        Services.responseHandler(apiName: "api/admin/approveMember", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            setState(() {
              isLoading = false;
            });
            widget.memberDataApi();
            Fluttertoast.showToast(
              msg: "You Approve this member Successfully",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
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
    print(widget.memberData["society"]["isApprove"]);
    if (widget.memberData["society"]["isApprove"] == false) {
      return Container(
        height: 120,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    widget.memberData["memberImage"] == null ||
                            widget.memberData["memberImage"] == ""
                        ? Image.asset(
                            'images/user.png',
                            width: 70,
                            height: 70,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Container(
                              height: 70.0,
                              width: 70,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0.2, color: appPrimaryMaterialColor),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    API_URL + widget.memberData["memberImage"],
                                  ),
                                  fit: BoxFit.fill,
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
                          "${widget.memberData["firstName"]} ${widget.memberData["lastName"]}",
                          style: TextStyle(
                            color: appPrimaryMaterialColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("${widget.memberData["FlatData"][0]["flatNo"]}"),
                        SizedBox(
                          height: 2,
                        ),
                        Text('${widget.memberData["mobileNo1"]}'),
                        SizedBox(
                          height: 2,
                        ),
                        Text('Resident'),
                      ],
                    ),
                    // SizedBox(
                    //   width: 105,
                    // ),
                  ],
                ),
                Positioned(
                  right: 10.0,
                  top: 20.0,
                  child: Container(
                    height: 30,
                    width: 110,
                    child: RaisedButton(
                        child: Text("Approve",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            )),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        color: appPrimaryMaterialColor,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => ShowDialog(
                              memberData: widget.memberData,
                              memberApproveApi: () {
                                _memberApprove(
                                  approve: "true",
                                );
                              },
                            ),
                          );
                        }),
                  ),
                ),
                Positioned(
                  right: 10.0,
                  top: 60.0,
                  child: Container(
                    height: 30,
                    width: 110,
                    child: RaisedButton(
                        child: Text("DisApprove",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.4,
                            )),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        color: appPrimaryMaterialColor,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => ShowDialog2(
                              memberData: widget.memberData,
                              memberApproveApi: () {
                                _memberApprove(
                                  approve: "false",
                                );
                              },
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class ShowDialog extends StatefulWidget {
  var memberData;
  Function memberApproveApi;

  ShowDialog({
    this.memberData,
    this.memberApproveApi,
  });

  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  bool isLoading = false;

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
              // 'Approve the Flat  (${widget.memberData["WingData"][0]["wingName"]} - ${widget.memberData["flatNo"]})',
              'Approve the Flat ${widget.memberData["FlatData"][0]["flatNo"]}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appPrimaryMaterialColor),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to Approve this flat.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                // color: appPrimaryMaterialColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                    child: Text("Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.red[400].withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
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
                      widget.memberApproveApi();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShowDialog2 extends StatefulWidget {
  var memberData;
  Function memberApproveApi;

  ShowDialog2({
    this.memberData,
    this.memberApproveApi,
  });

  @override
  _ShowDialog2State createState() => _ShowDialog2State();
}

class _ShowDialog2State extends State<ShowDialog2> {
  bool isLoading = false;

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
              // 'Approve the Flat  (${widget.memberData["WingData"][0]["wingName"]} - ${widget.memberData["flatNo"]})',
              'DisApprove the Flat ${widget.memberData["FlatData"][0]["flatNo"]}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appPrimaryMaterialColor),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to DisApprove this flat.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                // color: appPrimaryMaterialColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                    child: Text("Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.red[400].withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
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
                      widget.memberApproveApi();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
