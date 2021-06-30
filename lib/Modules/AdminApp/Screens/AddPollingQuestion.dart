import 'dart:developer';
import 'dart:io';

// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/BottomNavigationBarCustomForAdmin.dart';
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
  //              backgroundColor: Color(0xFFFF4F4F),
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
  //            backgroundColor: Color(0xFFFF4F4F),
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
  //        backgroundColor: Color(0xFFFF4F4F),
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
              backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity: ToastGravity.TOP,
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

  Future<void> refreshData() async {
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
                Icons.info,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: PollingPie(
                      PollingData: pollQuestionList,
                    ),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
            // IconButton(
            //   icon: Icon(
            //     Icons.info,
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       PageTransition(
            //         child: PollingPie(
            //           PollingData: pollQuestionList,
            //         ),
            //         type: PageTransitionType.rightToLeft,
            //       ),
            //     );
            //   },
            // ),
          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: appPrimaryMaterialColor,
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return refreshData();
            // return _getPollingQuestionData();
          },
          color: appPrimaryMaterialColor,
          child: Stack(
            children: [
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            appPrimaryMaterialColor),
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
                  : pollQuestionList.length == 0
                      ? Center(
                          child: Text("No Polling Question Found"),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
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
              Positioned(
                bottom: 30,
                right: 20,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: AddPollingComponent(
                          pollingListApi: () {
                            _getAllPollingQuestion();
                          },
                        ),
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add polling"),
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),
    );
  }
}

class PollingPie extends StatefulWidget {
  var PollingData;

  // Function pollinQuestionApi;
  // int index;

  PollingPie({
    this.PollingData,
    // this.index,
    // this.pollinQuestionApi,
  });

  @override
  _PollingPieState createState() => _PollingPieState();
}

class _PollingPieState extends State<PollingPie> {
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
            "Polling Questions",
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: appPrimaryMaterialColor,
        ),
        body: widget.PollingData.length == 0
            ? Center(
                child: Text("No Polling Question Found"),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount: widget.PollingData.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                      right: 5,
                      left: 5,
                    ),
                    child: pieChart(
                      pollingData: widget.PollingData[index],
                      index: index,
                    ),
                  ),
                ),
              ),
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),
    );
  }
}

//...........................................................................................................................

// class PieChartSample2 extends StatefulWidget {
//   var pollingData;
//
//   // Function pollinQuestionApi;
//   int index;
//
//   PieChartSample2({
//     this.pollingData,
//     this.index,
//     // this.pollinQuestionApi,
//   });
//
//   @override
//   _PieChartSample2State createState() => _PieChartSample2State();
// }
//
// class _PieChartSample2State extends State<PieChartSample2> {
//   int touchedIndex = -1;
//
//   List<Color> colorList = [
//     Color(0xff0293ee),
//     Color(0xfff8b250),
//     Color(0xff845bef),
//     Color(0xff13d38e),
//   ];
//
//   // _checkanswer1() {
//   //   for (int i = 0; i < widget.pollingData["PollOptions"].length; i++) {
//   //     option.add(widget.pollingData["PollOptions"][i]["pollOption"]);
//   //     persentage.add(double.parse(widget.pollingData["PollOptions"][i]["ResponsePercent"].toString()));
//   //     print(option);
//   //     print(persentage);
//   //     dataMap[option[i]] = persentage[i];
//   //     // Map<String, double> dataMapp = Map.fromIterables(option[i], persentage[i]);
//   //     // dataMap.addEntries(option[i] , persentage[i]);
//   //     // dataMap.addAll(option[i] , persentage[i]);
//   //   }
//   //   print("---------------------------------->${dataMap}");
//   //
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  widget.pollingData["isResponse"] == true ? Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 "${widget.index + 1}) ${widget.pollingData["pollQuestion"]}",
//                 style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: appPrimaryMaterialColor),
//               ),
//               SizedBox(height: 30,),
//               Container(
//                 height: 220,
//                 // width: 100,
//                 child: PieChart(
//                   PieChartData(
//                       pieTouchData:
//                       PieTouchData(touchCallback: (pieTouchResponse) {
//                         setState(() {
//                           final desiredTouch = pieTouchResponse.touchInput
//                           is! PointerExitEvent &&
//                               pieTouchResponse.touchInput is! PointerUpEvent;
//                           if (desiredTouch &&
//                               pieTouchResponse.touchedSection != null) {
//                             touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
//                           } else {
//                             touchedIndex = -1;
//                           }
//                         });
//                       }),
//                       borderData: FlBorderData(
//                         show: false,
//                       ),
//                       sectionsSpace: 0,
//                       centerSpaceRadius: 40,
//                       sections: showingSections()),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Column(
//                   // mainAxisSize: MainAxisSize.max,
//                   // mainAxisAlignment: MainAxisAlignment.end,
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (int i = 0; i <
//                         widget.pollingData["PollOptions"].length; i++) ...[
//                       Indicator(
//                         color: colorList[i],
//                         text: '${widget
//                             .pollingData["PollOptions"][i]["pollOption"]}',
//                         isSquare: true,
//                       ),
//                       SizedBox(
//                         height: 4,
//                       ),
//                     ],
//                     // Indicator(
//                     //   color: Color(0xff0293ee),
//                     //   text: 'First',
//                     //   isSquare: true,
//                     // ),
//                     // SizedBox(
//                     //   height: 4,
//                     // ),
//                     // Indicator(
//                     //   color: Color(0xfff8b250),
//                     //   text: 'Second',
//                     //   isSquare: true,
//                     // ),
//                     // SizedBox(
//                     //   height: 4,
//                     // ),
//                     // Indicator(
//                     //   color: Color(0xff845bef),
//                     //   text: 'Third',
//                     //   isSquare: true,
//                     // ),
//                     // SizedBox(
//                     //   height: 4,
//                     // ),
//                     // Indicator(
//                     //   color: Color(0xff13d38e),
//                     //   text: 'Fourth',
//                     //   isSquare: true,
//                     // ),
//                     // SizedBox(
//                     //   height: 18,
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ) : Container();
//   }
//
//   List<PieChartSectionData> showingSections() {
//     return List.generate(widget.pollingData["PollOptions"].length, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 25.0 : 16.0;
//       final radius = isTouched ? 60.0 : 50.0;
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: const Color(0xff0293ee),
//             value: double.parse(
//                 widget.pollingData["PollOptions"][i]["ResponsePercent"]
//                     .toString()),
//             title: '${widget
//                 .pollingData["PollOptions"][i]["ResponsePercent"]}%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: const Color(0xfff8b250),
//             value: double.parse(
//                 widget.pollingData["PollOptions"][i]["ResponsePercent"]
//                     .toString()),
//             title: '${widget
//                 .pollingData["PollOptions"][i]["ResponsePercent"]}%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: const Color(0xff845bef),
//             value: double.parse(
//                 widget.pollingData["PollOptions"][i]["ResponsePercent"]
//                     .toString()),
//             title: '${widget
//                 .pollingData["PollOptions"][i]["ResponsePercent"]}%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 3:
//           return PieChartSectionData(
//             color: const Color(0xff13d38e),
//             value: double.parse(
//                 widget.pollingData["PollOptions"][i]["ResponsePercent"]
//                     .toString()),
//             title: '${widget
//                 .pollingData["PollOptions"][i]["ResponsePercent"]}%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         default:
//           throw Error();
//       }
//     });
//   }
// }
//
//
// class Indicator extends StatelessWidget {
//   final Color color;
//   final String text;
//   final bool isSquare;
//   final double size;
//   final Color textColor;
//
//   const Indicator({
//     // Key? key,
//     this.color,
//     this.text,
//     this.isSquare,
//     this.size = 16,
//     this.textColor = const Color(0xff505050),
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         Container(
//           width: size,
//           height: size,
//           decoration: BoxDecoration(
//             shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
//             color: color,
//           ),
//         ),
//         const SizedBox(
//           width: 5,
//         ),
//         Text(
//           text,
//           style: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
//         )
//       ],
//     );
//   }
// }

//.....................................................................................................................................

class pieChart extends StatefulWidget {
  var pollingData;

  // Function pollinQuestionApi;
  int index;

  pieChart({
    this.pollingData,
    this.index,
    // this.pollinQuestionApi,
  });

  @override
  _pieChartState createState() => _pieChartState();
}

class _pieChartState extends State<pieChart> {
  List option = [];
  List<double> persentage = [];

  //
  Map<String, double> dataMap = {
    // "Flutter": 50,
    // "React": 30,
    // "Xamarin": 20,
    // "Ionic": 20,
  };
  List<Color> colorList2 = [
    Color(0xff0293ee),
    Color(0xfff8b250),
    Color(0xff845bef),
    Color(0xff13d38e),
    Color(0xff13d38e),
  ];

  List<Color> colorList = [
    Color.fromRGBO(0, 63, 92, 1),
    Color.fromRGBO(55, 76, 128, 1),
    Color.fromRGBO(122, 81, 149, 1),
    Color.fromRGBO(188, 80, 144, 1),
    Color.fromRGBO(239, 86, 117, 1),
    Color.fromRGBO(255, 188, 74, 1),
    Color.fromRGBO(255, 124, 67, 1),
    Color.fromRGBO(255, 166, 0, 1),
  ];

  _checkanswer1() {
    for (int i = 0; i < widget.pollingData["PollOptions"].length; i++) {
      option.add(widget.pollingData["PollOptions"][i]["pollOption"]);
      persentage.add(double.parse(
          widget.pollingData["PollOptions"][i]["ResponsePercent"].toString()));
      print(option);
      print(persentage);
      dataMap[option[i]] = persentage[i];
      // Map<String, double> dataMapp = Map.fromIterables(option[i], persentage[i]);
      // dataMap.addEntries(option[i] , persentage[i]);
      // dataMap.addAll(option[i] , persentage[i]);
    }
    print("---------------------------------->${dataMap}");
  }

  @override
  void initState() {
    _checkanswer1();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: option.length < 3 ? 400 : 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "${widget.index + 1}) ${widget.pollingData["pollQuestion"]}",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: appPrimaryMaterialColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                // color: Colors.grey[100],
                decoration: new BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  border: new Border.all(color: Colors.grey[300], width: 0.5),
                ),
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                            "${widget.pollingData["TotalMemberPollResponseCount"]}"),
                        // SizedBox(width: 100,),
                        Text("  ${widget.pollingData["TotalSocietyMember"]}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Response Count"),
                        Text("Total Member"),
                      ],
                    )
                  ],
                ),
              ),
              // SizedBox(height: 30,),

              Expanded(
                // child: PieChart(
                //         dataMap: dataMap,
                //         animationDuration: Duration(milliseconds: 1500),
                //         chartLegendSpacing: 70,
                //         chartRadius: MediaQuery.of(context).size.width / 3.2,
                //         colorList: colorList,
                //         initialAngleInDegree: 0,
                //         chartType: ChartType.disc,
                //         ringStrokeWidth: 50,
                //         // centerText: "HYBRID",
                //         legendOptions: LegendOptions(
                //           showLegendsInRow: false,
                //           legendPosition: LegendPosition.bottom,
                //           showLegends: true,
                //           legendShape: BoxShape.circle,
                //           legendTextStyle: TextStyle(
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         chartValuesOptions: ChartValuesOptions(
                //           showChartValueBackground: true,
                //           showChartValues: true,
                //           showChartValuesInPercentage: true,
                //           showChartValuesOutside: false,
                //           decimalPlaces: 1,
                //         ),
                //       ),
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32.0,
                  chartRadius: MediaQuery.of(context).size.width / 0.5,
                  showChartValuesInPercentage: true,
                  showChartValues: true,
                  showChartValuesOutside: false,
                  chartValueBackgroundColor: Colors.grey[200],
                  colorList: colorList,
                  showLegends: true,
                  legendPosition: LegendPosition.right,
                  decimalPlaces: 1,
                  showChartValueLabel: true,
                  initialAngle: 0,
                  chartValueStyle: defaultChartValueStyle.copyWith(
                    color: Colors.blueGrey[900].withOpacity(0.9),
                  ),
                  chartType: ChartType.disc,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//.....................................................................................................................................

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
                                // Fluttertoast.showToast(
                                //   msg: "Data Added Successfully",
                                //   backgroundColor: Colors.green,
                                //   // backgroundColor: Color(0xFFFF4F4F),
                                //   textColor: Colors.white,
                                //   gravity: ToastGravity.TOP,
                                // );
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
                                  msg: "Data Deleted Successfully",
                                  backgroundColor: Colors.green,
                                  // backgroundColor: Color(0xFFFF4F4F),
                                  textColor: Colors.white,
                                  gravity: ToastGravity.TOP,
                                );
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
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),
    );
  }
}
