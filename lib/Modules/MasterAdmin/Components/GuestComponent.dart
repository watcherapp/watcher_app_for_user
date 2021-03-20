import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class GuestComponent extends StatefulWidget {
  var guestData;
  Function onremove;
  GuestComponent({this.guestData, this.onremove});

  @override
  _GuestComponentState createState() => _GuestComponentState();
}

class _GuestComponentState extends State<GuestComponent> {
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
              Text("${widget.guestData["guestType"]}"),
              GestureDetector(
                onTap: () {
                  _deleteGuestCategory(widget.guestData["_id"]);
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

  _deleteGuestCategory(var guestId) async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "guestCategoryId": "${guestId}",
        };
        setState(() {
          isremoveLoading = true;
        });
        Services.responseHandler(
                apiName: "api/guest/deleteGuestCategory", body: body)
            .then((responseData) {
          if (responseData.Data != 0) {
            widget.onremove();
            Fluttertoast.showToast(msg: "Category Deleted Successfully");
            setState(() {
              isremoveLoading = true;
            });
          } else {
            print(responseData);
            setState(() {
              isremoveLoading = true;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isremoveLoading = true;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isremoveLoading = true;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }
}
