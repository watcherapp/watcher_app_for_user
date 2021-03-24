import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:polls/polls.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Components/StaffComponent.dart';

class AddPollingQuestion extends StatefulWidget {
  @override
  _AddPollingQuestionState createState() => _AddPollingQuestionState();
}

class _AddPollingQuestionState extends State<AddPollingQuestion> {
  // TextEditingController txt1 = new TextEditingController();
  // TextEditingController txt2 = new TextEditingController();
  // TextEditingController txt3 = new TextEditingController();
  // TextEditingController txt4 = new TextEditingController();
  //
  // List controller;
  //
  // @override
  // void initState() {
  //   controller = [
  //     "${txt1}",
  //     "${txt2}",
  //     "${txt3}",
  //     "${txt4}",
  //   ];
  //
  // }
  //
  // int indeX = 0;

  bool isAdd = false;
  final TextEditingController txtOptions = new TextEditingController();
  TextEditingController txtQuestion = new TextEditingController();
  List optionList = [];
  List pollQuestionResponse = [];
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
          "societyId": societyId,
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
            Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
          } else {
            print(responseData);
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _getAllPollingQuestion() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": societyId,
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
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
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
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _deletePollingQuestionData() async {
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
                apiName: "api/admin/deletePollQuestion", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              isLoading = false;
            });
          } else {
            print(responseData);
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    _getAllPollingQuestion();
    _getPollingQuestionData();


  }

  // _addStaffCategory() async {
  //   try {
  //     final internetResult = await InternetAddress.lookup('google.com');
  //     if (internetResult.isNotEmpty &&
  //         internetResult[0].rawAddress.isNotEmpty) {
  //       var body = {"staffCategoryName": optionList};
  //       log(optionList.toString());
  //       setState(() {
  //         isSLoading = true;
  //       });
  //       Services.responseHandler(
  //           apiName: "api/staff/addStaffCategory", body: body)
  //           .then((responseData) {
  //         if (responseData.Data == 1) {
  //           print(responseData);
  //           setState(() {
  //             isAdd = false;
  //             isSLoading = false;
  //           });
  //           optionList.clear();
  //           _getStaffCategory();
  //           print(responseData.Data);
  //         } else {
  //           print(responseData);
  //           setState(() {
  //             isSLoading = false;
  //           });
  //           Fluttertoast.showToast(msg: "${responseData.Message}");
  //         }
  //       }).catchError((error) {
  //         setState(() {
  //           isSLoading = false;
  //         });
  //         Fluttertoast.showToast(msg: "$error");
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isSLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: "${Messages.message}");
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _nameController = TextEditingController();
  // }
  //
  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       automaticallyImplyLeading: false,
  //       leading: IconButton(
  //           icon: Icon(Icons.arrow_back_ios_rounded),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           }),
  //       title: Text(
  //         "Add Polling Questions",
  //         style: TextStyle(fontFamily: 'Montserrat'),
  //       ),
  //       centerTitle: true,
  //       elevation: 0,
  //       backgroundColor: appPrimaryMaterialColor,
  //     ),
  //     body: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: <Widget>[
  //           Expanded(
  //             child: ListView(
  //               //crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: <Widget>[
  //                 TextFormField(
  //                   decoration: InputDecoration(
  //                     labelText: 'Question',
  //                   ),
  //                 ),
  //                 SizedBox(height: 16.0),
  //                 Center(
  //                   child: Text('Options'),
  //                 ),
  //                 SizedBox(height: 16.0),
  //                 for (int i = 0; i < indeX; i++) ...[
  //                   MyTextFormField(
  //                       controller: txt1,
  //                       lable: "First Name",
  //                       validator: (val) {
  //                         if (val.isEmpty) {
  //                           return "Please Enter First Name";
  //                         }
  //                         return "";
  //                       },
  //                       hintText: "Enter first name"),
  //                 ],
  //                 RaisedButton.icon(
  //                   icon: Icon(Icons.add),
  //                   label: Text('Add Options'),
  //                   onPressed: () {
  //                     setState(() {
  //                       indeX++;
  //                     });
  //                   },
  //                 ),
  //                 RaisedButton.icon(
  //                   icon: Icon(Icons.minimize),
  //                   label: Text('Remove Options'),
  //                   onPressed: () {
  //                     setState(() {
  //                       indeX--;
  //                     });
  //                   },
  //                 ),
  //                 SizedBox(height: 16.0),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
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
                        return "";
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
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please Enter Staff Name";
                              }
                              return "";
                            },
                            hintText: "Type New Option"),
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
                            Text(optionList[index]),
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
                        _addPollingQuestion();
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
                Container(
                  // height: 200,
                  child: SingleChildScrollView(
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
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(pollQuestionList[index]["pollQuestion"]),
                                  for (int i = 0;
                                      i <
                                          pollQuestionList[index]["PollOptions"]
                                              .length;
                                      i++) ...[
                                    Text(pollQuestionList[index]["PollOptions"]
                                        [i]["pollOption"]),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
        //     : isLoading == true
        //     ? Center(
        //   child: CircularProgressIndicator(
        //     valueColor: new AlwaysStoppedAnimation<Color>(
        //         appPrimaryMaterialColor),
        //   ),
        // )
        //     : SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 25.0),
        //     child: Column(
        //       children: [
        //         staffCatList.length > 0
        //             ? ListView.separated(
        //             separatorBuilder: (context, index) => Padding(
        //               padding: const EdgeInsets.only(
        //                   left: 10.0, right: 10, top: 13),
        //               child: Divider(
        //                 color: Colors.grey,
        //                 height: 1,
        //               ),
        //             ),
        //             shrinkWrap: true,
        //             physics: NeverScrollableScrollPhysics(),
        //             padding: EdgeInsets.only(top: 5, bottom: 18),
        //             scrollDirection: Axis.vertical,
        //             itemCount: staffCatList.length,
        //             itemBuilder: (BuildContext context, int index) {
        //               return StaffComponent(
        //                 staffData: staffCatList[index],
        //                 onremove: () {
        //                   _getStaffCategory();
        //                 },
        //               );
        //             })
        //             : Center(
        //           child: Padding(
        //             padding: const EdgeInsets.only(top: 20.0),
        //             child: Text(
        //               "No Data Found...",
        //               style: TextStyle(
        //                   fontFamily: 'Montserrat',
        //                   fontSize: 12,
        //                   //fontWeight: FontWeight.bold,
        //                   color: Colors.grey),
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 70,
        //         ),
        //         Center(
        //           child: Container(
        //             width: 120,
        //             child: TextButton(
        //               style: TextButton.styleFrom(
        //                 backgroundColor: Colors.grey[200],
        //                 shape: const RoundedRectangleBorder(
        //                     borderRadius:
        //                     BorderRadius.all(Radius.circular(1))),
        //               ),
        //               onPressed: () {
        //                 setState(() {
        //                   isAdd = true;
        //                 });
        //               },
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(Icons.add_circle_outline_sharp,
        //                       color: appPrimaryMaterialColor, size: 17),
        //                   Padding(
        //                     padding: const EdgeInsets.only(left: 4.0),
        //                     child: Text(
        //                       "Add More",
        //                       style: TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           fontFamily: 'Montserrat',
        //                           fontSize: 13,
        //                           color: appPrimaryMaterialColor),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        // body: SingleChildScrollView(
        //   child: Form(
        //     key: _formKey,
        //     child: Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           // name textfield
        //           Padding(
        //             padding: const EdgeInsets.only(right: 5.0),
        //             child: TextFormField(
        //               controller: _nameController,
        //               decoration:
        //                   InputDecoration(hintText: 'Enter your Question'),
        //               validator: (v) {
        //                 if (v.trim().isEmpty) return 'Please enter something';
        //                 return null;
        //               },
        //             ),
        //           ),
        //           // MyTextFormField(
        //           //   controller: _nameController,
        //           //   lable: "First Name",
        //           //   validator: (val) {
        //           //     if (val.trim().isEmpty) {
        //           //       return "Please Enter Question";
        //           //     }
        //           //     return "";
        //           //   },
        //           //   hintText: "Enter your Question",
        //           // ),
        //           SizedBox(
        //             height: 20,
        //           ),
        //           Text(
        //             'Add Options :',
        //             style: TextStyle(
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 16,
        //                 color: appPrimaryMaterialColor),
        //           ),
        //           ..._getFriends(),
        //           SizedBox(
        //             height: 40,
        //           ),
        //           // FlatButton(
        //           //   onPressed: () {
        //           //     if (_formKey.currentState.validate()) {
        //           //       _formKey.currentState.save();
        //           //     }
        //           //   },
        //           //   child: Text('Submit'),
        //           //   color: Colors.green,
        //           // ),
        //           MyButton(
        //             onPressed: () {
        //               if (_formKey.currentState.validate()) {
        //                 _formKey.currentState.save();
        //               }
        //             },
        //             title: "Submit",
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }

  /// get firends text-fields
// List<Widget> _getFriends() {
//   List<Widget> friendsTextFields = [];
//   for (int i = 0; i < questionList.length; i++) {
//     friendsTextFields.add(Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Row(
//         children: [
//           Text("${i + 1})"),
//           SizedBox(
//             width: 6,
//           ),
//           Expanded(child: QuestionTextFields(i)),
//           SizedBox(
//             width: 6,
//           ),
//           // we need add button at last friends row
//           _addRemoveButton(i == questionList.length - 1, i),
//         ],
//       ),
//     ));
//   }
//   return friendsTextFields;
// }
//
// /// add / remove button
// Widget _addRemoveButton(bool add, int index) {
//   return InkWell(
//     onTap: () {
//       if (add) {
//         // add new text-fields at the top of all friends textfields
//         questionList.insert(0, null);
//       } else
//         questionList.removeAt(index);
//       setState(() {});
//     },
//     child: Container(
//       width: 30,
//       height: 30,
//       decoration: BoxDecoration(
//         color: (add) ? Colors.green : Colors.red,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Icon(
//         (add) ? Icons.add : Icons.remove,
//         color: Colors.white,
//       ),
//     ),
//   );
// }
}

// class QuestionTextFields extends StatefulWidget {
//   final int index;
//
//   QuestionTextFields(this.index);
//
//   @override
//   _QuestionTextFieldsState createState() => _QuestionTextFieldsState();
// }

// class _QuestionTextFieldsState extends State<QuestionTextFields> {
//   TextEditingController _nameController;
//   List options = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//     print(_nameController.text);
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _nameController.text =
//           _AddPollingQuestionState.questionList[widget.index] ?? '';
//       print(_nameController.text);
//       options.add(_nameController.text);
//       print(options);
//     });
//
//     return TextFormField(
//       controller: _nameController,
//       onChanged: (v) => _AddPollingQuestionState.questionList[widget.index] = v,
//       decoration: InputDecoration(hintText: 'Enter your Option'),
//       validator: (v) {
//         if (v.trim().isEmpty) return 'Please enter Option${widget.index}';
//         return null;
//       },
//     );
//   }
// }
