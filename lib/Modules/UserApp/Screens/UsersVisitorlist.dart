import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/VisitorComponent.dart';
import 'package:watcher_app_for_user/CommonWidgets/MySearchField.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/InviteGuest.dart';

class UserVisitorList extends StatefulWidget {
  @override
  _UserVisitorListState createState() => _UserVisitorListState();
}

class _UserVisitorListState extends State<UserVisitorList> {
  Future<void> getReport() async {
    print("Refresh");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: RefreshIndicator(
          onRefresh: () {
            return getReport();
          },
          child: Column(
            children: [
              MySearchField(
                icon: Icon(
                  Icons.search_rounded,
                  color: appPrimaryMaterialColor,
                  size: 20,
                ),
                hintText: "Search",
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5,top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            PageTransition(
                                child: InviteGuest(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                           // color: Colors.white,
                            border: Border.all(
                              color: appPrimaryMaterialColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline_sharp,
                                size: 16,
                                color: appPrimaryMaterialColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:4.0,right: 3),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: appPrimaryMaterialColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 10,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return VisitorComponent();
                    },
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
