import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/CreateNewSociety.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/EnterSocietyCodeScreen.dart';

class ChooseCreateOrJoin extends StatefulWidget {
  @override
  _ChooseCreateOrJoinState createState() => _ChooseCreateOrJoinState();
}

class _ChooseCreateOrJoinState extends State<ChooseCreateOrJoin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watcher"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  children: [
                    SizedBox(
                      height: 75,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            color: appPrimaryMaterialColor,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: EnterSocietyCode(),
                                      type: PageTransitionType.rightToLeft));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Join Your Society",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
                      child: Text("Get Your Joining Code From Your Admin",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(height: 15),
          sharedPrefs.userRole == 2
              ? SizedBox()
              : Column(
                  children: [
                    Text("OR"),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 75,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            color: appPrimaryMaterialColor,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: CreateNewSociety(),
                                      type: PageTransitionType.rightToLeft));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.apartment,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Create New Society",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
