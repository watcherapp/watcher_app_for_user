import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class StaffComponent extends StatefulWidget {
  var staffData;
  Function onremove;
  StaffComponent({this.staffData, this.onremove});

  @override
  _StaffComponentState createState() => _StaffComponentState();
}

class _StaffComponentState extends State<StaffComponent> {
  bool isremoveLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.staffData["staffCategoryName"]}"),
              GestureDetector(
                onTap: () {
                  _deletevendorCategory(widget.staffData["_id"]);
                },
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.black54,
                  size: 18,
                ),
              )
            ],
          ),
          isremoveLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        appPrimaryMaterialColor),
                    //backgroundColor: Colors.white54,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  _deletevendorCategory(var staffId) async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "staffCategoryId": "${staffId}",
        };
        setState(() {
          isremoveLoading = true;
        });
        Services.responseHandler(
                apiName: "api/staff/deleteStaffCategory", body: body)
            .then((responseData) {
          if (responseData.Data != 0) {
            widget.onremove();
            Fluttertoast.showToast(msg: "Category Deleted Successfully");
            setState(() {
              isremoveLoading = false;
            });
          } else {
            print(responseData);
            setState(() {
              isremoveLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isremoveLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isremoveLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }
}
