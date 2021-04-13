import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class AmenitiesDetailScreen extends StatefulWidget {
  var amenitiesListData;
  Function amenitiesApi;

  AmenitiesDetailScreen({
    this.amenitiesListData,
    this.amenitiesApi,
  });

  @override
  _AmenitiesDetailScreenState createState() => _AmenitiesDetailScreenState();
}

class _AmenitiesDetailScreenState extends State<AmenitiesDetailScreen> {
  bool isLoading = false;
  List images=[];


  @override
  void initState() {
    images = widget.amenitiesListData["images"];
    print(images);
  } // List amenitiesList = [];

  _deleteAmenities() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        print(sharedPrefs.societyId);
        print("${widget.amenitiesListData["_id"]}");
        var body = {
          "societyId": sharedPrefs.societyId,
          "amenityId": "${widget.amenitiesListData["_id"]}"
        };
        print("$body");
        Services.responseHandler(apiName: "api/society/deleteSocietyAmeties", body: body)
            .then((responseData) {
          if (responseData.Data == 1) {
            print(responseData.Data);
            widget.amenitiesApi();
            Fluttertoast.showToast(
              msg: "Your Notice deleted Successfully.",
            );
            Navigator.pop(context);
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

  // List bannerList = [
  //   "https://graphicsfamily.com/wp-content/uploads/edd/2020/11/Tasty-Food-Web-Banner-Design-scaled.jpg",
  //   "https://previews.customer.envatousercontent.com/files/219112782/preview%20image.JPG",
  //   "https://i.pinimg.com/originals/14/14/5f/14145f84d1f7dbceddf9f6ffd9995594.jpg"
  // ];

  // @override
  // void initState() {
  //   // _getAllAmenities();
  // }
  //
  // // _getAllAmenities() async {
  // //   try {
  // //     setState(() {
  // //       isLoading = true;
  // //     });
  // //     final internetResult = await InternetAddress.lookup('google.com');
  // //     if (internetResult.isNotEmpty &&
  // //         internetResult[0].rawAddress.isNotEmpty) {
  // //       var body = {"societyId": "6038838fd00ee22d24a09c7a"};
  // //       print("$body");
  // //       Services.responseHandler(
  // //               apiName: "api/society/getAllSocietyAmeties", body: body)
  // //           .then((responseData) {
  // //         if (responseData.Data.length > 0) {
  // //           amenitiesList = responseData.Data;
  // //           print(amenitiesList);
  // //           setState(() {
  // //             isLoading = false;
  // //           });
  // //         } else {
  // //           print(responseData);
  // //           Fluttertoast.showToast(
  // //               msg: "${responseData.Message}",
  // //               toastLength: Toast.LENGTH_SHORT,
  // //               gravity: ToastGravity.BOTTOM,
  // //               timeInSecForIosWeb: 1,
  // //               backgroundColor: Colors.red,
  // //               // textColor: Colors.white,
  // //               fontSize: 16.0);
  // //         }
  // //       }).catchError((error) {
  // //         setState(() {
  // //           isLoading = false;
  // //         });
  // //         Fluttertoast.showToast(
  // //             msg: "Error $error",
  // //             toastLength: Toast.LENGTH_SHORT,
  // //             gravity: ToastGravity.BOTTOM,
  // //             timeInSecForIosWeb: 1,
  // //             backgroundColor: Colors.red,
  // //             // textColor: Colors.white,
  // //             fontSize: 16.0);
  // //       });
  // //     }
  // //   } catch (e) {
  // //     setState(() {
  // //       isLoading = false;
  // //     });
  // //     Fluttertoast.showToast(
  // //         msg: "You aren't connected to the Internet !",
  // //         toastLength: Toast.LENGTH_SHORT,
  // //         gravity: ToastGravity.BOTTOM,
  // //         timeInSecForIosWeb: 1,
  // //         backgroundColor: Colors.red,
  // //         // textColor: Colors.white,
  // //         fontSize: 16.0);
  // //   }
  // // }

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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Carousel(
                        boxFit: BoxFit.cover,
                        autoplay: true,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(seconds: 1),
                        dotSize: 4.0,
                        dotIncreasedColor: appPrimaryMaterialColor,
                        dotBgColor: Colors.transparent,
                        dotPosition: DotPosition.bottomCenter,
                        dotVerticalPadding: 10.0,
                        showIndicator: true,
                        indicatorBgPadding: 7.0,
                        images: images
                            .map(
                              (item) => Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.network(
                                  "$API_URL"+"$item",
                                  fit: BoxFit.fitWidth,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                elevation: 2,
                                margin: EdgeInsets.all(4),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Text(
                      widget.amenitiesListData["amenityName"],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: appPrimaryMaterialColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Text(
                      widget.amenitiesListData["location"]["completeAddress"],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: Colors.grey,
                        // fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: appPrimaryMaterialColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      widget.amenitiesListData["description"],
                      // "This is too good Swimming pool,which has three part children pool,adults pool and also for swimmers pool which is biggest poool in the city.",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: Colors.grey,
                        // fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlineButton(
                        child: new Text(
                          "Delete Amenities",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          _deleteAmenities();
                        },
                        borderSide: BorderSide(color: Colors.red),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
