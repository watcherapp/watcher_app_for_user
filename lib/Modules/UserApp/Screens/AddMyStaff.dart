import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watcher_app_for_user/CommonWidgets/DialogOpenFormField.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Dialogs/MyDropdown.dart';

class AddMyStaff extends StatefulWidget {
  @override
  _AddMyStaffState createState() => _AddMyStaffState();
}

class _AddMyStaffState extends State<AddMyStaff> {
  String idProofData;
  List idProof = ["Aadharcard", "Pancard", "Votingcard"];
  File _staffProfile;
  File _image;
  File _imageId1;
  File _imageId2;

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showPicker1(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery1();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera1();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showPicker2(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery2();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera2();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }

  _imgFromCamera1() async {
    File imageId1 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imageId1 = imageId1;
    });
  }

  _imgFromCamera2() async {
    File imageId2 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imageId2 = imageId2;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery1() async {
    File imageId1 = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imageId1 = imageId1;
    });
  }

  _imgFromGallery2() async {
    File imageId2 = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imageId2 = imageId2;
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
        title: Text("Add Staff"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 11.0, right: 11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: _image != null
                            ? Container(
                                decoration: new BoxDecoration(
                                  color: Color(0x22888888),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(90.0)),
                                  border: new Border.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(
                                      _image,
                                    ),
                                    // fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 95,
                              ),
                        decoration: new BoxDecoration(
                          color: Color(0x22888888),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(90.0)),
                          border: new Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Column(
                          children: [
                            MyTextFormField(
                                lable: "First Name",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter first name";
                                  }
                                  return "";
                                },
                                hintText: "Enter first name"),
                            MyTextFormField(
                                lable: "Last Name",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter last name";
                                  }
                                  return "";
                                },
                                hintText: "Enter last name"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MyTextFormField(
                  lable: "Mobile No",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please enter mobile number";
                    }
                    return "";
                  },
                  hintText: "Enter mobile number"),
              MyTextFormField(
                  lable: "Email   ( optional )",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter email";
                    }
                    return "";
                  },
                  hintText: "Enter email"),
              MyTextFormField(
                  lable: "Address",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Address";
                    }
                    return "";
                  },
                  hintText: "Enter address"),
              /* Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ),*/
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DialogOpenFormField(
                    lable: "Staff Identity",
                    value: idProofData,
                    onTap: () {
                      // print("click");
                      FocusScope.of(context).unfocus();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: MyDropDown(
                                  dropDownTitle: "Identity",
                                  dropDownData: idProof,
                                  onSelectValue: (value) {
                                    setState(() {
                                      idProofData = value;
                                    });
                                  }),
                            );
                          });
                    }),
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 4.0),
                child: Text("Select ID Proof",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: containerdash1),
                  Container(
                    width: 10,
                  ),
                  Expanded(child: containerdash2),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: MyButton(
                    title: "Add Staff",
                    onPressed: () {
                      /*  Navigator.push(
                          context,
                          PageTransition(
                              child: (),
                              type: PageTransitionType.rightToLeft));*/
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get containerdash1 {
    return Center(
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [5, 5, 5, 5],
        color: Colors.grey[400],
        child: GestureDetector(
          onTap: () {
            _showPicker1(context);
          },
          child: Container(
            height: 110,
            // width: MediaQuery.of(context).size.width / 2.2,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: Color(0x22888888),
            ),
            child: _imageId1 != null
                ? Center(
                    child: Image.file(
                      _imageId1,
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32.0,
                          height: 32.0,
                          child: Icon(
                            Icons.add,
                            color: Colors.black54,
                            size: 25,
                          ),
                          decoration: new BoxDecoration(
                            // color: Colors.grey[300],
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(90.0)),
                            border:
                                new Border.all(color: Colors.grey, width: 1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text("Front",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget get containerdash2 {
    return Center(
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [5, 5, 5, 5],
        color: Colors.grey[400],
        child: GestureDetector(
          onTap: () {
            _showPicker2(context);
          },
          child: Container(
            height: 110,
            // width: MediaQuery.of(context).size.width / 2.2,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: Color(0x22888888),
            ),
            child: _imageId2 != null
                ? Center(
                    child: Image.file(
                      _imageId2,
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32.0,
                          height: 32.0,
                          child: Icon(
                            Icons.add,
                            color: Colors.black54,
                            size: 25,
                          ),
                          decoration: new BoxDecoration(
                            // color: Colors.grey[300],
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(90.0)),
                            border:
                                new Border.all(color: Colors.grey, width: 1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text("Back",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
