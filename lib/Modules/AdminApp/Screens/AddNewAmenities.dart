import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class AddNewAmenities extends StatefulWidget {
  Function AllAmenitiesApi;

  AddNewAmenities({
    this.AllAmenitiesApi,
  });

  @override
  _AddNewAmenitiesState createState() => _AddNewAmenitiesState();
}

class _AddNewAmenitiesState extends State<AddNewAmenities> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtDiscription = new TextEditingController();
  TextEditingController txtAddress = new TextEditingController();

  bool isLoading = false;

  // List multipartFile=[];
  List<MultipartFile> multipartFile = new List<MultipartFile>();
  MultipartFile multipartFile1;

  // _addNewAmenity() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     final internetResult = await InternetAddress.lookup('google.com');
  //     if (internetResult.isNotEmpty &&
  //         internetResult[0].rawAddress.isNotEmpty) {
  //       // String fileName = images.path.split('/').last;
  //
  //       List<MultipartFile> multipartImageList = new List<MultipartFile>();
  //       if (null != images) {
  //         for (Asset asset in images) {
  //           ByteData byteData = await asset.getByteData();
  //           List<int> imageData = byteData.buffer.asUint8List();
  //           MultipartFile multipartFile = new MultipartFile.fromBytes(
  //             imageData,
  //             filename: 'amenities_image',
  //           );
  //           multipartImageList.add(multipartFile);
  //         }
  //       }
  //       FormData formData = FormData.fromMap({
  //         "societyId": societyId,
  //         "amenityName": txtName.text,
  //         "description": txtDiscription.text,
  //         "completeAddress": txtAddress.text,
  //         "images": multipartImageList,
  //         // "images": await MultipartFile.fromFile(
  //         //   images.path,
  //         //   filename: fileName,
  //         // ),
  //       });
  //       print("$formData");
  //       Services.responseHandler(
  //               apiName: "api/society/addSocietyAmenity", body: formData)
  //           .then((responseData) {
  //         if (responseData.Data.length > 0) {
  //           print(responseData.Data);
  //           widget.AllAmenitiesApi();
  //           Fluttertoast.showToast(
  //             msg: "Your Notice added Successfully.",
  //           );
  //           Navigator.pop(context);
  //           setState(() {
  //             isLoading = false;
  //           });
  //         } else {
  //           print(responseData);
  //           setState(() {
  //             isLoading = false;
  //           });
  //           Fluttertoast.showToast(
  //             msg: "${responseData.Message}",
  //             backgroundColor: Colors.white,
  //             textColor: appPrimaryMaterialColor,
  //           );
  //         }
  //       }).catchError((error) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         Fluttertoast.showToast(
  //           msg: "Error $error",
  //           backgroundColor: Colors.white,
  //           textColor: appPrimaryMaterialColor,
  //         );
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(
  //       msg: "You aren't connected to the Internet !",
  //       backgroundColor: Colors.white,
  //       textColor: appPrimaryMaterialColor,
  //     );
  //   }
  // }
  //
  // _gddNewAmenity() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     final internetResult = await InternetAddress.lookup('google.com');
  //     if (internetResult.isNotEmpty &&
  //         internetResult[0].rawAddress.isNotEmpty) {
  //       for (int i = 0; i < images.length; i++) {
  //         ByteData byteData = await images[i].getByteData();
  //         List<int> imageData = byteData.buffer.asUint8List();
  //         multipartFile1 = MultipartFile.fromBytes(
  //           imageData,
  //           filename: images[i].name,
  //           // contentType: MediaType("image", "jpeg"),
  //         );
  //         multipartFile.add(multipartFile1);
  //       }
  //       print(multipartFile);
  //       var data = {
  //         "societyId": societyId,
  //         "amenityName": txtName.text,
  //         "description": txtDiscription.text,
  //         "completeAddress": txtAddress.text,
  //         "images": multipartFile,
  //       };
  //       // print(data);
  //       FormData formData = new FormData.fromMap(data);
  //       Services.responseHandler(
  //           apiName: "api/society/addSocietyAmenity", body: formData)
  //           .then((responseData) {
  //         if (responseData.Data.length > 0) {
  //           print(responseData.Data);
  //           widget.AllAmenitiesApi();
  //           Fluttertoast.showToast(
  //             msg: "Your Notice added Successfully.",
  //           );
  //           Navigator.pop(context);
  //           setState(() {
  //             isLoading = false;
  //           });
  //         } else {
  //           print(responseData);
  //           setState(() {
  //             isLoading = false;
  //           });
  //           Fluttertoast.showToast(
  //             msg: "${responseData.Message}",
  //             backgroundColor: Colors.white,
  //             textColor: appPrimaryMaterialColor,
  //           );
  //         }
  //       }).catchError((error) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         Fluttertoast.showToast(
  //           msg: "Error $error",
  //           backgroundColor: Colors.white,
  //           textColor: appPrimaryMaterialColor,
  //         );
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(
  //       msg: "You aren't connected to the Internet !",
  //       backgroundColor: Colors.white,
  //       textColor: appPrimaryMaterialColor,
  //     );
  //   }
  // }
  _addNewAmenity() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        // for (int i = 0; i < images.length; i++) {
        //   ByteData byteData = await images[i].getByteData();
        //   List<int> imageData = byteData.buffer.asUint8List();
        //   multipartFile1 = MultipartFile.fromBytes(
        //     imageData,
        //     filename: images[i].name,
        //     // contentType: MediaType("image", "jpeg"),
        //   );
        //   multipartFile.add(multipartFile1);
        // }

        for (Asset asset in images) {
          ByteData byteData = await asset.getByteData();
          List<int> imageData = byteData.buffer.asUint8List();
          multipartFile1 = MultipartFile.fromBytes(
            imageData,
            filename: asset.name,
            // contentType: MediaType("image", "jpeg"),
          );
          multipartFile.add(multipartFile1);
        }
        print("--------------->${multipartFile.toString()}");
        var data = {
          "societyId": societyId,
          "amenityName": txtName.text,
          "description": txtDiscription.text,
          "completeAddress": txtAddress.text,
          "images": multipartFile,
        };
        // print(data);
        FormData formData = new FormData.fromMap(data);
        Services.responseHandler(
                apiName: "api/society/addSocietyAmenity", body: formData)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            widget.AllAmenitiesApi();
            Fluttertoast.showToast(
              msg: "Your Notice added Successfully.",
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

  // _uploadImages() async {
  //   setState(() {
  //     isLoading = false;
  //   });
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       print("MEMBER IDDDDDDDDDDDDDDDDDDDDDDDDDDDDD" +
  //           prefs.getString(cnst.Session.MemberId).toString());
  //       var data;
  //       print("images");
  //       print(images);
  //       String img = '';
  //
  //       for (int i = 0; i < images.length; i++) {
  //         ByteData byteData = await images[i].getByteData();
  //         List<int> imageData = byteData.buffer.asUint8List();
  //         MultipartFile multipartFile = MultipartFile.fromBytes(
  //           imageData,
  //           filename: images[i].name,
  //         );
  //         data = {
  //           "memberid": prefs.getString(cnst.Session.MemberId),
  //           "images": multipartFile,
  //         };
  //         // print(data);
  //         FormData formData = new FormData.fromMap(data);
  //         Services.PostForList4(api_name: 'card/addimages', body: formData)
  //             .then((data) async {
  //           print(
  //               "==================================================IMAGE UPLOAD SUCCESSFULLY==================================================");
  //           setState(() {
  //             isLoading = false;
  //           });
  //         }, onError: (e) {
  //           print(e.toString());
  //           showMsg("Try Again");
  //         });
  //       }
  //     }
  //   } on SocketException catch (_) {
  //     //pr.hide();
  //     showMsg("No Internet Connection.");
  //   }
  // }

  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "My Watcher",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
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
          "Add New Amenity",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFormField(
                    controller: txtName,
                    lable: "Amenity Name",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Amenity Name";
                      }
                      return null;
                    },
                    hintText: "Type Amenity Name",
                  ),
                  MyTextFormField(
                    controller: txtDiscription,
                    lable: "Amenity Description",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Amenity Description";
                      }
                      return null;
                    },
                    hintText: "Type Amenity Description",
                  ),
                  MyTextFormField(
                    controller: txtAddress,
                    lable: "Amenity Address",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Amenity Address";
                      }
                      return null;
                    },
                    hintText: "Type Amenity Address",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: GestureDetector(
                      onTap: loadAssets,
                      child: Container(
                        height: 200,
                        child: DottedBorder(
                            color: Colors.grey,
                            dashPattern: [4],
                            padding: EdgeInsets.all(6.0),
                            child:
                                // images == null
                                //     ? GestureDetector(
                                //         onTap: loadAssets,
                                //         child: Center(
                                //           child: Column(
                                //             mainAxisAlignment: MainAxisAlignment.center,
                                //             children: [
                                //               Image.asset("images/id-card.png",
                                //                   color: Colors.grey[300],
                                //                   width: 40.0,
                                //                   height: 40.0),
                                //               Text(
                                //                 "Choose Image",
                                //                 style: TextStyle(
                                //                     color: Colors.grey,
                                //                     fontWeight: FontWeight.w500),
                                //               )
                                //             ],
                                //           ),
                                //         ),
                                //       )
                                //     :
                                buildGridView()),
                      ),
                    ),
                  ),
                  MyButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _addNewAmenity();
                      }
                    },
                    title: "Add New",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
