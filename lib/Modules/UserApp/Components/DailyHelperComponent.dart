import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class DailyHelperComponent extends StatefulWidget {
  var myStaffData;

  DailyHelperComponent({
    this.myStaffData,
  });

  @override
  _DailyHelperComponentState createState() => _DailyHelperComponentState();
}

class _DailyHelperComponentState extends State<DailyHelperComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: ClipOval(
              child: widget.myStaffData["staffImage"] == null
                  ? Image.asset(
                      'images/maleavtar.png',
                    )
                  : Image.network(
                      // 'https://randomuser.me/api/portraits/men/4.jpg',
                      API_URL + widget.myStaffData["staffImage"],
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Text(
                // "smit vaghani",
                "${widget.myStaffData["firstName"]} ${widget.myStaffData["lastName"]}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ),
          Text("Cook", style: TextStyle(fontSize: 12, color: Colors.black87)),
          Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.green,
                    size: 22,
                  ),
                  onPressed: () {}),
              Container(
                width: 1,
                height: 18,
                color: Colors.grey[200],
              ),
              IconButton(
                  icon: Icon(
                    Icons.share,
                    color: appPrimaryMaterialColor,
                    size: 22,
                  ),
                  onPressed: () {})
            ],
          )
        ],
      ),
    );
  }
}
