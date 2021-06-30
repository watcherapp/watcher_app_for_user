import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dotted_border/dotted_border.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/BottomNavigationBarCustom.dart';

class StaffGetPass extends StatefulWidget {
  var myStaffData;

  StaffGetPass({
    this.myStaffData,
  });

  @override
  _StaffGetPassState createState() => _StaffGetPassState();
}

class _StaffGetPassState extends State<StaffGetPass> {
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

  Future<void> _shareImage(Uint8List image) async {
    try {
      await Share.file('esys image', 'esys.png', image, 'image/png',
          text: "Gate Pass");
    } catch (e) {
      print('error: $e');
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
          centerTitle: true,
          elevation: 0,
          backgroundColor: appPrimaryMaterialColor,
        ),
        body: RepaintBoundary(
          key: _containerKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: appPrimaryMaterialColor,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterTicketWidget(
                      isCornerRounded: true,
                      width: MediaQuery.of(context).size.width,
                      height: 510,
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "GATE PASS",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: appPrimaryMaterialColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 1,
                                  color: Colors.grey[200],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                QrImage(
                                  data: '${widget.myStaffData["entryNo"]}',
                                  version: 1,
                                  size: 150,
                                  gapless: false,
                                  errorStateBuilder: (cxt, err) {
                                    return Container(
                                      child: Center(
                                        child: Text(
                                          "Uh oh! Something went wrong...",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DottedBorder(
                                    dashPattern: [4],
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      "${widget.myStaffData["entryNo"]}",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: appPrimaryMaterialColor,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 3),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text:
                                        "${widget.myStaffData["firstName"]}  ${widget.myStaffData["lastName"]}\n ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: appPrimaryMaterialColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                    children: [
                                      TextSpan(
                                          text:
                                              '${widget.myStaffData["StaffCategoryIs"][0]["staffCategoryName"]}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Montserrat')),
                                    ],
                                  ),
                                ),
                                // Divider(
                                //   endIndent: 10,
                                //   indent: 10,
                                // ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Row(
                                  //   mainAxisAlignment:
                                  //   MainAxisAlignment.spaceAround,
                                  //   children: [
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //       CrossAxisAlignment.center,
                                  //       children: [
                                  //         Text("Valid From",
                                  //             style: fontConstants.labelFonts),
                                  //         Text(
                                  //           "${widget.myStaffData["validFrom"]}",
                                  //           style: fontConstants.valueFonts,
                                  //         ),
                                  //         Text(
                                  //           "12 AM",
                                  //           style: fontConstants.activeFonts,
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //       CrossAxisAlignment.center,
                                  //       children: [
                                  //         Text("Valid to",
                                  //             style: fontConstants.labelFonts),
                                  //         Text(
                                  //           "${widget.myStaffData["validTo"]}",
                                  //           style: fontConstants.valueFonts,
                                  //         ),
                                  //         Text(
                                  //           "12 AM",
                                  //           style: fontConstants.activeFonts,
                                  //         ),
                                  //       ],
                                  //     )
                                  //   ],
                                  // ),
                                  Image.asset(
                                    "images/Watcherlogo.png",
                                    width: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: "Please show this",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontFamily: 'Montserrat'),
                                        children: [
                                          TextSpan(
                                              text: " QR Code ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                            text:
                                                "to Security Guard at the Society Gate for hassle free entry",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      highlightedBorderColor: Colors.white,
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                      onPressed: () {
                        convertWidgetToImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share_sharp,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Share",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}

class FlutterTicketWidget extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;
  final Color color;
  final bool isCornerRounded;

  FlutterTicketWidget(
      {@required this.width,
      @required this.height,
      @required this.child,
      this.color = Colors.white,
      this.isCornerRounded = false});

  @override
  _FlutterTicketWidgetState createState() => _FlutterTicketWidgetState();
}

class _FlutterTicketWidgetState extends State<FlutterTicketWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: AnimatedContainer(
        duration: Duration(seconds: 3),
        width: widget.width,
        height: widget.height,
        child: widget.child,
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: widget.isCornerRounded
                ? BorderRadius.circular(12.0)
                : BorderRadius.circular(0.0)),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height / 1.5), radius: 20.0));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 1.5), radius: 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
