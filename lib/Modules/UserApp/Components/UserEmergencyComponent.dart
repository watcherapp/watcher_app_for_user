import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';

class UserEmergencyComponent extends StatefulWidget {
  var userEmergencyData;

  UserEmergencyComponent({this.userEmergencyData});

  @override
  _UserEmergencyComponentState createState() => _UserEmergencyComponentState();
}

class _UserEmergencyComponentState extends State<UserEmergencyComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                child: Image.network(
                 API_URL + "${widget.userEmergencyData["image"]}",
                  width: 60,
                  // height: 50,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
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
                    Text("${widget.userEmergencyData["contactName"]}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("${widget.userEmergencyData["contactNo"]}",
                          style: TextStyle(fontSize: 15, color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
