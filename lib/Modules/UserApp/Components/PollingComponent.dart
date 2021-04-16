import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class PollingComponent extends StatefulWidget {
  var pollingData;
  Function getPollingApi;
  int index;

  PollingComponent({
    this.pollingData,
    this.getPollingApi,
    this.index,
  });

  @override
  _PollingComponentState createState() => _PollingComponentState();
}

class _PollingComponentState extends State<PollingComponent> {
  int _selectedIndex;
  String AnswerId;
  var Answer;
  bool _submited = false;
  bool isLoading = false;
  int answerIndex;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  _checkanswer() {
    for (int i = 0; i < widget.pollingData["PollOptions"].length; i++) {
      if (widget.pollingData["PollOptions"][i]["IsSelected"] == true) {
        setState(() {
          _submited = true;
          answerIndex = i;
        });
        break;
      }
    }
  }


  _givePollingAnswer() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "pollQuestionId" : widget.pollingData["_id"],
          "pollOptionId" : AnswerId,
          "memberId" : sharedPrefs.memberId,
        };
        print("$body");
        Services.responseHandler(
            apiName: "api/member/answerOfPollQuestion", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              // pollingDataList = responseData.Data;
              isLoading = false;
            });
            // print("$pollingDataList");
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
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 9),
              child: Text(
                  "${widget.index}) " +
                      "${widget.pollingData["pollQuestion"]}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(81, 92, 111, 1))),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 4.0, bottom: 6.0, top: 4),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                  widget.pollingData["PollOptions"].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: _selectedIndex != null &&
                                _selectedIndex == index
                                ? Colors.grey[100]
                                : Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(6.0))),
                        child: FlatButton(
                            onPressed: () {
                              setState(() {
                                _onSelected(index);
                                AnswerId = widget
                                    .pollingData["PollOptions"]
                                [index]["_id"]
                                    .toString();
                                Answer = widget.pollingData["PollOptions"][index]["pollOption"].toString();

                                print(AnswerId);
                                print(Answer);

                                print(widget
                                    .pollingData["PollOptions"]
                                [index]);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                _selectedIndex != null &&
                                    _selectedIndex == index
                                    ? Image.asset(
                                  'images/success.png',
                                  width: 20,
                                )
                                    : Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(100)),
                                      border: Border.all(
                                          width: 2,
                                          color: Colors.grey)),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "${widget.pollingData["PollOptions"][index]["pollOption"]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _selectedIndex != null
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                  decoration: BoxDecoration(
                        color: appPrimaryMaterialColor,
                        borderRadius:
                        BorderRadius.all(Radius.circular(6.0))),
                        child: SizedBox(
                  width: 100,
                  height: 40,
                  child: FlatButton(
                          onPressed: () {
                            _givePollingAnswer();
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          )),
                ),
                      ),
                    )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
    /*Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        //height: 210,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18),
              child: Text(
                "Shoud we go on a quest for the mini golf location ? ",
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                height: 0.3,
                color: Colors.grey,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 2),
                    borderRadius:
                    BorderRadius.all(Radius.circular(3))),
              ),
              onPressed: () {
              },
              child: Text(
                'Add',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                height: 0.4,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18, bottom: 12),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: appPrimaryMaterialColor[100],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        "mukeshbhai",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                    height: 33,
                    width: 100,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: appPrimaryMaterialColor[100],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                        "Keval Mangroliya",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: appPrimaryMaterialColor),
                        ),
                      ),
                      height: 33,
                      width: 86,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
