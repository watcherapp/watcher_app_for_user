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
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

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
  List<MultipartFile> multipartFile =[];
  MultipartFile multipartFile1;


  //old function which is not working............................
  _addNewAmenity() async {
    try {
      setState(() {
        isLoading = true;
      });
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {

        List<MultipartFile> imageList = <MultipartFile>[];
        for (Asset asset in images) {
          ByteData byteData = await asset.getByteData();
          List<int> imageData = byteData.buffer.asUint8List();
          MultipartFile multipartFile = new MultipartFile.fromBytes(
            imageData,
            filename: 'load_image',
            contentType: MediaType("image", "jpg"),
          );
          imageList.add(multipartFile);
        }

        FormData formData = FormData.fromMap({
          "images": imageList,
          "societyId": "${sharedPrefs.societyId}",
          "amenityName": txtName.text,
          "description": txtDiscription.text,
          "completeAddress": txtAddress.text,
        });
        Services.responseHandler(
            apiName: "api/society/addSocietyAmenity", body: formData)
            .then((responseData) {
          print("ss");
          if (responseData.Data.length != 0) {
            print("sss");
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

  //working function.................................
  _addNewAmenity2() async {
    String url =
        "https://watcher03.herokuapp.com/api/society/addSocietyAmenity";
    List<MultipartFile> imageList = <MultipartFile>[];

    // for (int i = 0; i < images.length; i++) {
    //     ByteData byteData = await images[i].getByteData();
    //     List<int> imageData = byteData.buffer.asUint8List();
    //     File _imageEvent = await File(images[i].identifier);
    //     MultipartFile multipartFile = new MultipartFile.fromBytes(
    //       imageData,
    //       filename: images[i].name,
    //       contentType: MediaType("image", "png"),
    //     );
    //     imageList.add(multipartFile);
    // }

    for (Asset asset in images) {
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = new MultipartFile.fromBytes(
        imageData,
        filename: asset.name,
        contentType: MediaType("image", "png"),
      );
      imageList.add(multipartFile);
    }
    print(imageList);
    FormData formData = FormData.fromMap({
      "images": imageList,
      "societyId": societyId,
      "amenityName": txtName.text,
      "description": txtDiscription.text,
      "completeAddress": txtAddress.text,
    });

    Dio dio = new Dio();
    dio.options.headers["authorization"] =
    "RvHiQ6J4QJoAMeA0ysCw-HJklmBHklmnknNJn-hghJUdksjH";
    var response = await dio.post(url, data: formData);
    widget.AllAmenitiesApi();
    Fluttertoast.showToast(
      msg: "Your Amenities added Successfully.",
    );
    Navigator.pop(context);
    print(response.data);
    // }
  }


  List<Asset> images = <Asset>[];
  String _error = 'No Error Detected';

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
                            child: buildGridView()),
                      ),
                    ),
                  ),
                  MyButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // _apiCall();
                        _addNewAmenity2();
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


// _addNewAmenity() async {
//   for (int i = 0; i < images.length; i++) {
//     String filename = "";
//     String filePath = "";
//     File compressedFile;
//     File _imageEvent = await File(images[i].identifier);
//     print("${_imageEvent.path}");
//       print(_imageEvent);
//       filename = _imageEvent.path.split('/').last;
//       filePath = _imageEvent.path;
//       print(filePath);
//
//     multipartFile.add((filePath != null && filePath != '')
//         ? await MultipartFile.fromFile(filePath,
//         filename: filename.toString())
//         : null);
//   }
// }

// _addNewAmenity() async {
//   try {
//     setState(() {
//       isLoading = true;
//     });
//     final internetResult = await InternetAddress.lookup('google.com');
//     if (internetResult.isNotEmpty &&
//         internetResult[0].rawAddress.isNotEmpty) {
//
//       for (int i = 0; i < images.length; i++) {
//         ByteData byteData = await images[i].getByteData();
//         List<int> imageData = byteData.buffer.asUint8List();
//         // File _imageEvent = await File(images[i].identifier);
//         multipartFile1 = MultipartFile.fromBytes(
//           imageData,
//           filename: images[i].name,
//           // contentType: MediaType("image", "jpeg"),
//         );
//         print(images.length);
//         multipartFile.add(multipartFile1);
//         //TODO:Temporary
//         // multipartFile.add(
//         //     await MultipartFile.fromFile(_imageEvent.path,
//         //         filename: _imageEvent.path.split("/").last));
//       }
//
//
//       // for (Asset asset in images) {
//       //   ByteData byteData = await asset.getByteData();
//       //   List<int> imageData = byteData.buffer.asUint8List();
//       //   multipartFile1 = MultipartFile.fromBytes(
//       //     imageData,
//       //     filename: asset.name,
//       //     // contentType: MediaType("image", "jpeg"),
//       //   );
//       //   multipartFile.add(multipartFile1);
//       // }
//       print("--------------->${multipartFile}");
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
// _addNewAmenity() async {
//   try {
//     setState(() {
//       isLoading = true;
//     });
//     final internetResult = await InternetAddress.lookup('google.com');
//     if (internetResult.isNotEmpty &&
//         internetResult[0].rawAddress.isNotEmpty) {
//       print(images.length);
//       for (var i = 0; i < images.length; i++) {
//         // Get ByteData
//         print(i);
//         ByteData byteData = await images[i].getByteData();
//         List<int> imageData = byteData.buffer.asUint8List();
//         File _imageEvent = await File(images[i].identifier);
//         print("s");
//         print("ss");
//         print(multipartFile1.filename);
//         // multipartFile = (await MultipartFile.fromFile(_imageEvent.path, filename: images[i].name)) as List<MultipartFile>;
//
//         // multipartFile.add(MultipartFile.fromBytes(
//         //   _imageEvent.path,
//         //   filename: images[i].name,
//         //   contentType: MediaType("image", "jpg"),
//         // ));
//
//         // multipartFile.add(MultipartFile.fromFile(
//         //   _imageEvent.path,
//         // ));
//       }
//       // log(multipartFile.toString());
//       print("sss");
//         var data = {
//           "societyId": societyId,
//           "amenityName": txtName.text,
//           "description": txtDiscription.text,
//           "completeAddress": txtAddress.text,
//           "images": multipartFile,
//         };
//         FormData formData = FormData.fromMap(data);
//       print("ssss");
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
// _cddNewAmenity() async {
//   try {
//     setState(() {
//       isLoading = true;
//     });
//     final internetResult = await InternetAddress.lookup('google.com');
//     if (internetResult.isNotEmpty &&
//         internetResult[0].rawAddress.isNotEmpty) {
//
//       print(images.length);
//       List<MultipartFile> imageList = <MultipartFile>[];
//       for (Asset asset in images) {
//         ByteData byteData = await asset.getByteData();
//         List<int> imageData = byteData.buffer.asUint8List();
//         MultipartFile multipartFile = new MultipartFile.fromBytes(
//           imageData,
//           filename: 'load_image',
//           contentType: MediaType("image", "jpg"),
//         );
//         imageList.add(multipartFile);
//       }
//
//         FormData formData = FormData.fromMap({
//           "societyId": societyId,
//           "amenityName": txtName.text,
//           "description": txtDiscription.text,
//           "completeAddress": txtAddress.text,
//           "images": imageList,
//         });
//       print("ssss");
//       Services.responseHandler(
//           apiName: "api/society/addSocietyAmenity", body: formData)
//           .then((responseData) {
//         if (responseData.Data.length > 0) {
//           print(responseData.Data);
//           // widget.AllAmenitiesApi();
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
