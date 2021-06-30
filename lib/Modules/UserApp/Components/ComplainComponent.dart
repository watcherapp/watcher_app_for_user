import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/BottomNavigationBarCustom.dart';

class ComplainComponent extends StatefulWidget {
  var getAllComplain;
  Function getComplaindApi;

  ComplainComponent({
    this.getAllComplain,
    this.getComplaindApi,
  });

  @override
  _ComplainComponentState createState() => _ComplainComponentState();
}

class _ComplainComponentState extends State<ComplainComponent> {
  String dateData;
  List<String> date;
  String month;
  String mydate;

  @override
  void initState() {
    //dateData = " ${widget.notificationData["date"]}";
    funDate();
  }

  String funDate() {
    dateData = "${widget.getAllComplain["dateTime"][0]}";
    var date_month = dateData.split('/');
    var date_date = dateData.split('/');
    mydate = date_date[0];

    // print("${date_month[1]}");
    // print("${date_date[0]}");
    funMonth("${date_month[1]}");
  }

  funMonth(String mon) {
    print("month-${mon}");
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
    return month;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     PageTransition(
        //         child: ComplainDetail(), type: PageTransitionType.rightToLeft));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4),
        child: Container(
          height: 100,
          child: Column(
            children: [
              Card(
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                " ${mydate}",
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
                                      " ${month}",
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
                            height: 65,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "${widget.getAllComplain["discription"]}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      //'${widget.notification["Title"]}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700),
                                    ),
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
                                          "${widget.getAllComplain["complainBy"]}",
                                          //'${widget.notification["Title"]}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3.0, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text(
                                        //   "Priority  :  ",
                                        //   //'${widget.notification["Title"]}',
                                        //   style: TextStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 12,
                                        //       fontFamily: 'Montserrat',
                                        //       fontWeight: FontWeight.w400),
                                        // ),
                                        // Text(
                                        //   "High",
                                        //   maxLines: 1,
                                        //   overflow: TextOverflow.ellipsis,
                                        //   //'${widget.notification["Title"]}',
                                        //   style: TextStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 13,
                                        //       fontFamily: 'Montserrat',
                                        //       fontWeight: FontWeight.w300),
                                        // ),
                                        Row(
                                          children: [
                                            Text(
                                              "Status  :  ",
                                              //'${widget.notification["Title"]}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              widget.getAllComplain[
                                                          "complainStatus"] ==
                                                      "0"
                                                  ? "REQUESTED"
                                                  : widget.getAllComplain[
                                                              "complainStatus"] ==
                                                          "1"
                                                      ? "REJECTED"
                                                      : widget.getAllComplain[
                                                                  "complainStatus"] ==
                                                              "2"
                                                          ? "START TAKING ACTIONS"
                                                          : "RESOLVED",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              //'${widget.notification["Title"]}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: ComplainDetail(
                                                    complaintData:
                                                        widget.getAllComplain,
                                                    getComplainApi:
                                                        widget.getComplaindApi,
                                                  ),
                                                  type: PageTransitionType
                                                      .rightToLeft),
                                            );
                                          },
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "images/rightArrow.png",
                                              color: Colors.grey[400],
                                            ),
                                          ),
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
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.,
              //   child: Container(
              //     color: appPrimaryMaterialColor,
              //     child: Text(
              //       "data",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // )
              // Positioned(
              //   right: 5.0,
              //   bottom: 4.0,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: appPrimaryMaterialColor,
              //         borderRadius: BorderRadius.only(
              //           bottomRight: Radius.circular(5),
              //           bottomLeft: Radius.circular(5),
              //           topLeft:Radius.circular(5),
              //           topRight: Radius.circular(5),
              //         ),),
              //
              //     child: Padding(
              //       padding: const EdgeInsets.only(top: 5,bottom: 5,right: 8,left: 10),
              //       child: Text(
              //         "  A-101  ",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 14,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class ComplainDetail extends StatefulWidget {
  var complaintData;
  Function getComplainApi;

  ComplainDetail({
    this.complaintData,
    this.getComplainApi,
  });

  @override
  _ComplainDetailState createState() => _ComplainDetailState();
}

class _ComplainDetailState extends State<ComplainDetail> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Complaints Detail",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    widget.complaintData["subject"],
                    //'${widget.notification["Title"]}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50),
                  child: Image.network(
                    API_URL + widget.complaintData["attachment"],
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 25.0, left: 20, right: 10),
                  child: Text(
                    "Complain Date :-",
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20, right: 10),
                  child: Text(
                    widget.complaintData["dateTime"][0],
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 25.0, left: 20, right: 10),
                  child: Text(
                    "Complain By :-",
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20, right: 10),
                  child: Text(
                    "${widget.complaintData["memberId"]["firstName"]}  ${widget.complaintData["memberId"]["lastName"]}",
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 20, right: 10),
                  child: Text(
                    "Complain Description :-",
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700
                        //        fontWeight: FontWeight.w500
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20, right: 10),
                  child: Text(
                    widget.complaintData["discription"],
                    //'${widget.notification["Title"]}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      //        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}
