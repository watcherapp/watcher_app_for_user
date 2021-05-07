import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/GetPass.dart';

class InviteGuestComponent extends StatefulWidget {
  var guestData;
  Function invitedGuestApi;

  InviteGuestComponent({
    this.guestData,
    this.invitedGuestApi,
  });

  @override
  _InviteGuestComponentState createState() => _InviteGuestComponentState();
}

class _InviteGuestComponentState extends State<InviteGuestComponent> {
  bool isLoading = false;

  _deleteInviteGuest() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "inviteGuestId": widget.guestData["_id"],
        };
        print(body);
        Services.responseHandler(
                apiName: "api/member/deleteMemberInvitedGuest", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            setState(() {
              isLoading = false;
            });
            print(responseData.Data);
            widget.invitedGuestApi();
            Fluttertoast.showToast(
              msg: "Your Invited Guest Deleted Successfully.",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
            Navigator.pop(context);
          } else {
            print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "${responseData.Message}");
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "${error}");
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }

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
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: Container(
                  width: 1,
                  height: 40,
                  color: Colors.black12,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ShowDialog(
                      deleteGuestApi: (){
                        _deleteInviteGuest();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 12),
                  child: Icon(
                    Icons.delete_outline_outlined,
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

class ShowDialog extends StatefulWidget {

  Function deleteGuestApi;

  ShowDialog({
    this.deleteGuestApi,
  });

  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // 'Approve the Flat  (${widget.memberData["WingData"][0]["wingName"]} - ${widget.memberData["flatNo"]})',
              'Delete Guest',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appPrimaryMaterialColor),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to Delete this Invited Guest.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                // color: appPrimaryMaterialColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                    child: Text("Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.red[400].withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                RaisedButton(
                    child: Text("Yes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.green[400],
                    onPressed: () {
                      widget.deleteGuestApi();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
