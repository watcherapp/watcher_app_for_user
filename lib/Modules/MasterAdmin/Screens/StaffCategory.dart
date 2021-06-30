import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Components/StaffComponent.dart';

class StaffCategory extends StatefulWidget {
  @override
  _StaffCategoryState createState() => _StaffCategoryState();
}

class _StaffCategoryState extends State<StaffCategory> {
  bool isAdd = false;
  final TextEditingController txtstaffname = new TextEditingController();
  List tempList = [];
  bool isLoading = false;
  bool isDLoading = false;
  List staffCatList = [];
  bool isSLoading = false;

  @override
  void initState() {
    print("${isAdd}");
    _getStaffCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Staff Category",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: isAdd == true
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: MyTextFormField(
                                controller: txtstaffname,
                                lable: "Staff Name",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter Staff Name";
                                  }
                                  return "";
                                },
                                hintText: "Type Staff Name"),
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
                                  if (txtstaffname.text != "") {
                                    setState(() {
                                      tempList.add(txtstaffname.text);
                                      txtstaffname.text = "";
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Data Added Successfully", backgroundColor: Colors.green,
                                      // backgroundColor: Color(0xFFFF4F4F),
                                      textColor: Colors.white,
                                      gravity:ToastGravity.TOP,);
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
                        itemCount: tempList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(tempList[index]),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tempList.removeAt(index);
                                      //tempList.remove(txtguestname.text);
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Data Deleted Successfully", backgroundColor: Colors.green,
                                      // backgroundColor: Color(0xFFFF4F4F),
                                      textColor: Colors.white,
                                      gravity:ToastGravity.TOP,);
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                          ),
                          onPressed: () {
                            _addStaffCategory();
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
                    )
                  ],
                ),
              ),
            )
          : isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        appPrimaryMaterialColor),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      children: [
                        staffCatList.length > 0
                            ? ListView.separated(
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
                                itemCount: staffCatList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return StaffComponent(
                                    staffData: staffCatList[index],
                                    onremove: () {
                                      _getStaffCategory();
                                    },
                                  );
                                })
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    "No Data Found...",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 70,
                        ),
                        Center(
                          child: Container(
                            width: 120,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1))),
                              ),
                              onPressed: () {
                                setState(() {
                                  isAdd = true;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_circle_outline_sharp,
                                      color: appPrimaryMaterialColor, size: 17),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      "Add More",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          fontSize: 13,
                                          color: appPrimaryMaterialColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
    );
  }

  _getStaffCategory() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.responseHandler(apiName: "api/staff/getAllStaffCategory")
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              staffCatList = responseData.Data;
              isLoading = false;
            });
            print(responseData.Data);
          } else {
            print(responseData);
            setState(() {
              staffCatList = responseData.Data;
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }

  _addStaffCategory() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {"staffCategoryName": tempList};
        log(tempList.toString());
        setState(() {
          isSLoading = true;
        });
        Services.responseHandler(
                apiName: "api/staff/addStaffCategory", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData);
            setState(() {
              isAdd = false;
              isSLoading = false;
            });
            tempList.clear();
            _getStaffCategory();
            print(responseData.Data);
          } else {
            print(responseData);
            setState(() {
              isSLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isSLoading = false;
          });
          Fluttertoast.showToast(msg: "$error");
        });
      }
    } catch (e) {
      setState(() {
        isSLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }
}
