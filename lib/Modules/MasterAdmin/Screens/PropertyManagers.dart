import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Providers/PropertyManagerProvider.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Components/PropertyManagerComponent.dart';

class PropertyManagers extends StatefulWidget {
  @override
  _PropertyManagersState createState() => _PropertyManagersState();
}

class _PropertyManagersState extends State<PropertyManagers> {
  TabController _tabController;
  String dateData;
  List<String> date;
  String month;

  List tabList = [
    {
      "tabName": "Pending",
      "status": "0",
    },
    {
      "tabName": "Approved",
      "status": "1",
    },
    {
      "tabName": "Denied",
      "status": "2",
    },
    {
      "tabName": "All",
      "status": "3",
    },
  ];

  @override
  void initState() {
    //dateData = " ${widget.notificationData["date"]}";
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
    var provider = Provider.of<PropertyManagerProvider>(context);
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
                  tabs: <Widget>[
                    Tab(
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
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                  Icon(Icons.directions_bike),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 7),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.ManagerDatailList.length,
                        itemBuilder: (context, index) {
                          return PropertyManagetComponent(
                            propertyManagerData:
                                provider.ManagerDatailList[index],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
