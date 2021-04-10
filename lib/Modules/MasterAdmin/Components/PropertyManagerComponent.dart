import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/PropertyManagersDetail.dart';

class PropertyManagetComponent extends StatefulWidget {
  var propertyManagerData;
  PropertyManagetComponent({this.propertyManagerData});

  @override
  _PropertyManagetComponentState createState() =>
      _PropertyManagetComponentState();
}

class _PropertyManagetComponentState extends State<PropertyManagetComponent> {
  String dateData;
  String timeData;
  var time, time1;
  var date;
  String month;
  String monthName;

  @override
  void initState() {
    //dateData = " ${widget.notificationData["date"]}";
    funDate();
    funTime();
    log(widget.propertyManagerData.toString());
  }

  funDate() {
    dateData = "${widget.propertyManagerData["dateTime"][0]}";
    date = dateData.split('/');
    print(date);
  }

  funTime() {
    timeData = "${widget.propertyManagerData["dateTime"][1]}";
    time = timeData.split(':');
    time1 = timeData.split(" ");
    print(time1);
  }

  String funMonth(String mon) {
    if (mon == "01") {
      return month = "Jan";
    } else if (mon == "02") {
      return month = "Feb";
    } else if (mon == "03") {
      return month = "March";
    } else if (mon == "04") {
      return month = "April";
    } else if (mon == "05") {
      return month = "May";
    } else if (mon == "06") {
      return month = "June";
    } else if (mon == "07") {
      return month = "July";
    } else if (mon == "08") {
      return month = "Aug";
    } else if (mon == "09") {
      return month = "Sept";
    } else if (mon == "10") {
      return month = "Oct";
    } else if (mon == "11") {
      return month = "Nov";
    } else if (mon == "12") {
      return month = "Dec";
    } else {
      return month = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: PropertyManagersDetail(
                  propertyManagerDetailData:
                  widget.propertyManagerData,
                ),
                type: PageTransitionType.rightToLeft));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4),
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                    padding: const EdgeInsets.only(left: 11.0, right: 5),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${date[0]}" + "-" + "${funMonth(date[1])}",
                          style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            "${time[0]}" +
                                " : " +
                                "${time[1]}" +
                                " " "${time1[1]}",
                            //  '${new DateFormat.MMM().format(DateTime.parse(DateFormat("yyyy-MM-dd").parse(widget.notification["Date"].toString().substring(0,10)).toString()))},${widget.notification["Date"].substring(0, 4)}',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      color: Colors.grey[300],
                      width: 0.8,
                      height: 54,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.propertyManagerData["Society"].length > 0
                                  ? Text(
                                      "${widget.propertyManagerData["Society"][0]["societyName"] ?? ""}",
                                      style: TextStyle(
                                          color: appPrimaryMaterialColor,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Container(
                                      child: Text("-"),
                                    ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                "${widget.propertyManagerData["Society"][0]["address"]["completeAddress"] ?? ""}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400),
                              )),
                        ]),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 28,
                      width: 70,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: appPrimaryMaterialColor[100],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: PropertyManagersDetail(
                                    propertyManagerDetailData:
                                    widget.propertyManagerData,
                                  ),
                                  type: PageTransitionType.rightToLeft));
                        },
                        child: Text(
                          "View",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: appPrimaryMaterialColor),
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
  }
}
