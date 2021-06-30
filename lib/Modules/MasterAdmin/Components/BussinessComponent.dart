import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class BusinessComponent extends StatefulWidget {
  var businessData;
  Function onremove;
  BusinessComponent({this.businessData, this.onremove});

  @override
  _BusinessComponentState createState() => _BusinessComponentState();
}

class _BusinessComponentState extends State<BusinessComponent> {
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
              Text("${widget.businessData["businessCategoryName"]}"),
              GestureDetector(
                onTap: () {
                  _deletevendorCategory(widget.businessData["_id"]);
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

  _deletevendorCategory(var businessId) async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "businessCategoryId": "${businessId}",
        };
        setState(() {
          isDLoading = true;
        });
        Services.responseHandler(
                apiName: "api/admin/deleteBusinessCategory", body: body)
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
