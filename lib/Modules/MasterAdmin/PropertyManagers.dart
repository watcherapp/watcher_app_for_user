import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class PropertyManagers extends StatefulWidget {
  @override
  _PropertyManagersState createState() => _PropertyManagersState();
}

class _PropertyManagersState extends State<PropertyManagers> {
  TabController _tabController;
  String dateData;
  List<String> date;
  String month;

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
    return DefaultTabController(
      length: 3,
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
              padding: const EdgeInsets.only(top: 10.0, left: 7, right: 7),
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
                      borderRadius: BorderRadius.circular(25),
                      color: appPrimaryMaterialColor),
                  onTap: (index) {},
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "All",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text("Approval"),
                    ),
                    Tab(
                      child: Text("Denied "),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 7),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    4.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 4,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: appPrimaryMaterialColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 11.0, right: 5),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "13" + " - " + "May",
                                                // "${date[0]}" + " - " + "May",
                                                //  "-" + "${funMonth("${date[1]}")}",
                                                style: TextStyle(
                                                    color:
                                                        appPrimaryMaterialColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3.0),
                                                child: Text(
                                                  "09:00 PM",
                                                  //  '${new DateFormat.MMM().format(DateTime.parse(DateFormat("yyyy-MM-dd").parse(widget.notification["Date"].toString().substring(0,10)).toString()))},${widget.notification["Date"].substring(0, 4)}',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Container(
                                            color: Colors.grey[300],
                                            width: 0.8,
                                            height: 54,
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Sunshine Place",
                                                      //'${widget.notification["Title"]}',
                                                      style: TextStyle(
                                                          color:
                                                              appPrimaryMaterialColor,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3.0),
                                                  child: Text(
                                                    "160 st , Fresh Meado , NY , 11365",
                                                    //'${widget.notification["Title"]}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ]),
                                        )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            height: 25,
                                            width: 70,
                                            child: FlatButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                // side: BorderSide(color: Colors.red)
                                              ),
                                              color:
                                                  appPrimaryMaterialColor[100],
                                              onPressed: () {},
                                              child: Text(
                                                "View",
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        appPrimaryMaterialColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
