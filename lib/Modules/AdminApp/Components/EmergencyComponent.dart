import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/UpdateEmergencyScreen.dart';

class EmergencyComponent extends StatefulWidget {
  var allEmergencyList;
  Function GetEmergencyApi;

  EmergencyComponent({
    this.allEmergencyList,
    this.GetEmergencyApi,
  });

  @override
  _EmergencyComponentState createState() => _EmergencyComponentState();
}

class _EmergencyComponentState extends State<EmergencyComponent> {
  bool isDeleteLoading = false;

  //delete...
  _deleteEmergency() async {
    try {
      setState(() {
        isDeleteLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "emergencyContactId": widget.allEmergencyList["_id"],
        };
        Services.responseHandler(
          apiName: "api/admin/deleteEmergencyContacts",
          body: body,
        ).then((responseData) {
          if (responseData.Data != 0) {
            print(responseData.Data);
            widget.GetEmergencyApi();
            Fluttertoast.showToast(msg: "Emergency Deleted Successfully", backgroundColor: Colors.green,
              // backgroundColor: Color(0xFFFF4F4F),
              textColor: Colors.white,
              gravity:ToastGravity.TOP,);
            setState(() {
              isDeleteLoading = false;
            });
          } else {
            print(responseData);
            setState(() {
              isDeleteLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${responseData.Message}",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
            );
          }
        }).catchError((error) {
          setState(() {
            isDeleteLoading = false;
          });
          Fluttertoast.showToast(
            msg: "Error $error",
            backgroundColor: Colors.white,
            textColor: appPrimaryMaterialColor,
          );
        });
      }
    } catch (e) {
      setState(() {
        isDeleteLoading = false;
      });
      Fluttertoast.showToast(
        msg: "You aren't connected to the Internet !",
        backgroundColor: Colors.white,
        textColor: appPrimaryMaterialColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
      child: Stack(
        children: [
          Card(
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
                    padding: const EdgeInsets.only(left: 7),
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      // : Image.network(api_url +
                      //     "${widget.visitorData['visitorImage']}",),
                      decoration: new BoxDecoration(
                        color: Color(0x22888888),
                        image: DecorationImage(
                          image: NetworkImage(API_URL +
                              "${widget.allEmergencyList['image']}"),
                          fit: BoxFit.fill,
                        ),
                        borderRadius:
                        new BorderRadius.all(new Radius.circular(10.0)),
                        border: new Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 7.0),
                  //   child: Image.asset(
                  //     "images/policeman.png",
                  //     width: 60,
                  //   ),
                  // ),
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
                          Text(widget.allEmergencyList["contactName"],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(widget.allEmergencyList["contactNo"],
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: UpdateEmergencyScreen(
                                      emergencyData: widget.allEmergencyList,
                                      GetData: () {
                                        widget.GetEmergencyApi();
                                      },
                                    ),
                                    type: PageTransitionType.fade));
                            setState(() {});
                          },
                          child: Icon(
                            Icons.edit,
                            size: 21,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Container(
                          width: 1,
                          height: 30,
                          color: Colors.black12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            _deleteEmergency();
                          },
                          child: Icon(
                            Icons.delete,
                            size: 22,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          isDeleteLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        appPrimaryMaterialColor),
                    //backgroundColor: Colors.white54,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
