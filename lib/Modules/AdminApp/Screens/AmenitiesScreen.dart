import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AmenitiesDetailScreen.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Screens/AddNewAmenities.dart';

class AmenitiesScreen extends StatefulWidget {
  @override
  _AmenitiesScreenState createState() => _AmenitiesScreenState();
}

class _AmenitiesScreenState extends State<AmenitiesScreen> {
  bool isLoading = false;

  List amenitiesList = [];

  @override
  void initState() {
    _getAllAmenities();
  }

  _getAllAmenities() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "societyId": sharedPrefs.societyId,
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/getAllSocietyAmeties", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            amenitiesList = responseData.Data;
            print("$amenitiesList");
            setState(() {
              isLoading = false;
            });
          } else {
           print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                backgroundColor: Colors.white,
                textColor: appPrimaryMaterialColor,
                );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
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
        isLoading = false;
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Amenities",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Stack(
        children: [
          isLoading
              ? Center(
            child: CircularProgressIndicator(
              valueColor:
              new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
            ),
          )
              : ListView.builder(
            itemCount: amenitiesList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(
                right: 5,
                left: 5,
              ),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         child: DailyHelperSubScreen(),
                  //         type: PageTransitionType.rightToLeft));
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) => ShowDialog());
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    API_URL+amenitiesList[index]["images"][0],
                                    // "https://graphicsfamily.com/wp-content/uploads/edd/2020/11/Tasty-Food-Web-Banner-Design-scaled.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    amenitiesList[index]["amenityName"],
                                    style: TextStyle(
                                        color: appPrimaryMaterialColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    amenitiesList[index]["location"]
                                    ["completeAddress"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: SizedBox(
                                      width: 100,
                                      height: 35,
                                      child: RaisedButton(
                                        child: Text("View More",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        color: appPrimaryMaterialColor,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child:
                                                  AmenitiesDetailScreen(
                                                    amenitiesListData:
                                                    amenitiesList[index],
                                                  ),
                                                  type: PageTransitionType
                                                      .rightToLeft));
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 10,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: AddNewAmenities(
                          AllAmenitiesApi: (){
                            _getAllAmenities();
                          },
                        ),
                        type: PageTransitionType.rightToLeft));
              },
              icon: Icon(Icons.add),
              label: Text("Add New Amenity"),
            ),
          ),
        ],
      )

    );
  }
}
