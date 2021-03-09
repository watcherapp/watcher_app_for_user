import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class MyVehicleComponent extends StatefulWidget {
  @override
  _MyVehicleComponentState createState() => _MyVehicleComponentState();
}

class _MyVehicleComponentState extends State<MyVehicleComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
            color: appPrimaryMaterialColor[50],
            borderRadius: BorderRadius.circular(6.0)),
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset(
                "images/car.png",
                width: 37,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("7515",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10),
                    child: Text("Gj05xx00",
                        style: TextStyle(
                            fontFamily: "Montserrat-Bold",
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
