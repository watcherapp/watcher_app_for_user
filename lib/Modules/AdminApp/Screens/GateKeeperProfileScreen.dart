import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class GateKeeperProfileScreen extends StatefulWidget {
  var gatekeeperData;

  GateKeeperProfileScreen({this.gatekeeperData});

  @override
  _GateKeeperProfileScreenState createState() =>
      _GateKeeperProfileScreenState();
}

class _GateKeeperProfileScreenState extends State<GateKeeperProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130.0), // here the desired height
            child: AppBar(
              title: Text('GateKeeper Profile'),
            ),
          ),
          body: Column(
            children: [],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.115,
              ),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Row(
                  children: [
                    widget.gatekeeperData["watchmanImage"] == null ||
                            widget.gatekeeperData["watchmanImage"] == ""
                        ? Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: appPrimaryMaterialColor),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "${widget.gatekeeperData["firstName"].toString().substring(0, 1).toUpperCase()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      API_URL +
                                          widget
                                              .gatekeeperData["watchmanImage"],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: appPrimaryMaterialColor),
                            ),
                          ),
                    // Padding(
                    //   padding: const EdgeInsets.all(13.0),
                    //   child: CircleAvatar(
                    //     backgroundImage: AssetImage('images/user.png'),
                    //     backgroundColor: appPrimaryMaterialColor,
                    //     radius: 50,
                    //   ),
                    // ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.gatekeeperData["firstName"]}"
                                    .toUpperCase() +
                                " "
                                        "${widget.gatekeeperData["lastName"]}"
                                    .toUpperCase(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            widget.gatekeeperData["mobileNo1"],
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     IconButton(
                          //       icon: Icon(
                          //         Icons.call,
                          //       ),
                          //       onPressed: () {},
                          //     ),
                          //     IconButton(
                          //       icon: Icon(
                          //         Icons.share,
                          //       ),
                          //       onPressed: () {},
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlineButton(
                    child: new Text(
                      "Delete Watchman ",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {},
                    borderSide: BorderSide(color: Colors.red),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                  ),
                  OutlineButton(
                    child: new Text(
                      "Approve Watchman",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      widget.gatekeeperData["isApprove"] != true
                          ? showDialog(
                              context: context,
                              builder: (BuildContext context) => ShowDialog(
                                watchmanData: widget.gatekeeperData,
                              ),
                            )
                          : Fluttertoast.showToast(
                              msg:
                                  "You have already Approved this Watchman Successfully",
                              backgroundColor: Colors.white,
                              textColor: appPrimaryMaterialColor,
                            );
                      // _watchmanApprove()
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
        ),
      ],
    );
  }
}

class ShowDialog extends StatefulWidget {
  var watchmanData;

  ShowDialog({
    this.watchmanData,
  });

  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  bool isLoading = false;

  _watchmanApprove() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "isApprove": true,
          "guardId": widget.watchmanData["_id"],
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/staff/guardVerify", body: body)
            .then((responseData) {
          print(responseData.Data);
          if (responseData.Data == 1) {
            setState(() {
              isLoading = false;
            });
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: "You Approve this Watchman Successfully",
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity:ToastGravity.TOP,
            );
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
            Expanded(
              child: Text(
                // 'Approve the Flat  (${widget.memberData["WingData"][0]["wingName"]} - ${widget.memberData["flatNo"]})',
                'Approve the Watchman ${widget.watchmanData["firstName"]} ${widget.watchmanData["lastName"]}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: appPrimaryMaterialColor),
              ),
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
                      _watchmanApprove();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
