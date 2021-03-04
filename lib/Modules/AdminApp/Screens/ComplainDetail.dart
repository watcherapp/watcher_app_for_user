import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class ComplainDetail extends StatefulWidget {
  @override
  _ComplainDetailState createState() => _ComplainDetailState();
}

class _ComplainDetailState extends State<ComplainDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Waste Disposal management Event",
                //'${widget.notification["Title"]}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Image.network(
                "https://cityspideynews.s3.amazonaws.com/uploads/spidey/201906/grihapravesh_061319062347.jpg",
                height: 170,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
              child: Text(
                "   They complained that the association, which takes care of the society's maintenance, is not allowing them to access the power backup facility and also charging exorbitant rates for the same.\n   Avnish Jha, who has shifted to his flat recently, said that the problem is happening with the people who have bought unsold inventories from the developer. He added that they are allowed to use limited facilities different than other residents.",
                //'${widget.notification["Title"]}',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  //        fontWeight: FontWeight.w500
                ),
              ),
            ),
            Container(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.amber,
                          border: Border.all(color: Colors.amber, width: 2)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("REQUESTED",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Container(
                    width: 7,
                  ),
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.red,
                          border: Border.all(color: Colors.red, width: 2)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("REJECTED",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: appPrimaryMaterialColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: appPrimaryMaterialColor, width: 2)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("START TAKING ACTIONS",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.green, width: 2)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "RESOLVED",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
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
    );
  }
}
