import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/GetPass.dart';

class InviteGuestComponent extends StatefulWidget {
  var guestData;

  InviteGuestComponent({this.guestData});

  @override
  _InviteGuestComponentState createState() => _InviteGuestComponentState();
}

class _InviteGuestComponentState extends State<InviteGuestComponent> {
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
                child: Container(
                  width: 57.0,
                  height: 57.0,
                  child: widget.guestData["guestImage"] == "" ||
                          widget.guestData["guestImage"] == null
                      ? Image.asset(
                          'images/maleavtar.png',
                        )
                      : Image.network("${widget.guestData["guestImage"]}"),
                  decoration: new BoxDecoration(
                    color: Color(0x22888888),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(90.0)),
                    border: new Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              /* Image.asset(
                'images/maleavtar.png',
                width: 70,
              ),*/
              Padding(
                padding: const EdgeInsets.only(left: 17.0),
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
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("${widget.guestData["Name"]}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("${widget.guestData["ContactNo"]}",
                            style: TextStyle(fontSize: 15, color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return GetPass(
                          myGuestData: widget.guestData,
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 12),
                  child: Icon(
                    Icons.share,
                    color: appPrimaryMaterialColor,
                    size: 24,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
