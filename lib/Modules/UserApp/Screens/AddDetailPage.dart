import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:esys_flutter_share/esys_flutter_share.dart' as S;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dotted_border/dotted_border.dart';
/*import '../common/constant.dart' as cnst;
import 'package:carousel_slider/carousel_slider.dart';*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';
/*import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';*/
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*import 'package:smart_society_new/Member_App/common/Services.dart';
import 'package:smart_society_new/Member_App/common/constant.dart';
import 'package:smart_society_new/Member_App/common/constant.dart' as constant;
import 'package:smart_society_new/Member_App/screens/ViewProducts.dart';*/
import 'package:url_launcher/url_launcher.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/BottomNavigationBarCustom.dart';
/*import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:smart_society_new/Member_App/common/constant.dart' as cnst;
import 'package:dotted_decoration/dotted_decoration.dart';*/

class AddDetailPage extends StatefulWidget {
  var data;
  var index;

  AddDetailPage({this.data, this.index});

  @override
  _AddDetailPageState createState() => _AddDetailPageState();
}

class _AddDetailPageState extends State<AddDetailPage> {


  String _playerStatus = '';

  bool _isPlayerReady = false;



  String memberid, qrData, advertisementid, WebURL, YoutubeURL;
  var Price;

  List WishList = [];
  List details = [];
  bool isLoading = true;

  bool flag = false;
  bool wishliststatus;

  @override
  void initState() {



  }

  showMsg(String msg, {String title = 'MYJINI'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                ;
              },
            ),
          ],
        );
      },
    );
  }

/*
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }
*/

  String setDate(String date) {
    String final_date = "";
    var tempDate;
    if (date != "" || date != null) {
      tempDate = date.toString().split("-");
      if (tempDate[2].toString().length == 1) {
        tempDate[2] = "0" + tempDate[2].toString();
      }
      if (tempDate[1].toString().length == 1) {
        tempDate[1] = "0" + tempDate[1].toString();
      }
      final_date = "${tempDate[2].toString().substring(0, 2)}-"
          "${tempDate[1].toString().substring(0, 2)}-${tempDate[0].toString()}"
          .toString();
    }
    return final_date;
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchWebsiteURL() async {
    if (await canLaunch(WebURL)) {
      await launch(WebURL);
    } else {
      throw 'Could not launch $WebURL';
    }
  }

  _launchYoutubeURL() async {
    if (await canLaunch(YoutubeURL)) {
      await launch(YoutubeURL);
    } else {
      throw 'Could not launch $YoutubeURL';
    }
  }

/*
  _openWhatsapp(mobile) {
    String whatsAppLink = constant.whatsAppLink;
    String urlwithmobile = whatsAppLink.replaceAll("#mobile", "91$mobile");
    String urlwithmsg = urlwithmobile.replaceAll("#msg", "");
    launch(urlwithmsg);
  }
*/





  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  GlobalKey _containerKey = GlobalKey();

  void convertWidgetToImage() async {
    RenderRepaintBoundary renderRepaintBoundary =
    _containerKey.currentContext.findRenderObject();
    ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 5);
    ByteData byteData =
    await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uInt8List = byteData.buffer.asUint8List();
    _shareImage(uInt8List);
  }

  String val = "";
  Future<void> _shareImage(Uint8List image) async {
    val = "";
    for(int i=0;i<details.length;i++){
      val +="${details[i]}\n";
    }
    try {
      await S.Share.file('esys image', 'esys.png', image, 'image/png',
          text: "${widget.data["Title"]}"
              "\n${widget.data["Description"]}\n${val}");
    } catch (e) {
      print('error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    print("widget.data");
    print(widget.data);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  RepaintBoundary(
                    key: _containerKey,
                    child: FadeInImage.assetNetwork(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.218,
                        fit: BoxFit.fill,
                        placeholder: "images/ad-campaign.png",
                        image: widget.data),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // GestureDetector(
                        //   onTap: () {
                        //     // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     //     '/HomeScreen', (Route<dynamic> route) => false);
                        //     Navigator.pop(context);
                        //   },
                        //   child: Icon(
                        //     Icons.arrow_back_ios,
                        //     color: Colors.white,
                        //     size: 20,
                        //   ),
                        // ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     '/HomeScreen', (Route<dynamic> route) => false);
                            Navigator.pop(context);
                          },
                        ),
                        /* GestureDetector(
                          onTap: (){
                            setState(() {
                              flag=!flag;
                            });
                          },
                          child: flag==true?Icon(
                            Icons.bookmark,
                            size: 25,
                            color: Color(0xFF8B0000),
                          ):
                          Icon(
                            Icons.bookmark_border,
                            size: 25,
                            color: Colors.grey[400],
                          ),
                        ),*/
                        GestureDetector(
                          onTap: () {
                            // Share.share('Check out this exclusive AD \n' +
                            //     "${cnst.Image_Url}" +
                            //     widget.data["Image"][0]);
                            convertWidgetToImage();
                          },
                          child: Icon(
                            Icons.share,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Web Banner ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // widget.data["Price"] == null ||
                        //         widget.data["Price"] == ""
                        //     ? Padding(
                        //         padding: const EdgeInsets.only(left: 8.0),
                        //         child: Text(
                        //           constant.Inr_Rupee + " 0.0",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.w500,
                        //               fontSize: 18,
                        //               color: Colors.green),
                        //         ),
                        //       )
                        //     : Padding(
                        //         padding: const EdgeInsets.only(left: 8.0),
                        //         child: Text(
                        //           constant.Inr_Rupee +
                        //               " ${widget.data["Price"]}",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.w500,
                        //               fontSize: 18,
                        //               color: Colors.green),
                        //         ),
                        //       ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Delicious Food",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // Expanded(
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 8.0),
                        //     child: Text(
                        //       "${widget.data["type"]}",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w500, fontSize: 16),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 5,
//                             child: GestureDetector(
//                               onTap: () {
//                                 /*setState(() {
//                                   flag != flag;
//                                 });
//                                 _addToWishList();*/
//
//                                 if (wishliststatus != true) {
//                                   _addToWishList();
//                                 } else {
//                                   _wishListDelete();
//                                 }
//
// /*
//                                 if(WishList[0]["Status"]=="Added"){
//                                   _wishListUpdate();
//                                 }
//                                 else{
//                                   _addToWishList();
//
//                                 }*/
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     wishliststatus == true
//                                         //flag == true
//                                         ? Icon(
//                                             Icons.bookmark,
//                                             size: 25,
//                                             color: Color(0xFF8B0000),
//                                           )
//                                         : Icon(
//                                             Icons.bookmark_border,
//                                             size: 25,
//                                             color: Colors.grey[400],
//                                           ),
//                                     Padding(
//                                       padding: EdgeInsets.only(left: 8.0),
//                                     ),
//                                     Text(
//                                       "Add to wishlist",
//                                       style: TextStyle(fontSize: 15),
//                                     )
//                                   ],
//                                 ),
//                                 height: 35,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 5,
//                             child: GestureDetector(
//                               onTap: () {
//                                 /* String withappurl = withrefercode.replaceAll("#appurl", cnst.playstoreUrl);
//                                 Share.share(withappurl);*/
//                                 Share.share('Check out this exclusive AD \n' +
//                                     "${cnst.Image_Url}" +
//                                     widget.data["image"]);
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.share,
//                                       size: 25,
//                                       color: Colors.grey[400],
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(left: 8.0),
//                                     ),
//                                     Text(
//                                       "Share this deal",
//                                       style: TextStyle(fontSize: 15),
//                                     )
//                                   ],
//                                 ),
//                                 height: 35,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
                  ],
                ),
              ),
              // Card(
              //   child: ExpansionTile(
              //     title: Text(
              //       "Redeem Bill Date",
              //       style: TextStyle(
              //           fontSize: 18,
              //           fontWeight: FontWeight.w500,
              //           color: Colors.black),
              //     ),
              //     children: <Widget>[
              //       Padding(
              //         padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: <Widget>[
              //             //here
              //             Text(
              //               "Expiry Date - ${setDate(widget.data["ExpiryDate"])}",
              //               style: TextStyle(
              //                 fontSize: 15,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Card(
                child: ExpansionTile(
                  title: Text(
                    "Location",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                               Expanded(
                                child: Text(
                                  "hello",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                // if (widget.data["AdvertiserLocation"] == "" ||
                                //     widget.data["AdvertiserLocation"] == null) {
                                //   Fluttertoast.showToast(
                                //       msg: "Location not available!!!",
                                //       toastLength: Toast.LENGTH_SHORT);
                                // } else {
                                //   var latlong = widget
                                //       .data["AdvertiserLocation"]
                                //       .toString()
                                //       .split(",");
                                //   openMap(double.parse(latlong[0]),
                                //       double.parse(latlong[1]));
                                // }
                                // print("LAT-LONG == >>>" +
                                //     widget.data["AdvertiserLocation"]
                                //         .toString());
                                launch('${widget.data["GoogleMap"]}');
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 15.0),
                                      child: Icon(
                                        Icons.location_on,
                                        size: 25,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                    ),
                                    Text(
                                      "Get direction",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blue),
                                    )
                                  ],
                                ),
                                height: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                       GestureDetector(
                        onTap: () {

                        },
                        child: Image.asset(
                          "images/mail.png",
                          color: appPrimaryMaterialColor,
                          height: 32,
                          width: 32,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Image.asset(
                          "images/internet.png",
                          color: appPrimaryMaterialColor,
                          height: 32,
                          width: 32,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Image.asset(
                          "images/youtube.png",
                          color: appPrimaryMaterialColor,
                          height: 32,
                          width: 32,
                        ),
                      ),
                       GestureDetector(
                        onTap: () {

                        },
                        child: IconButton(
                          icon: Icon(
                            Icons.call_outlined,
                            color: appPrimaryMaterialColor,
                            size: 28,
                          ),
                          onPressed: () {
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10, right: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 35,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            textColor: Colors.white,
                            splashColor: Colors.white,
                            child: Text("Place Enquiry",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            onPressed: () {
                              _settingModalBottomSheet(context, qrData,widget.data["_id"]);
                            }),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(right: 5),
                    // ),
                    // Expanded(
                    //   flex: 5,
                    //   child: SizedBox(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 35,
                    //     child: RaisedButton(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10)),
                    //         color: constant.appPrimaryMaterialColor,
                    //         textColor: Colors.white,
                    //         splashColor: Colors.white,
                    //         child: Text("Services",
                    //             style: TextStyle(
                    //                 fontSize: 18, fontWeight: FontWeight.w600)),
                    //         onPressed: () {
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) =>
                    //                       ViewProducts(widget.data)));
                    //         }),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}

TextEditingController messageToWatchmanController = TextEditingController();


void _settingModalBottomSheet(context, String qr,String Id) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  // decoration: DottedDecoration(
                  //   shape: Shape.box,
                  //   borderRadius: BorderRadius.circular(5),
                  // ),
                  child: TextFormField(
                    controller: messageToWatchmanController,
                    keyboardType: TextInputType.text,
                    maxLines: 6,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Start typing here ...",
                      contentPadding: EdgeInsets.only(
                        left: 10,
                        top: 5,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: FlatButton(
                  color: Colors.purple,
                  child: Text('Send',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                  },
                ),
              ),
            ],
          ),
        );
      });
}