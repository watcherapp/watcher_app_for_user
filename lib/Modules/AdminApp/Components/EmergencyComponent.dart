import 'package:flutter/material.dart';

class EmergencyComponent extends StatefulWidget {
  @override
  _EmergencyComponentState createState() => _EmergencyComponentState();
}

class _EmergencyComponentState extends State<EmergencyComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Image.asset(
                  "images/police.png",
                  width: 60,
                ),
              ),
              /* Image.asset(
                'images/maleavtar.png',
                width: 70,
              ),*/
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  width: 1,
                  height: 72,
                  color: Colors.black12,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Police Station",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("101",
                            style: TextStyle(fontSize: 15, color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.edit,
                    size: 21,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Icon(
                      Icons.delete,
                      size: 22,
                      color: Colors.red,
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
