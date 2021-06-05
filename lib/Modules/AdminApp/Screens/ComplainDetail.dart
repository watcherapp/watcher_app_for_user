import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class ComplainDetail extends StatefulWidget {
  var complaintData;
  Function getComplainApi;

  ComplainDetail({
    this.complaintData,
    this.getComplainApi,
  });

  @override
  _ComplainDetailState createState() => _ComplainDetailState();
}

class _ComplainDetailState extends State<ComplainDetail> {
  bool isLoading = false;

  _upDateStatus(var status) async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "complainNo": widget.complaintData["complainNo"],
          "complainStatus": status,
          "adminId" : sharedPrefs.memberId,
        };
        print("$body");
        print(status);
        Services.responseHandler(
                apiName: "api/admin/resposneToComplain", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Your Complain Status Updated Successfully");
            setState(() {
              isLoading = false;
            });
            widget.getComplainApi();
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
          "Complaints Detail",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    widget.complaintData["subject"],
                    //'${widget.notification["Title"]}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Image.network(
                   API_URL + widget.complaintData["attachment"],
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 25.0, left: 20, right: 10),
                  child: Text(
                    "Complain Date :-",
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20, right: 10),
                  child: Text(
                    widget.complaintData["dateTime"][0],
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 25.0, left: 20, right: 10),
                  child: Text(
                    "Complain By :-",
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20, right: 10),
                  child: Text(
                    "${widget.complaintData["MemberDetails"][0]["firstName"]}  ${widget.complaintData["MemberDetails"][0]["lastName"]}",
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 25.0, left: 20, right: 10),
                  child: Text(
                    "Complain Description :-",
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20, right: 10),
                  child: Text(
                    widget.complaintData["discription"],
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Container(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _upDateStatus("0");
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.amber[400],
                              /*border: Border.all(color: Colors.amber, width: 2)*/
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("REQUESTED",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 7,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _upDateStatus("1");
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.red[400],
                              /* border: Border.all(color: Colors.red[200], width: 2)*/
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("REJECTED",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _upDateStatus("2");
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: appPrimaryMaterialColor[400],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            /*border: Border.all(
                                  color: appPrimaryMaterialColor[100], width: 2)),*/
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("START TAKING ACTIONS",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _upDateStatus("3");
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.circular(4),
                              /* border:
                                  Border.all(color: Colors.green[200], width: 2)*/
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "RESOLVED",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
