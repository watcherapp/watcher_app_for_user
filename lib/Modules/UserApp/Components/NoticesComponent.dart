import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class NoticesComponent extends StatefulWidget {
  var noticeData;

  NoticesComponent({this.noticeData});

  @override
  _NoticesComponentState createState() => _NoticesComponentState();
}

class _NoticesComponentState extends State<NoticesComponent> {
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
  }

  funDate() {
    dateData = "${widget.noticeData["dateTime"][0]}";
    date = dateData.split('/');
    print(date);
  }

  funTime() {
    timeData = "${widget.noticeData["dateTime"][1]}";
    time = timeData.split(':');
    time1 = timeData.split(" ");
    print(time);
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
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        //height: 210,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18),
              child: Text(
               "${widget.noticeData["noticeTitle"]}",
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                height: 0.3,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18, right: 18),
              child: Text(
                "${widget.noticeData["noticeDescription"]}",
                textAlign: TextAlign.justify,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 14, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " - Covid Checking",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: appPrimaryMaterialColor),
                  ),
                ],
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                height: 0.4,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18, bottom: 12),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: appPrimaryMaterialColor[100],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        "${date[0]}" + "-" + "${funMonth(date[1])}"+ "-" +"${date[2]}",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                    height: 33,
                    width: 100,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: appPrimaryMaterialColor[100],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                          "${time1[0]}"+ " "
                             + "${time1[1]}",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: appPrimaryMaterialColor),
                        ),
                      ),
                      height: 33,
                      width: 86,
                    ),
                  ),

                  /*FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    height: 32,
                    color: appPrimaryMaterialColor[100],
                    onPressed: () {},
                    child: Text(
                      "22 Jan 2021",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: appPrimaryMaterialColor),
                    ),
                  ),*/
                 /* Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      height: 32,
                      color: appPrimaryMaterialColor[100],
                      onPressed: () {},
                      child: Text(
                        "02:46 PM",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
