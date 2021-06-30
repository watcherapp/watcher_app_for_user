import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class ComplaintComponent extends StatefulWidget {
  var complaintData;
  Function onremove;
  ComplaintComponent({this.complaintData, this.onremove});

  @override
  _ComplaintComponentState createState() => _ComplaintComponentState();
}

class _ComplaintComponentState extends State<ComplaintComponent> {
  bool isDLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.complaintData["complainName"]}"),
              GestureDetector(
                onTap: () {
                  _deletevendorCategory(widget.complaintData["_id"]);
                },
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.black54,
                  size: 18,
                ),
              )
            ],
          ),
          isDLoading == true
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

  _deletevendorCategory(var complainId) async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "complainCategoryId": "${complainId}",
        };
        setState(() {
          isDLoading = true;
        });
        Services.responseHandler(
                apiName: "api/admin/deleteComplainCategory", body: body)
            .then((responseData) {
          if (responseData.Data != 0) {
            widget.onremove();
            Fluttertoast.showToast(msg: "Category Deleted Successfully", backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity:ToastGravity.TOP,);
            setState(() {
              isDLoading = false;
            });
          } else {
            print(responseData);
            setState(() {
              isDLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isDLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isDLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }
}
