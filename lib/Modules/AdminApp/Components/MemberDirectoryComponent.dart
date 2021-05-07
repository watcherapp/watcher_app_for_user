import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

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
  @override
  Widget build(BuildContext context) {
    return Card(
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
                              fit: BoxFit.cover,
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
                          fontSize: 14),
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
                    Text(
                      widget.memberData["FlatData"][0]["flatStatus"] == "0"
                          ? "Dead"
                          : widget.memberData["FlatData"][0]["flatStatus"] ==
                                  "1"
                              ? "Closed"
                              : widget.memberData["FlatData"][0]
                                          ["flatStatus"] ==
                                      "2"
                                  ? "Rent"
                                  : "Owner",
                    ),
                  ],
                ),
                // SizedBox(
                //   width: 105,
                // ),
              ],
            ),
            Positioned(
                right: 10.0,
                top: 30.0,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: MemberAllInfo(
                              memberMobileNo: widget.memberData["mobileNo1"],
                              memberId: widget.memberData["_id"],
                              memberApi: () {
                                widget.memberDataApi();
                              },
                            ),
                            type: PageTransitionType.rightToLeft));
                  },
                  icon: Icon(Icons.message),
                  iconSize: 25,
                )),
          ],
        ),
      ),
    );
  }
}

class MemberAllInfo extends StatefulWidget {
  var memberMobileNo;
  var memberId;
  Function memberApi;

  MemberAllInfo({this.memberMobileNo, this.memberId, this.memberApi});

  @override
  _MemberAllInfoState createState() => _MemberAllInfoState();
}

class _MemberAllInfoState extends State<MemberAllInfo> {
  bool isLoading = false;
  List dataList = [];

  @override
  void initState() {
    _getAllMemberData();
  }

  _getAllMemberData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "mobileNo": widget.memberMobileNo,
        };
        Services.responseHandler(
                apiName: "api/member/getMemberInformation", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            dataList = responseData.Data;
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

  _deleteMember() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberId": dataList[0]["_id"],
        };
        print(body);
        Services.responseHandler(apiName: "api/admin/removeMember", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            widget.memberApi();
            Navigator.pop(context);
            // dataList = responseData.Data;
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

  _assignAsAdmin() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberId": dataList[0]["_id"],
          "adminId": sharedPrefs.memberId,
          "assignRole": 1,
          "societyId": sharedPrefs.societyId,
        };
        print(body);
        Services.responseHandler(
                apiName: "api/admin/assignUserRole", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            // widget.memberApi();
            Navigator.pop(context);
            // dataList = responseData.Data;
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
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //
        //     },
        //     child: Icon(Icons.delete_outline_outlined),
        //   )
        // ],
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                // backgroundColor: Colors.red,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
              ),
            )
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      "${dataList[0]["memberImage"]}" != ""
                          // ||
                          //     "${dataList[0]["memberImage"]}" != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Container(
                                height: 150.0,
                                width: MediaQuery.of(context).size.width / 1,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 0.2,
                                      color: appPrimaryMaterialColor),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      API_URL + dataList[0]["memberImage"],
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            )
                          // Image.network(
                          //         API_URL + dataList[0]["memberImage"],
                          //         width: 170,
                          //   height: 100,
                          //       )
                          : Image.asset(
                              "images/perso-outline.png",
                              color: Colors.white,
                              width: 170,
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlineButton(
                            child: new Text(
                              "Delete Member",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () {
                              _deleteMember();
                            },
                            borderSide: BorderSide(color: Colors.red),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                            ),
                          ),
                          OutlineButton(
                            child: new Text(
                              "Assign as Admin",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () {
                              _assignAsAdmin();
                            },
                            borderSide: BorderSide(color: Colors.green),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  color: appPrimaryMaterialColor,
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 19),
                  child: Center(
                    child: Text(
                        "${dataList[0]["firstName"]} ${dataList[0]["lastName"]}",
                        style: (TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontFamily: 'Montserrat',
                          //fontWeight: FontWeight.w600
                        ))),
                  ),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: ListTile(
                    leading: Icon(Icons.call, color: appPrimaryMaterialColor),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${dataList[0]["mobileNo1"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            "Mobile",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Divider(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: ListTile(
                    leading: Icon(Icons.email, color: appPrimaryMaterialColor),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${dataList[0]["emailId"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Divider(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
    );
  }
}
