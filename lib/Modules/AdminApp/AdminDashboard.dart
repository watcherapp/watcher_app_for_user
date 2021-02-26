import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List dashFields = [
    {"label": "Complaints", "img": "images/complain.png"},
    {"label": "Directory", "img": "images/directory.png"},
    {"label": "Parking", "img": "images/car.png"},
    {"label": "My Building", "img": "images/building.png"},
    {"label": "Emergency", "img": "images/alarm.png"},
    {"label": "Advertisement", "img": "images/ad-campaign.png"},
    {"label": "Management", "img": "images/team.png"},
    {"label": "Interaction", "img": "images/chat (1).png"},
    {"label": "Help Desk", "img": "images/communications.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: appPrimaryMaterialColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {}),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 13.0, right: 13, top: 20),
            child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(3.0, 5.0))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 11.0),
                      child: Text(
                        "28 Days remaning",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 11.0),
                      child: Text(
                        "View Pricing",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: appPrimaryMaterialColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13.0, right: 13, top: 12),
            child: Container(
                height: 95,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(3.0, 5.0))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text(
                              "0160203220",
                              style: TextStyle(
                                  color: appPrimaryMaterialColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 11.0, right: 10),
                            child: Text(
                              "Share abouve code with building members to join xyz,",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 25.0, left: 8),
                        child: Icon(
                          Icons.share,
                          color: appPrimaryMaterialColor,
                          size: 32,
                        )),
                  ],
                )),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 8, left: 11, right: 11),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 3.0),
            itemBuilder: (BuildContext context, int index) {
              return dashBox(
                dashFields[index]["label"],
                dashFields[index]["img"],
              );
            },
            itemCount: dashFields.length,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13.0, right: 13, top: 10),
            child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(3.0, 5.0))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/gate.png",
                      width: 38,
                      color: appPrimaryMaterialColor,
                    ),
                    FittedBox(
                      // fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "Gate Keeper",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
      /*StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        itemCount: dashFields.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, int index) {
          return dashBox(
            dashFields[index]["label"],
            dashFields[index]["img"],
          );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      ),*/
    );
  }

  Widget dashBox(
    String label,
    String img,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5, right: 3, left: 3),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  offset: Offset(3.0, 5.0))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              width: 37,
              color: appPrimaryMaterialColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: FittedBox(
                // fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: appPrimaryMaterialColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
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
