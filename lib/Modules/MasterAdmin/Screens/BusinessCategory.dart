import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Components/BussinessComponent.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Components/VendorComponent.dart';

class BusinessCategory extends StatefulWidget {
  @override
  _BusinessCategoryState createState() => _BusinessCategoryState();
}

class _BusinessCategoryState extends State<BusinessCategory> {
  bool isAdd = false;
  final TextEditingController txtbusinessname = new TextEditingController();
  List tempList = [];
  bool isLoading = false;
  bool isDLoading = false;
  List bussinessCatList = [];
  bool isSLoading = false;

  @override
  void initState() {
    print("${isAdd}");
    _getBusinessCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Business Category",
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
                                controller: txtbusinessname,
                                lable: "Business Name",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter busiess Name";
                                  }
                                  return "";
                                },
                                hintText: "Type business Name"),
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
                                  if (txtbusinessname.text != "") {
                                    setState(() {
                                      tempList.add(txtbusinessname.text);
                                      txtbusinessname.text = "";
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                          ),
                          onPressed: () {
                            _addBusinessCategory();
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
                        bussinessCatList.length > 0
                            ? ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10, top: 13),
                                      child: Divider(
                                        color: Colors.grey,
                                        height: 1,
                                      ),
                                    ),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 5, bottom: 18),
                                scrollDirection: Axis.vertical,
                                itemCount: bussinessCatList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return BusinessComponent(
                                    businessData: bussinessCatList[index],
                                    onremove: () {
                                      _getBusinessCategory();
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
                            /* FlatButton(
                          height: 32,
                          color: Colors.grey[200],
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
                        ),*/
                          ),
                        )
                      ],
                    ),
                  ),
                ),
    );
  }

  _getBusinessCategory() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.responseHandler(apiName: "api/admin/getAllBusinessCategory")
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              bussinessCatList = responseData.Data;
              isLoading = false;
            });
            print(responseData.Data);
          } else {
            print(responseData);
            setState(() {
              bussinessCatList = responseData.Data;
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

  _addBusinessCategory() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {"businessCategoryName": tempList};
        log(tempList.toString());
        setState(() {
          isSLoading = true;
        });
        Services.responseHandler(
                apiName: "api/admin/addBusinessCategory", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData);
            setState(() {
              isAdd = false;
              isSLoading = false;
            });
            tempList.clear();
            _getBusinessCategory();
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
