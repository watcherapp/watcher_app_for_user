import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';

class VendorEntryComponent extends StatefulWidget {
  @override
  _VendorEntryComponentState createState() => _VendorEntryComponentState();
}

class _VendorEntryComponentState extends State<VendorEntryComponent> {
  TextEditingController txtSearch = new TextEditingController();
  List vendorList = [];
  bool isLoading = false;

  //vendor.......................

  bool isOpenV = false;
  DateTime selectedFromDateV = DateTime.now();
  DateTime selectedToDateV = DateTime.now();

  var fromDateV = DateFormat('dd / MM / yyyy');
  var toDateV = DateFormat('dd / MM / yyyy');

  var dateFormateV = DateFormat('dd/MM/yyyy');

  showToDatePickerV(BuildContext context, var forDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now());

    if (forDate == "fromDate") {
      if (picked != null && picked != selectedFromDateV)
        setState(() {
          selectedFromDateV = picked;
        });
    } else if (forDate == "toDate") {
      if (picked != null && picked != selectedToDateV)
        setState(() {
          selectedToDateV = picked;
        });
    }
  }

  _getAllvendor() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
          "type": "2",
          "fromDate": dateFormateV.format(selectedFromDateV),
          "toDate": dateFormateV.format(selectedToDateV),
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/staff/getAllVisitorList", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              vendorList = responseData.Data;
              print("vendorList----------------->$vendorList");
              isLoading = false;
            });
          } else {
            print(responseData);
            setState(() {
              isLoading = false;
            });
            // Fluttertoast.showToast(
            //   msg: "${responseData.Message}",
            //   backgroundColor: Colors.white,
            //   textColor: appPrimaryMaterialColor,
            // );
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

  List tempList = [];
  bool isSearching = false;

  void searchOperation(String searchText) {
    if (searchText != "") {
      setState(() {
        tempList.clear();
        isSearching = true;
      });
      String mobile = "", name = "", vehicleNo = "";
      for (int i = 0; i < vendorList.length; i++) {
        name = vendorList[i]["VendorData"][0]["vendorName"];
        mobile = vendorList[i]["VendorData"][0]["mobileNo1"];
        vehicleNo = vendorList[i]["VendorData"][0]["vehicleNo"];
        if (name.toLowerCase().contains(searchText.toLowerCase()) ||
            mobile.toLowerCase().contains(searchText.toLowerCase()) ||
            vehicleNo.toLowerCase().contains(searchText.toLowerCase())) {
          setState(() {
            tempList.add(vendorList[i]);
          });
        }
      }
    } else {
      setState(() {
        isSearching = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllvendor();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
                //backgroundColor: Colors.white54,
              ),
            ),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, right: 8.0, left: 8.0),
                      child: Container(
                        height: 70,
                        // width: MediaQuery.of(context).size.width *0.5,
                        child: TextFormField(
                          onChanged: searchOperation,
                          controller: txtSearch,
                          scrollPadding: EdgeInsets.all(0),
                          decoration: InputDecoration(
                            counter: Text(""),
                            border: new OutlineInputBorder(
                                borderSide:
                                new BorderSide(color: appPrimaryMaterialColor),
                                borderRadius: BorderRadius.all(Radius.circular(8))),
                            suffixIcon: Icon(
                              Icons.search,
                              size: 20,
                              color: appPrimaryMaterialColor,
                            ),
                            hintText: "Search Visitor",
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'WorkSans Bold'),
                          ),
                          maxLength: 100,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: appPrimaryMaterialColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 2, top: 5, left: 5, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOpenV = !isOpenV;
                            });
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                                border: Border.all(
                                  color: appPrimaryMaterialColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 6.0, right: 4.0, top: 2.0, bottom: 2.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "images/filter.png",
                                    width: 16,
                                    color: appPrimaryMaterialColor,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 6.0, right: 3),
                                    child: Text(
                                      "Filter",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: appPrimaryMaterialColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         PageTransition(
                        //             child: InviteGuest(onSaved: () {
                        //               _getAllvisitor();
                        //             }),
                        //             type: PageTransitionType.rightToLeft));
                        //   },
                        //   child: Container(
                        //     height: 25,
                        //     decoration: BoxDecoration(
                        //       // color: Colors.white,
                        //         border: Border.all(
                        //           color: appPrimaryMaterialColor,
                        //           width: 1,
                        //         ),
                        //         borderRadius: BorderRadius.circular(4.0)),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(
                        //           left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                        //       child: Row(
                        //         children: [
                        //           Icon(
                        //             Icons.add_circle_outline_sharp,
                        //             size: 16,
                        //             color: appPrimaryMaterialColor,
                        //           ),
                        //           Padding(
                        //             padding:
                        //             const EdgeInsets.only(left: 4.0, right: 3),
                        //             child: Text(
                        //               "Add",
                        //               style: TextStyle(
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.bold,
                        //                   color: appPrimaryMaterialColor),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
              isOpenV == true
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, bottom: 8, top: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: appPrimaryMaterialColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 6.0, top: 15, right: 10, bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Valid From",
                                            style:
                                                fontConstants.formFieldLabel1,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                showToDatePickerV(
                                                    context, "fromDate");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    color: Colors.grey[200]),
                                                height: 35,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Center(
                                                    child: Text(
                                                  selectedFromDateV != null
                                                      ? fromDateV.format(
                                                          selectedFromDateV)
                                                      : "Select Date",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Valid To",
                                              style: fontConstants
                                                  .formFieldLabel1),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                showToDatePickerV(
                                                    context, "toDate");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    color: Colors.grey[200]),
                                                height: 35,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Center(
                                                    child: Text(
                                                        selectedToDateV != null
                                                            ? toDateV.format(
                                                                selectedToDateV)
                                                            : "Select Date",
                                                        style: TextStyle(
                                                            fontSize: 13))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: SizedBox(
                                width: 150,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: appPrimaryMaterialColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                  ),
                                  onPressed: () {
                                    _getAllvendor();
                                  },
                                  child: Text(
                                    "Search",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
              vendorList.length == 0
                  ? Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text("No Vendor Entry Found"),
                      ),
                    )
                  : Expanded(
                      child: isSearching
                          ? Container(
                              child: ListView.builder(
                                itemBuilder: (_, index) => VendorComponent(
                                  vendorData: vendorList[index],
                                ),
                                // itemCount: 8,
                                itemCount: vendorList.length,
                              ),
                            )
                          : Container(
                              child: ListView.builder(
                                itemBuilder: (_, index) => VendorComponent(
                                  vendorData: vendorList[index],
                                ),
                                // itemCount: 8,
                                itemCount: vendorList.length,
                              ),
                            ),
                    ),
            ],
          );
  }
}

class VendorComponent extends StatefulWidget {
  var vendorData;

  VendorComponent({
    this.vendorData,
  });

  @override
  _VendorComponentState createState() => _VendorComponentState();
}

class _VendorComponentState extends State<VendorComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              widget.vendorData["VendorData"][0]["vendorImage"] == null ||
                      widget.vendorData["VendorData"][0]["vendorImage"] == ""
                  ? Image.asset(
                      'images/user.png',
                      width: 70,
                      height: 70,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Container(
                        height: 70.0,
                        width: 70,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 0.2, color: appPrimaryMaterialColor),
                          image: DecorationImage(
                            image: NetworkImage(
                              API_URL +
                                  widget.vendorData["VendorData"][0]
                                      ["vendorImage"],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.vendorData["VendorData"][0]["vendorName"],
                    style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.vendorData["VendorData"][0]["mobileNo1"],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                ],
              ),
              SizedBox(
                width: 105,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.message),
                iconSize: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
