import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class SocietyCategory extends StatefulWidget {
  @override
  _SocietyCategoryState createState() => _SocietyCategoryState();
}

class _SocietyCategoryState extends State<SocietyCategory> {
  bool isAdd = false;
  final TextEditingController txtsocityname = new TextEditingController();
  List tempList = [];
  bool isLoading = false;
  bool isDLoading = false;
  List socityCategory = [];

  @override
  void initState() {
    print("${isAdd}");
    _getSocietyCategory();
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
          ? Padding(
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
                              controller: txtsocityname,
                              lable: "Guest Name",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Please Enter Guest Name";
                                }
                                return "";
                              },
                              hintText: "Type Guest Name"),
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
                                if (txtsocityname.text != "") {
                                  setState(() {
                                    tempList.add(txtsocityname.text);
                                    txtsocityname.text = "";
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
                            /*FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                              height: 32,
                              color: appPrimaryMaterialColor,
                              onPressed: () {
                                if (txtsocityname.text != "") {
                                  setState(() {
                                    tempList.add(txtsocityname.text);
                                    txtsocityname.text = "";
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Data Added Successfully");
                                }
                              },
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13,
                                    color: Colors.white),
                              ),
                            ),*/
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
                                    //tempList.remove(txtsocityname.text);
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
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
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
                      /*FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        color: appPrimaryMaterialColor,
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Save",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),*/
                    ),
                  )
                ],
              ),
            )
          : isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        appPrimaryMaterialColor),
                    //backgroundColor: Colors.white54,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    children: [
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
                          padding: EdgeInsets.only(top: 5, bottom: 18),
                          scrollDirection: Axis.vertical,
                          itemCount: socityCategory.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${socityCategory[index]["categoryName"]}"),
                                  GestureDetector(
                                    onTap: () {
                                      _deleteSocietyCategory(
                                          socityCategory[index]["_id"]);
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
                        height: 20,
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
    );
  }

  _getSocietyCategory() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.responseHandler(
          apiName: "api/society/getAllSocietyCategory",
        ).then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              socityCategory = responseData.Data;
              isLoading = false;
            });
            print(responseData.Data);
          } else {
            print(responseData);
            setState(() {
              socityCategory = responseData.Data;
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

  _deleteSocietyCategory(var societyId) async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyCategoryId": "${societyId}",
        };
        setState(() {
          isDLoading = true;
        });
        Services.responseHandler(
                apiName: "api/society/deleteSocietyCategory", body: body)
            .then((responseData) {
          if (responseData.Data != 0) {
            Fluttertoast.showToast(msg: "Category Deleted Successfully");
            setState(() {
              isDLoading = false;
            });
            _getSocietyCategory();
          } else {
            print(responseData);
            setState(() {
              isDLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isDLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isDLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }
}
