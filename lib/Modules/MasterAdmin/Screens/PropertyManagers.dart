import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Providers/PropertyManagerProvider.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Components/PropertyManagerComponent.dart';

class PropertyManagers extends StatefulWidget {
  @override
  _PropertyManagersState createState() => _PropertyManagersState();
}

class _PropertyManagersState extends State<PropertyManagers>
    with TickerProviderStateMixin {
  TabController _tabController;
  String dateData;
  List<String> date;
  String month;
  bool isLoading = false;
  List managerList = [];

  List tabList = [
    {
      "tabName": "Pending",
      "status": 0,
    },
    {
      "tabName": "Approved",
      "status": 1,
    },
    {
      "tabName": "Denied",
      "status": 2,
    },
    {
      "tabName": "All",
      "status": 3,
    },
  ];

  _tabCon() {
    setState(() {
      _tabController = TabController(vsync: this, length: tabList.length);
      _tabController.addListener(() {
        _getPropertyManager(tabList[_tabController.index]["status"]);
        print(_getPropertyManager(tabList[_tabController.index]["status"]));
      });
    });
  }

  @override
  void initState() {
    _getPropertyManager(0);
    _tabCon();
    funDate();
  }

  funDate() {
    dateData = "12/03/2021";
    date = dateData.split('/');
    funMonth("${date[1]}");
  }

  funMonth(String mon) {
    if (mon == "01") {
      month = "Jan";
    } else if (mon == "02") {
      month = "Feb";
    } else if (mon == "03") {
      month = "March";
    } else if (mon == "04") {
      month = "April";
    } else if (mon == "05") {
      month = "May";
    } else if (mon == "06") {
      month = "June";
    } else if (mon == "07") {
      month = "July";
    } else if (mon == "08") {
      month = "Aug";
    } else if (mon == "09") {
      month = "Sept";
    } else if (mon == "10") {
      month = "Oct";
    } else if (mon == "11") {
      month = "Nov";
    } else if (mon == "12") {
      month = "Dec";
    } else {
      month = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    /* var provider = Provider.of<PropertyManagerProvider>(context);*/
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text("Property Managers",
              style: TextStyle(fontFamily: 'Montserrat')),
          centerTitle: true,
          elevation: 0,
          backgroundColor: appPrimaryMaterialColor,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 4, right: 4),
              child: Container(
                height: 38,
                child: TabBar(
                  controller: _tabController,
                  //labelPadding: EdgeInsets.only(left: 9.0, right: 9.0),
                  // indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: Colors.black54,
                  labelColor: Colors.white,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  //isScrollable: true,
                  indicatorColor: appPrimaryMaterialColor,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: appPrimaryMaterialColor),
                  onTap: (index) {},
                  tabs: List<Widget>.generate(tabList.length, (int index) {
                    return Tab(
                      child: Text(
                        tabList[index]["tabName"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.0),
                      ),
                    );
                  }),
                  /*Tab(
                      child: Text(
                        "Pending",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Approved",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Denied ",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "All",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),*/
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  children: List<Widget>.generate(tabList.length, (int index) {
                    return isLoading == true
                        ? Center(
                            child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                appPrimaryMaterialColor),
                          ))
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: managerList.length,
                            itemBuilder: (context, index) {
                              return PropertyManagetComponent(
                                  propertyManagerData: managerList[index]);
                            });
                  })),
            ),
          ],
        ),
      ),
    );
  }

  _getPropertyManager(var status) async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {
          "requestStatusCode": status,
        };
        print(body);
        Services.responseHandler(
                apiName: "api/admin/getListOfRequestPropertyManager",
                body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              managerList = responseData.Data;
              isLoading = false;
            });
            print(responseData.Data);
          } else {
            print(responseData);
            setState(() {
              managerList = responseData.Data;
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
}
