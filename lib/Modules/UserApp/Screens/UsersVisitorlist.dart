import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/VisitorComponent.dart';
import 'package:watcher_app_for_user/CommonWidgets/MySearchField.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/InviteGuest.dart';

class UserVisitorList extends StatefulWidget {
  @override
  _UserVisitorListState createState() => _UserVisitorListState();
}

class _UserVisitorListState extends State<UserVisitorList> {
  bool isLoading = false;
  List allGuestList=[];


  @override
  void initState() {
    _getAllvisitor();
  }

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
              isLoading==true?Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      appPrimaryMaterialColor),
                ),
              ): allGuestList.length>0?Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: allGuestList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return VisitorComponent(
                        visitorData: allGuestList[index],
                      );
                    },
                  ),
                ),
              ):Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "No Data Found...",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        //fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),

            ],
          ),
        ));
  }
  _getAllvisitor() async {
    try {
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {"memberId": sharedPrefs.memberId};
        log("MemberId ${sharedPrefs.memberId}");
        setState(() {
          isLoading = true;
        });
        Services.responseHandler(apiName: "api/member/getAllGuestList",body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            setState(() {
              allGuestList = responseData.Data;
              isLoading = false;
            });
            print(responseData.Data);
          } else {
            print(responseData);
            setState(() {
              allGuestList = responseData.Data;
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
}
