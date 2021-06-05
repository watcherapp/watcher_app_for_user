import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class PropertyManagersDetail extends StatefulWidget {
  var propertyManagerDetailData;
  PropertyManagersDetail({this.propertyManagerDetailData});

  @override
  _PropertyManagersDetailState createState() => _PropertyManagersDetailState();
}

class _PropertyManagersDetailState extends State<PropertyManagersDetail> {
  bool isApprovalLoading = false;
  bool isRejectLoading = false;

  @override
  void initState() {
    print("${widget.propertyManagerDetailData["_id"]}");
    //     "----------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" +
    //     "${widget.propertyManagerDetailData["PropertManager"][0]["_id"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Property Manager Detail",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: widget.propertyManagerDetailData["PropertManager"].length > 0
          ? Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.apartment,
                      color: Colors.black54,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9.0),
                      child: Text(
                        '${widget.propertyManagerDetailData["Society"][0]["societyName"] ?? ""}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 23,
                            //fontWeight: FontWeight.bold,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      '${widget.propertyManagerDetailData["Society"][0]["societyCode"] ?? ""}',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          //fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  height: 2,
                  color: Colors.grey[300],
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.black54,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.propertyManagerDetailData["PropertManager"][0]["firstName"] ?? ""}' +
                              "  "
                                  '${widget.propertyManagerDetailData["PropertManager"][0]["lastName"] ?? ""}',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500),
                          textScaleFactor: 1,
                        ),
                        Text(
                          'Property Manager',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Divider(
                    height: 2,
                    color: Colors.grey[300],
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Icon(
                      Icons.call,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.propertyManagerDetailData["PropertManager"][0]["mobileNo1"] ?? ""}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500),
                        textScaleFactor: 1,
                      ),
                      Text(
                        'Mobile No',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Divider(
                    height: 2,
                    color: Colors.grey[300],
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Icon(
                      Icons.mail,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.propertyManagerDetailData["PropertManager"][0]["emailId"] ?? ""}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500),
                        textScaleFactor: 1,
                      ),
                      Text(
                        'E-Mail',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Divider(
                    height: 2,
                    color: Colors.grey[300],
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.propertyManagerDetailData["Society"][0]["address"]["completeAddress"] ?? ""}",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        textScaleFactor: 1,
                      ),
                      Text(
                        'Address',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Divider(
                    height: 2,
                    color: Colors.grey[300],
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Icon(
                        Icons.location_city,
                        size: 20,
                        color: Colors.black54,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.propertyManagerDetailData["Society"][0]["country"] ?? ""}',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500),
                                textScaleFactor: 1,
                              ),
                              Text(
                                'Country',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.propertyManagerDetailData["Society"][0]["state"] ?? ""}',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500),
                              textScaleFactor: 1,
                            ),
                            Text(
                              'State',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 17.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.propertyManagerDetailData["Society"][0]["city"] ?? ""}',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500),
                                textScaleFactor: 1,
                              ),
                              Text(
                                'City',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Divider(
                    height: 2,
                    color: Colors.grey[300],
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                SizedBox(height: 35),
                widget.propertyManagerDetailData["isApprove"] == true
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 38,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: appPrimaryMaterialColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  onPressed: () {
                                    _getApprovalStatus(true);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 19,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          "ACCEPT",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                height: 38,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: appPrimaryMaterialColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  onPressed: () {
                                    _getApprovalStatus(false);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 19,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          "REJECT",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            )
          : Container(
              child: Center(
                child: Text(
                  "No Data Found...",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ),
    );
  }

  _getApprovalStatus(bool status) async {
    try {
      LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberId":
              "${widget.propertyManagerDetailData["PropertManager"][0]["_id"]}",
          "isApprove": status,
          "requestId": "${widget.propertyManagerDetailData["_id"]}"
        };
        print(
            "====================================================>" + "status");
        print(body);
        Services.responseHandler(
                apiName: "api/admin/approvalOfPropertyManager", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            LoadingIndicator.close(context);
            Fluttertoast.showToast(msg: "Request accept successfully");
            Navigator.of(context).pop();
            print(responseData.Data);
          } else {
            print(responseData);
            LoadingIndicator.close(context);
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          LoadingIndicator.close(context);
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      LoadingIndicator.close(context);
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }
}
