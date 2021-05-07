import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class FamilyMemberComponent extends StatefulWidget {
  var familyDataList;

  FamilyMemberComponent({
    this.familyDataList,
  });

  @override
  _FamilyMemberComponentState createState() => _FamilyMemberComponentState();
}

class _FamilyMemberComponentState extends State<FamilyMemberComponent> {
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
              child: widget.familyDataList["memberImage"] == null ||
                      widget.familyDataList["memberImage"] == ""
                  ? Image.asset(
                      'images/maleavtar.png',
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Container(
                        height: 70.0,
                        width: 70,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 0.2, color: appPrimaryMaterialColor),
                          image: DecorationImage(
                            image: NetworkImage(
                              API_URL + widget.familyDataList["memberImage"],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Text(
                "${widget.familyDataList["firstName"]} ${widget.familyDataList["lastName"]}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ),
          Text("${widget.familyDataList["relation"] ?? "Relation"}",
              style: TextStyle(fontSize: 12, color: Colors.black87)),
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
