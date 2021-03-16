import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/PropertyManagers.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/CategoryScreen.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/PropertyManagersDetail.dart';

class MasterAdminDashboard extends StatefulWidget {
  @override
  _MasterAdminDashboardState createState() => _MasterAdminDashboardState();
}

class _MasterAdminDashboardState extends State<MasterAdminDashboard> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin", style: TextStyle(fontFamily: 'Montserrat')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 6, right: 6),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: PropertyManagers(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/manager.png",
                                width: 34,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Property Manager's",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: CategoryScreen(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/Category.png",
                                width: 32,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Category",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/digital-marketing.png",
                              width: 33,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Advertisement",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Montserrat'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/Payment_setting.png",
                              width: 32,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Payment Setting",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Montserrat'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10, right: 6),
              child: Text(
                "Recent Requests",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600),
              ),
            ),
            ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
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
                                  padding: const EdgeInsets.only(
                                      left: 11.0, right: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "${date[0]}" + " - " + "May",
                                        /*  "-" +
                                            "${funMonth("${date[1]}")}",*/
                                        style: TextStyle(
                                            color: appPrimaryMaterialColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 3.0),
                                        child: Text(
                                          "09:00 PM",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Sunshine Place",
                                              //'${widget.notification["Title"]}',
                                              style: TextStyle(
                                                  color:
                                                      appPrimaryMaterialColor,
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            /*Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                height: 25,
                                                width: 70,
                                                child: FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    // side: BorderSide(color: Colors.red)
                                                  ),
                                                  color:
                                                      appPrimaryMaterialColor[
                                                          200],
                                                  onPressed: () {},
                                                  child: Text(
                                                    "View",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            appPrimaryMaterialColor),
                                                  ),
                                                ),
                                              ),
                                            ),*/
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3.0),
                                          child: Text(
                                            "160 st , Fresh Meado , NY , 11365",
                                            //'${widget.notification["Title"]}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w400),
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
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    height: 25,
                                    width: 70,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        // side: BorderSide(color: Colors.red)
                                      ),
                                      color: appPrimaryMaterialColor[100],
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                child: PropertyManagersDetail(),
                                                type: PageTransitionType
                                                    .rightToLeft));
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
                }),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: PropertyManagers(),
                        type: PageTransitionType.rightToLeft));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "See All",
                    style: TextStyle(
                        // fontFamily: 'Montserrat',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Card(
                        shape: RoundedRectangleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Container(
                                  width: 52.0,
                                  height: 52.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOgyZcAP0Ig-SbVQrqBrMw7lP9gz6zv1rN2Q&usqp=CAU",
                                          ))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Text("Grijeshsing Rajput"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );*/
