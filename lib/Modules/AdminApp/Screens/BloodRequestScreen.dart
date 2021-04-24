import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class BloodRequestScreen extends StatefulWidget {
  @override
  _BloodRequestScreenState createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  List bloodRequestList = [];
  bool isLoading = false;

  @override
  void initState() {
    _getAllBloodRequest();
  }

  _getAllBloodRequest() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
        };
        Services.responseHandler(
                apiName: "api/member/getAllBloodRequest", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            bloodRequestList = responseData.Data;
            setState(() {
              isLoading = false;
            });
            // Navigator.pop(context);
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
        title: Text(
          "All Blood Request",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Stack(
        children: [
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    // backgroundColor: Colors.red,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        appPrimaryMaterialColor),
                  ),
                )
              : bloodRequestList.length > 0
                  ? ListView.builder(
                      itemCount: bloodRequestList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          right: 5,
                          left: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: BloodRequestComponent(
                            BloodDataApi: () {
                              _getAllBloodRequest();
                            },
                            BloodDataList: bloodRequestList[index],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text("No Blood Request Found"),
                    ),
          Positioned(
            bottom: 30,
            right: 10,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: BloodRequestSubScreen(
                          getBloodReqData: () {
                            _getAllBloodRequest();
                          },
                        ),
                        type: PageTransitionType.rightToLeft));
                setState(() {});
              },
              icon: Icon(Icons.add),
              label: Text("Add Request"),
            ),
          ),
        ],
      ),
    );
  }
}

class BloodRequestComponent extends StatefulWidget {
  Function BloodDataApi;
  var BloodDataList;

  BloodRequestComponent({
    this.BloodDataApi,
    this.BloodDataList,
  });

  @override
  _BloodRequestComponentState createState() => _BloodRequestComponentState();
}

class _BloodRequestComponentState extends State<BloodRequestComponent> {
  bool isLoading = false;

  _deleteBloodRequest() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "bloodRequestId": widget.BloodDataList["_id"],
        };
        Services.responseHandler(
                apiName: "api/member/deleteBloodRequest", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            setState(() {
              isLoading = false;
            });
            widget.BloodDataApi();
            Fluttertoast.showToast(
              msg: "Your BloodRequest Deleted Successfully.",
            );
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "${widget.BloodDataList["requestedBloodGroup"]}",
                    style: TextStyle(
                      color: appPrimaryMaterialColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.BloodDataList["Member"][0]["firstName"]} ${widget.BloodDataList["Member"][0]["lastName"]}",
                    style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  // Text('B1 - 07'),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.BloodDataList["Member"][0]["mobileNo1"],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  // Text('Resident'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.17,
            ),
            IconButton(
              icon: Icon(Icons.info),
              color: appPrimaryMaterialColor,
              iconSize: 22,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => ShowDialog(
                    bloodData: widget.BloodDataList,
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: appPrimaryMaterialColor,
              iconSize: 22,
              onPressed: () {
                _deleteBloodRequest();
              },
            )
          ],
        ),
      ),
    );
  }
}

class ShowDialog extends StatefulWidget {
  var bloodData;

  ShowDialog({
    this.bloodData,
  });

  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  TextEditingController txtDonarName = new TextEditingController();
  TextEditingController txtDonarEmail = new TextEditingController();
  TextEditingController txtDonarMoNo = new TextEditingController();

  bool isLoading = false;

  _responseBloodRequest() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "bloodRequestId": widget.bloodData["_id"],
          "requestStatus": "3",
          "donarName": txtDonarName.text,
          "donarEmail": txtDonarEmail.text,
          "donarContactNo": txtDonarMoNo.text,
        };
        print(body);
        Services.responseHandler(
                apiName: "api/admin/responseToBloodRequest", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            setState(() {
              isLoading = false;
            });
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
              'Respose to Blood Request',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: appPrimaryMaterialColor,
              ),
            ),
            // SizedBox(
            //   width: 5,
            // ),
            // Icon(
            //   Icons.report,
            //   size: 33,
            //   color: Colors.red,
            // ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextFormField(
                controller: txtDonarName,
                lable: "Donar Name",
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter Donar Name";
                  }
                  return "";
                },
                hintText: "Enter Donar Name"),
            SizedBox(
              height: 3,
            ),
            MyTextFormField(
                controller: txtDonarEmail,
                lable: "Donar Email",
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter Donar Email";
                  }
                  return "";
                },
                hintText: "Enter Donar Email"),
            SizedBox(
              height: 3,
            ),
            MyTextFormField(
                controller: txtDonarMoNo,
                lable: "Donar Contect No",
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter Donar Contect No";
                  }
                  return "";
                },
                hintText: "Enter Donar Contect No"),
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
                    child: Text("Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.green[400],
                    onPressed: () {
                      _responseBloodRequest();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BloodRequestSubScreen extends StatefulWidget {
  Function getBloodReqData;

  BloodRequestSubScreen({
    this.getBloodReqData,
  });

  @override
  _BloodRequestSubScreenState createState() => _BloodRequestSubScreenState();
}

class _BloodRequestSubScreenState extends State<BloodRequestSubScreen> {
  TextEditingController txtHospitalName = new TextEditingController();
  TextEditingController txtHospitalEmail = new TextEditingController();
  TextEditingController txtHospitalMoNo = new TextEditingController();
  TextEditingController txtHospitalAdress = new TextEditingController();

  List bloodGroupList = [
    "A+",
    "B+",
    "AB+",
    "O+",
    "A-",
    "B-",
    "AB-",
    "O-",
  ];
  String bloodGroop;
  int isSelected = -1;
  bool isLoading = false;

  _addBloodRequest() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "requestMemberId": sharedPrefs.memberId,
          "societyId": sharedPrefs.societyId,
          "requestedBloodGroup": bloodGroop,
          "hospitalName": txtHospitalName.text,
          "hospitalEmail": txtHospitalEmail.text,
          "hospitalContactNo": txtHospitalMoNo.text,
          "completeAddress": txtHospitalAdress.text,
          "lat": "21.0214512",
          "long": "72.05415210",
        };
        Services.responseHandler(
                apiName: "api/member/addBloodRequest", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            setState(() {
              isLoading = false;
            });
            widget.getBloodReqData();
            Fluttertoast.showToast(
              msg: "Your Blood Request Add Successfully ",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text("Blood Request"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Select Blood Group",
                    style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = index;
                          });
                          bloodGroop = bloodGroupList[index];
                          print(bloodGroop);
                          // print("${bloodGroupList[index]}");
                        },
                        child: Card(
                            color: isSelected == index
                                ? appPrimaryMaterialColor
                                : Colors.white,
                            child: new Center(
                              child: new Text(
                                bloodGroupList[index],
                                style: TextStyle(
                                  color: isSelected == index
                                      ? Colors.white
                                      : appPrimaryMaterialColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            )),
                      ),
                      itemCount: 8,
                    ),
                  ),
                  MyTextFormField(
                      controller: txtHospitalName,
                      lable: "Hospital Name",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Hospital Name";
                        }
                        return "";
                      },
                      hintText: "Enter Hospital Name"),
                  SizedBox(
                    height: 3,
                  ),
                  MyTextFormField(
                      controller: txtHospitalEmail,
                      lable: "Hospital Email",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Hospital Email";
                        }
                        return "";
                      },
                      hintText: "Enter Hospital Email"),
                  SizedBox(
                    height: 3,
                  ),
                  MyTextFormField(
                      controller: txtHospitalMoNo,
                      lable: "Hospital Contect No",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Hospital Contect No";
                        }
                        return "";
                      },
                      hintText: "Enter Hospital Contect No"),
                  SizedBox(
                    height: 3,
                  ),
                  MyTextFormField(
                      controller: txtHospitalAdress,
                      lable: "Hospital Address",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Hospital Address";
                        }
                        return "";
                      },
                      hintText: "Enter Hospital Address"),
                  MyButton(
                    onPressed: () {
                      _addBloodRequest();
                    },
                    title: "Make Blood Request",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
