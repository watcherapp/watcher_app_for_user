import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/PollingQuestionComponent.dart';

class AddPollingQuestion extends StatefulWidget {
  @override
  _AddPollingQuestionState createState() => _AddPollingQuestionState();
}

class _AddPollingQuestionState extends State<AddPollingQuestion> {
  List pollQuestionResponse = [];
  List pollQuestionList = [];
  bool isLoading = false;
  bool isDLoading = false;

  // _addPollingQuestion() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     final internetResult = await InternetAddress.lookup('google.com');
  //     if (internetResult.isNotEmpty &&
  //         internetResult[0].rawAddress.isNotEmpty) {
  //       var body = {
  //         "societyId": societyId,
  //         "pollQuestion": txtQuestion.text,
  //         "pollOption": optionList,
  //       };
  //       print("$body");
  //       Services.responseHandler(
  //               apiName: "api/admin/addPollingQuestion", body: body)
  //           .then((responseData) {
  //         if (responseData.Data.length > 0) {
  //           pollQuestion = responseData.Data;
  //           print(pollQuestion);
  //           optionList.clear();
  //           Navigator.pop(context);
  //           setState(() {
  //             isLoading = false;
  //           });
  //         } else {
  //           print(responseData);
  //           Fluttertoast.showToast(
  //               msg: "${responseData.Message}",
  //               toastLength: Toast.LENGTH_SHORT,
  //               gravity: ToastGravity.BOTTOM,
  //               timeInSecForIosWeb: 1,
  //               backgroundColor: Colors.red,
  //               // textColor: Colors.white,
  //               fontSize: 16.0);
  //         }
  //       }).catchError((error) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         Fluttertoast.showToast(
  //             msg: "Error $error",
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.red,
  //             // textColor: Colors.white,
  //             fontSize: 16.0);
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(
  //         msg: "You aren't connected to the Internet !",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         // textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }

  _getAllPollingQuestion() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": "${sharedPrefs.societyId}",
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/admin/getAllPollingQuestion", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            pollQuestionList = responseData.Data;
            print(pollQuestionList);
            print(pollQuestionList.length);
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

  _getPollingQuestionData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "pollQuestionId": "605afba4a8532c173014bbb6",
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/admin/getResponseOfPoll", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
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
            _getAllPollingQuestion();
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
    _getAllPollingQuestion();
    _getPollingQuestionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Polling Questions",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_rounded,
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: AddPollingComponent(
                    pollingListApi: () {
                      _getAllPollingQuestion();
                    },
                  ),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
                //backgroundColor: Colors.white54,
              ),
            )
          // : isDLoading
          //     ? Center(
          //         child: CircularProgressIndicator(
          //           valueColor: new AlwaysStoppedAnimation<Color>(
          //               appPrimaryMaterialColor),
          //           //backgroundColor: Colors.white54,
          //         ),
          //       )
          : pollQuestionList.length > 0
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: pollQuestionList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          right: 5,
                          left: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: PollingQuestionComponent(
                            PollingData: pollQuestionList[index],
                            pollinQuestionApi: () {
                              _getAllPollingQuestion();
                            },
                            index: index,
                          ),
                          // child: Card(
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Column(
                          //       crossAxisAlignment:
                          //           CrossAxisAlignment.start,
                          //       children: [
                          //         Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment
                          //                   .spaceBetween,
                          //           children: [
                          //             Expanded(
                          //               child: Text(
                          //                 "${index + 1}) ${pollQuestionList[index]["pollQuestion"]}",
                          //                 style: TextStyle(
                          //                     fontFamily:
                          //                         'Montserrat',
                          //                     fontSize: 15,
                          //                     fontWeight:
                          //                         FontWeight.bold,
                          //                     color:
                          //                         appPrimaryMaterialColor),
                          //               ),
                          //             ),
                          //             IconButton(
                          //               icon: Icon(Icons.delete),
                          //               color:
                          //                   appPrimaryMaterialColor,
                          //               iconSize: 18,
                          //               onPressed: () {
                          //                 _deletePollingQuestionData(
                          //                     pollQuestionList[
                          //                         index]["_id"]);
                          //               },
                          //             )
                          //           ],
                          //         ),
                          //         for (int i = 0;
                          //             i <
                          //                 pollQuestionList[index]
                          //                         ["PollOptions"]
                          //                     .length;
                          //             i++) ...[
                          //           Padding(
                          //             padding:
                          //                 const EdgeInsets.only(
                          //               top: 5,
                          //               bottom: 5,
                          //             ),
                          //             child: FittedBox(
                          //               fit: BoxFit.cover,
                          //               child: Container(
                          //                 width:
                          //                     MediaQuery.of(context)
                          //                         .size
                          //                         .width,
                          //                 height: 40,
                          //                 decoration: BoxDecoration(
                          //                     color:
                          //                         Colors.grey[200],
                          //                     borderRadius:
                          //                         BorderRadius
                          //                             .circular(
                          //                                 5.0)),
                          //                 child: Padding(
                          //                   padding:
                          //                       const EdgeInsets
                          //                           .only(
                          //                     left: 10,
                          //                     top: 10,
                          //                   ),
                          //                   child: Text(
                          //                     pollQuestionList[
                          //                                 index][
                          //                             "PollOptions"]
                          //                         [i]["pollOption"],
                          //                     style: TextStyle(
                          //                       fontFamily:
                          //                           'Montserrat',
                          //                       fontSize: 13,
                          //                       // fontWeight: FontWeight.bold,
                          //                       color:
                          //                           appPrimaryMaterialColor,
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ]
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text("No Polling Question Found"),
                ),
    );
  }
}

class AddPollingComponent extends StatefulWidget {
  Function pollingListApi;

  AddPollingComponent({this.pollingListApi});

  @override
  _AddPollingComponentState createState() => _AddPollingComponentState();
}

class _AddPollingComponentState extends State<AddPollingComponent> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController txtOptions = new TextEditingController();
  TextEditingController txtQuestion = new TextEditingController();
  List optionList = [];
  List pollQuestionList = [];
  bool isLoading = false;
  bool isSLoading = false;
  var pollQuestion;

  _addPollingQuestion() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
          "pollQuestion": txtQuestion.text,
          "pollOption": optionList,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/admin/addPollingQuestion", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            pollQuestion = responseData.Data;
            print(pollQuestion);
            optionList.clear();
            widget.pollingListApi();
            Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Add Polling Questions",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: MyTextFormField(
                      controller: txtQuestion,
                      lable: "Add Question",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Question";
                        }
                        return null;
                      },
                      hintText: "Type New Question"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: MyTextFormField(
                          controller: txtOptions,
                          lable: "Add Options",
                          // validator: (val) {
                          //   if (val.isEmpty) {
                          //     return "Please Enter Options";
                          //   }
                          //   return null;
                          // },
                          hintText: "Type New Option",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7.0, top: 36),
                        child: Container(
                          width: 90,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: appPrimaryMaterialColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                            ),
                            onPressed: () {
                              if (txtOptions.text != "") {
                                setState(() {
                                  optionList.add(txtOptions.text);
                                  txtOptions.text = "";
                                });
                                Fluttertoast.showToast(
                                    msg: "Data Added Successfully");
                              }
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
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 13),
                          child: Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                        ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 5, bottom: 18),
                    scrollDirection: Axis.vertical,
                    itemCount: optionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              child: Container(
                                child: Text(optionList[index]),
                                width: 300,
                              ),
                              fit: BoxFit.cover,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  optionList.removeAt(index);
                                  //optionList.remove(txtguestname.text);
                                });
                                Fluttertoast.showToast(
                                    msg: "Data Deleted Successfully");
                              },
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.black54,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: appPrimaryMaterialColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (optionList.length >= 2) {
                            _addPollingQuestion();
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isSLoading == true
                              ? Center(
                                  child: SizedBox(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                      //backgroundColor: Colors.white54,
                                    ),
                                    height: 26,
                                    width: 34,
                                  ),
                                )
                              : Text(
                                  "Save",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
