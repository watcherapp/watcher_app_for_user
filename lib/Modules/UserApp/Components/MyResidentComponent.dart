import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class MyResidentComponent extends StatefulWidget {
  var memberPropertyData;

  MyResidentComponent({
    this.memberPropertyData,
  });

  @override
  _MyResidentComponentState createState() => _MyResidentComponentState();
}

class _MyResidentComponentState extends State<MyResidentComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
            color: appPrimaryMaterialColor[100],
            borderRadius: BorderRadius.circular(6.0)),
        width: 200,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Image.asset(
                "images/building.png",
                width: 25,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        widget.memberPropertyData["SocietyData"][0]
                            ["societyName"],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: [
                          Text(
                              "${widget.memberPropertyData["WingData"][0]["wingName"]}- ${widget.memberPropertyData["flatNo"]}",
                              style: TextStyle(
                                  fontFamily: "Montserrat-Bold",
                                  fontSize: 15,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: widget.memberPropertyData["MemberData"]
                                  [0]["society"]["isApprove"] ==
                                      true ? Colors.green : Color(0xFFFF4F4F),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: widget.memberPropertyData["MemberData"]
                                            [0]["society"]["isApprove"] ==
                                        true
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.verified_sharp,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            " Approved",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Container(
                                            height: 12,
                                            width: 12,
                                            child: Image.asset(
                                              "images/pendingApproval.png",
                                            ),
                                          ),
                                          Text(
                                            " Not Approved",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
