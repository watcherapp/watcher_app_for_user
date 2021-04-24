import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

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
                if(widget.BloodDataList["Member"][0]["memberNo"] == sharedPrefs.memberNo){
                  _deleteBloodRequest();
                }else{
                  Fluttertoast.showToast(
                    msg: "You aren't Authorized to Delete this Blood Request !",
                    backgroundColor: Colors.white,
                    textColor: appPrimaryMaterialColor,
                  );
                }
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
