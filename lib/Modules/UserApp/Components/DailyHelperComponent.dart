import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/StaffGetPass.dart';

class DailyHelperComponent extends StatefulWidget {
  var myStaffData;
  Function staffApi;

  DailyHelperComponent({
    this.myStaffData,
    this.staffApi,
  });

  @override
  _DailyHelperComponentState createState() => _DailyHelperComponentState();
}

class _DailyHelperComponentState extends State<DailyHelperComponent> {
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              child: ClipOval(
                child: widget.myStaffData["staffImage"] == null ||
                        widget.myStaffData["staffImage"] == ""
                    ? Image.asset(
                        'images/maleavtar.png',
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
                                API_URL + widget.myStaffData["staffImage"],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Text(
                  // "smit vaghani",
                  "${widget.myStaffData["firstName"]} ${widget.myStaffData["lastName"]}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            Text(
              "${widget.myStaffData["StaffCategoryIs"][0]["staffCategoryName"] ?? "Staff"}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.green,
                    size: 22,
                  ),
                  onPressed: () {
                    launchUrl("tel:${widget.myStaffData["mobileNo1"]}");
                  },
                ),
                Container(
                  width: 1,
                  height: 18,
                  color: Colors.grey[200],
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline_outlined,
                    color: appPrimaryMaterialColor,
                    size: 22,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ShowDialog(
                        staffData: widget.myStaffData,
                        staffApi: () {
                          widget.staffApi();
                        },
                      ),
                    );
                  },
                ),
                Container(
                  width: 1,
                  height: 18,
                  color: Colors.grey[200],
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color: appPrimaryMaterialColor,
                    size: 22,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StaffGetPass(
                            myStaffData: widget.myStaffData,
                          );
                        });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShowDialog extends StatefulWidget {
  var staffData;
  Function staffApi;

  ShowDialog({
    this.staffData,
    this.staffApi,
  });

  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  bool isLoading = false;

  _removeStaff() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "staffId": "${widget.staffData["_id"]}",
          "flatId": "${sharedPrefs.flatId}",
          "wingId": "${sharedPrefs.wingId}"
        };
        print(body);
        Services.responseHandler(
                apiName: "api/member/deleteMemberStaff", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            setState(() {
              isLoading = false;
            });
            widget.staffApi();
            Navigator.pop(context);
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
              'Delete Staff',
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
              'Are you sure you want to Delete this Staff.',
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
                      print("Cancel");
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
                      _removeStaff();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
