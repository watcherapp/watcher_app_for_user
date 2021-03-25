import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class PollingQuestionComponent extends StatefulWidget {
  var PollingData;
  Function pollinQuestionApi;
  int index;

  PollingQuestionComponent({
    this.PollingData,
    this.index,
    this.pollinQuestionApi,
  });

  @override
  _PollingQuestionComponentState createState() =>
      _PollingQuestionComponentState();
}

class _PollingQuestionComponentState extends State<PollingQuestionComponent> {
  bool isLoading = false;
  bool isDLoading = false;
  var pollQuestionResponse;

  _getPollingQuestionData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "pollQuestionId": widget.PollingData["_id"],
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/admin/getResponseOfPoll", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            // print(responseData.Data);
            pollQuestionResponse = responseData.Data;
            print("----------->${pollQuestionResponse}");
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

  _deletePollingQuestionData(var pId) async {
    try {
      setState(() {
        isDLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "pollQuestionId": pId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/admin/deletePollQuestion", body: body)
            .then((responseData) {
          if (responseData.Data != 0) {
            // _getAllPollingQuestion();
            widget.pollinQuestionApi();
            Fluttertoast.showToast(
              msg: "Your Polling deleted Successfully.",
            );
            setState(() {
              isDLoading = false;
            });
          } else {
            print(responseData);
            setState(() {
              isDLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
          }
        }).catchError((error) {
          setState(() {
            isDLoading = false;
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
        isDLoading = false;
      });
      Fluttertoast.showToast(
        msg: "You aren't connected to the Internet !",
        backgroundColor: Colors.white,
        textColor: appPrimaryMaterialColor,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPollingQuestionData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      appPrimaryMaterialColor),
                  //backgroundColor: Colors.white54,
                ),
              )
            : Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 6, top: 5, left: 6, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.index + 1}) ${widget.PollingData["pollQuestion"]}",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: appPrimaryMaterialColor),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: appPrimaryMaterialColor,
                            iconSize: 18,
                            onPressed: () {
                              _deletePollingQuestionData(
                                  widget.PollingData["_id"]);
                            },
                          )
                        ],
                      ),
                      for (int i = 0;
                          i < widget.PollingData["PollOptions"].length;
                          i++) ...[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.PollingData["PollOptions"][i]
                                          ["pollOption"],
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        // fontWeight: FontWeight.bold,
                                        color: appPrimaryMaterialColor,
                                      ),
                                    ),
                                    Text(
                                      "${pollQuestionResponse[i]["ResponsePercent"]} %",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        // fontWeight: FontWeight.bold,
                                        color: appPrimaryMaterialColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
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
    );
  }
}
