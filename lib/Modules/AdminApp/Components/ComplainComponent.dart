import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/ComplainDetail.dart';

class ComplainComponent extends StatefulWidget {
  @override
  _ComplainComponentState createState() => _ComplainComponentState();
}

class _ComplainComponentState extends State<ComplainComponent> {
  String dateData;
  List<String> date;
  String month;

  @override
  void initState() {
    //dateData = " ${widget.notificationData["date"]}";
    funDate();
  }

  funDate() {
    dateData = "04/03/2021";
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: ComplainDetail(), type: PageTransitionType.rightToLeft));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4),
        child: Container(
          height: 95,
          child: Card(
            shape: RoundedRectangleBorder(
              /* side: BorderSide(
                                      width: 0.50, color: appPrimaryMaterialColor),*/
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
                      height: 86,
                      decoration: BoxDecoration(
                          color: appPrimaryMaterialColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 5),
                      child: Column(
                        children: <Widget>[
                          Text(
                            " ${date[0]}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Mon",
                                  //  '${new DateFormat.MMM().format(DateTime.parse(DateFormat("yyyy-MM-dd").parse(widget.notification["Date"].toString().substring(0,10)).toString()))},${widget.notification["Date"].substring(0, 4)}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w600),
                                ),
                                /*Text(
                                                      " ${date[2]}",
                                                      //  '${new DateFormat.MMM().format(DateTime.parse(DateFormat("yyyy-MM-dd").parse(widget.notification["Date"].toString().substring(0,10)).toString()))},${widget.notification["Date"].substring(0, 4)}',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )*/
                              ],
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        color: Colors.grey,
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
                            Text(
                              "Waste Disposal management Event",
                              //'${widget.notification["Title"]}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Complain By  :  ",
                                    //'${widget.notification["Title"]}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Solanki Meghana",
                                    //'${widget.notification["Title"]}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Priority  :  ",
                                    //'${widget.notification["Title"]}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "High",
                                    //'${widget.notification["Title"]}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),

                            /* Text(
                                                  // '${widget.notification["Description"]}',
                                                  "Waste disposal management event in our society so please sir take any action",
                                                  style: TextStyle(
                                                      color: Colors.grey[500],
                                                      fontSize: 14),
                                                ),*/
                          ]),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
