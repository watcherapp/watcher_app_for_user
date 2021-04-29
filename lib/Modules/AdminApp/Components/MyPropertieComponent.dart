import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/AdminDashboard.dart';
import 'package:watcher_app_for_user/Modules/UserApp/UserDashboard.dart';

enum OwnerType { Owner, Admin }

class MyPropertiesComponent extends StatefulWidget {
  var myPropertyData;
  Function memberDataApi;

  MyPropertiesComponent({this.myPropertyData,this.memberDataApi});

  @override
  _MyPropertiesComponentState createState() => _MyPropertiesComponentState();
}

class _MyPropertiesComponentState extends State<MyPropertiesComponent> {
  setPreferences() {
    sharedPrefs.societyId =
        "${widget.myPropertyData["MemberData"][0]["society"]["societyId"]}";
    //smit..
    sharedPrefs.societyCode =
        "${widget.myPropertyData["MemberData"][0]["society"]["societyCode"]}";

    sharedPrefs.societyName =
        "${widget.myPropertyData["SocietyData"][0]["societyName"]}";

    //
    sharedPrefs.wingId =
        "${widget.myPropertyData["MemberData"][0]["society"]["wingId"]}";
    sharedPrefs.flatId =
        "${widget.myPropertyData["MemberData"][0]["society"]["flatId"]}";
    sharedPrefs.userRole =
        "${widget.myPropertyData["MemberData"][0]["society"]["userRole"]}";
    if (sharedPrefs.userRole == "1") {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: AdminDashboard(), type: PageTransitionType.bottomToTop));
    } else if (sharedPrefs.userRole == "2") {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: UserDashboard(), type: PageTransitionType.bottomToTop));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.myPropertyData["MemberData"][0]["society"]["isApprove"] == true){
          setPreferences();
        }else{
          Fluttertoast.showToast(
            msg: "You are not authorized to access this Please contact Admin of Society",
            backgroundColor: Colors.white,
            textColor: appPrimaryMaterialColor,
          );
        }

      },
      child: Card(
        elevation: 3,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          side: new BorderSide(color: Colors.grey, width: 0.1),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Stack(
          children: [
            GridTile(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Image.asset(
                        "images/building.png",
                        width: 38,
                        color: appPrimaryMaterialColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 30),
                      child: FittedBox(
                        // fit: BoxFit.contain,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 3.0, right: 3, top: 4),
                          child: Text(
                            "${widget.myPropertyData["SocietyData"][0]["societyName"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: appPrimaryMaterialColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ]),
              footer: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                    color: appPrimaryMaterialColor,
                    onPressed: () {},
                    child: Text(
                      "${widget.myPropertyData["WingData"][0]["wingName"]}" +
                          " - " +
                          "${widget.myPropertyData["flatNo"]}",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
            Positioned(
                right: 0.0,
                top: 0.0,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ShowDialog(
                        memberData: widget.myPropertyData,
                        memberApi: (){
                          widget.memberDataApi();
                        },
                      ),
                    );
                  },
                  iconSize: 20,
                  color: appPrimaryMaterialColor,
                  icon: Icon(Icons.delete_outline_outlined),
                )),
          ],
        ),
      ),
    );
  }
}

class ShowDialog extends StatefulWidget {
  var memberData;
  Function memberApi;

  ShowDialog({
    this.memberData,
    this.memberApi,
  });

  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  bool isLoading = false;

  _leaveSociety() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberId": sharedPrefs.memberId,
          "societyId": sharedPrefs.societyId,
          "wingId": widget.memberData["MemberData"][0]["society"]["wingId"],
          "flatId": widget.memberData["MemberData"][0]["society"]["flatId"],
        };
        print(body);
        Services.responseHandler(apiName: "api/member/leaveSociety", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            setState(() {
              isLoading = false;
            });
            widget.memberApi();
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
              'Leave the Flat  (${widget.memberData["WingData"][0]["wingName"]} - ${widget.memberData["flatNo"]})',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: appPrimaryMaterialColor
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to left this flat.',
              style: TextStyle(
                fontSize: 16,
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
                    child: Text("Leave",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.green[400],
                    onPressed: () {
                      _leaveSociety();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
