import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_user/CommonWidgets/CircleDesign.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/ClassList/Gender.dart';
import 'package:watcher_app_for_user/Data/Providers/IndexCountProvider.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/ValidationClass.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/MyProperties.dart';

class SignUp3 extends StatefulWidget {
  String phoneNumber;

  SignUp3({
    this.phoneNumber,
  });

  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  int selectedIndex = 0;
  int currentIndex = 0;
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtMiddleName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  TextEditingController txtSocietyCode = TextEditingController();

  GlobalKey<FormState> _basicDetail = GlobalKey();
  GlobalKey<FormState> _firstStep = GlobalKey();
  GlobalKey<FormState> _passwordDetail = GlobalKey();
  bool isRoleSelected = false;

  List identityData = [];
  String selectedRole;

  String selectedValue;

  List<Gender> genderList = [
    Gender(icon: "images/male.png", name: "male", isSelected: false),
    Gender(icon: "images/female.png", name: "female", isSelected: false),
    Gender(icon: "images/other.png", name: "other", isSelected: false),
  ];

  List signUpRole = [
    {
      "icon": "images/admin.png",
      "label": "Property Manager",
      "value": "1",
    },
    {
      "icon": "images/member.png",
      "label": "Resident",
      "value": "2",
    }
  ];

  String selectedGender = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      genderList.forEach((gender) => gender.isSelected = false);
      genderList[0].isSelected = true;
      selectedGender = genderList[0].name;
    });
    print(widget.phoneNumber);
    getIdentityData();
  }

  File _userProfile, _identityProof;
  String _userFileName, _identityFileName;
  String _userFilePath, _identityFilePath;
  final picker = ImagePicker();

  Future getIdentityData() async {
    var url = API_URL + "api/staff/getAllidentityCategory";
    var res = await dio.post(url,
        options: Options(headers: {
          "authorization": "$Access_Token" // set content-length
        }));

    if (res.statusCode == 200) {
      setState(() {
        identityData = res.data["Data"];
      });
      print(identityData);
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<IndexCountProvider>(context);
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
        backgroundColor: appPrimaryMaterialColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleDesign(title: "Create account", backbutton: true),
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: paddingConstant.authScreenContentPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${provider.stepCurrentIndex > 1 ? "Create Password" : "Tell us more about you !"}",
                          style: fontConstants.bigTitleBlack),
                      Text("Sign Up to Continue",
                          style: fontConstants.subTitleText),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 3,
                            width: 30,
                            decoration: BoxDecoration(
                                color: provider.stepCurrentIndex == 0
                                    ? appPrimaryMaterialColor
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 3,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: provider.stepCurrentIndex == 1
                                      ? appPrimaryMaterialColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(6.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 3,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: provider.stepCurrentIndex == 2
                                      ? appPrimaryMaterialColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(6.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 3,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: provider.stepCurrentIndex == 3
                                      ? appPrimaryMaterialColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(6.0)),
                            ),
                          )
                        ],
                      ),
                      if (provider.stepCurrentIndex == 0) ...[
                        Expanded(
                          child: ListView(
                            children: [
                              Column(
                                  children: signUpRole.map((value) {
                                int index = signUpRole.indexOf(value);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentIndex = index;
                                      isRoleSelected = true;
                                      selectedRole = value["value"];
                                    });
                                    print("$selectedRole");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 40.0),
                                    child: Center(
                                      child: Container(
                                        width: 150,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Image.asset("${value["icon"]}",
                                                  width: 40,
                                                  color: currentIndex == index
                                                      ? appPrimaryMaterialColor
                                                      : Colors.grey),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("${value["label"]}",
                                                  style: TextStyle(
                                                      color: currentIndex ==
                                                              index
                                                          ? appPrimaryMaterialColor
                                                          : Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            border: Border.all(
                                                color: currentIndex == index
                                                    ? appPrimaryMaterialColor
                                                    : Colors.grey,
                                                width: 1.5)),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()),
                              selectedRole == "2"
                                  ? Form(
                                      key: _firstStep,
                                      child: MyTextFormField(
                                        lable: "SocietyCode",
                                        controller: txtSocietyCode,
                                        hintText: "Enter your Society Code",
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Society Code Can't be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ] else if (provider.stepCurrentIndex == 1) ...[
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Form(
                              key: _basicDetail,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  MyTextFormField(
                                      controller: txtFirstName,
                                      lable: "First Name",
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Please Enter First Name";
                                        }
                                        return null;
                                      },
                                      hintText: "Enter first name"),
                                  MyTextFormField(
                                      controller: txtMiddleName,
                                      lable: "Middle Name",
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Please Enter Middle Name";
                                        }
                                        return null;
                                      },
                                      hintText: "Enter middle name"),
                                  MyTextFormField(
                                      controller: txtLastName,
                                      lable: "Last Name",
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Please Enter Last Name";
                                        }
                                        return null;
                                      },
                                      hintText: "Enter last name"),
                                  MyTextFormField(
                                      controller: txtEmail,
                                      lable: "Email",
                                      validator: validateEmail,
                                      hintText: "Enter email"),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, bottom: 4.0),
                                    child: Text("Gender",
                                        style: fontConstants.formFieldLabel),
                                  ),
                                  Row(
                                    children: genderList.map((value) {
                                      int index = genderList.indexOf(value);
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 2.0),
                                        child: SizedBox(
                                          width: 90,
                                          child: OutlinedButton(
                                              style: ButtonStyle(),
                                              onPressed: () {
                                                setState(() {
                                                  genderList.forEach((gender) =>
                                                      gender.isSelected =
                                                          false);
                                                  genderList[index].isSelected =
                                                      true;
                                                  selectedGender =
                                                      genderList[index].name;
                                                });
                                                print(selectedGender);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      genderList[index].icon,
                                                      color: genderList[index]
                                                              .isSelected
                                                          ? appPrimaryMaterialColor
                                                          : Colors.grey,
                                                      width: 18,
                                                    ),
                                                    Text(genderList[index].name,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: genderList[
                                                                        index]
                                                                    .isSelected
                                                                ? appPrimaryMaterialColor
                                                                : Colors.grey)),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      );
                                    }).toList(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ] else if (provider.stepCurrentIndex == 2) ...[
                        Expanded(
                            child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    chooseCameraOrGallery(context, "Profile");
                                  },
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: appPrimaryMaterialColor,
                                    child: ClipOval(
                                        child: Container(
                                      height: 115,
                                      width: 115,
                                      child: _userProfile == null
                                          ? Image.asset("images/maleavtar.png")
                                          : Image.file(
                                              _userProfile,
                                              fit: BoxFit.fill,
                                            ),
                                    )),
                                  ),
                                ),
                                SizedBox(height: 24),
                                Text("Select Profile Photo",
                                    style: fontConstants.smallText),
                                SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        icon: Icon(
                                            Icons
                                                .arrow_drop_down_circle_outlined,
                                            size: 20),
                                        items: identityData.map((item) {
                                          return new DropdownMenuItem(
                                            child: new Text(
                                                "${item['identityProofName']}"),
                                            value: item['_id'],
                                          );
                                        }).toList(),
                                        hint: Text("Select Identity Proof",
                                            style: TextStyle(fontSize: 14)),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value;
                                          });
                                        },
                                        value: selectedValue,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    chooseCameraOrGallery(context, "Identity");
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.Rect,
                                    dashPattern: [5, 5, 5, 5],
                                    color: Colors.grey[400],
                                    child: Container(
                                      height: 129,
                                      width: 220,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: _identityProof != null
                                                ? FileImage(_identityProof)
                                                : AssetImage(
                                                    "images/id-card.png")),
                                        color: Color(0x22888888),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                SizedBox(height: 20),
                                Text("Select Identity Proof",
                                    style: fontConstants.smallText),
                              ],
                            ),
                          ),
                        ))
                      ] else ...[
                        Expanded(
                            child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Form(
                            key: _passwordDetail,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                MyTextFormField(
                                    controller: txtPassword,
                                    lable: "Create Password",
                                    validator: validatePassword,
                                    hintText: "Enter Password"),
                                MyTextFormField(
                                    controller: txtConfirmPassword,
                                    lable: "Confirm Password",
                                    validator: (val) {
                                      if (txtPassword.text != val) {
                                        return "Pasword does not match";
                                      }
                                      return null;
                                    },
                                    hintText: "Re-enter Password"),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 4.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lock,
                                        size: 13,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "  Password must contain :",
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "○ at least 8 characters",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.black87),
                                    ),
                                    Text(
                                      "○ at least 1 symbol like ( ! , \$ , # , & )",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.black87),
                                    ),
                                    Text(
                                      "○ both uppercase and lowercase",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                MyButton(
                                  onPressed: () {
                                    if (_passwordDetail.currentState
                                        .validate()) {
                                      _userSignUp();
                                    }
                                  },
                                  title: "Sign Up",
                                )
                              ],
                            ),
                          ),
                        ))
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: keyboardIsOpened
            ? null
            : Stack(
                children: <Widget>[
                  provider.stepCurrentIndex == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      provider.backButton();
                                    },
                                    heroTag: null,
                                    child: Icon(Icons.arrow_back_ios_rounded)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      if (_basicDetail.currentState
                                          .validate()) {
                                        provider.stepCurrentIndex = 2;
                                      }
                                    },
                                    heroTag: null,
                                    child:
                                        Icon(Icons.arrow_forward_ios_rounded)),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  provider.stepCurrentIndex == 0
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: appPrimaryMaterialColor,
                            onPressed: () {
                              if (selectedRole == "2") {
                                if (_firstStep.currentState.validate()) {
                                  provider.stepCurrentIndex = 1;
                                }
                              } else {
                                provider.stepCurrentIndex = 1;
                              }
                            },
                            mini: true,
                            heroTag: null,
                            child: Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        )
                      : SizedBox(),
                  provider.stepCurrentIndex == 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      provider.backButton();
                                    },
                                    heroTag: null,
                                    child: Icon(Icons.arrow_back_ios_rounded)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 31),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                    backgroundColor: appPrimaryMaterialColor,
                                    mini: true,
                                    onPressed: () {
                                      if (selectedValue != null) {
                                        if (_identityProof != null) {
                                          provider.stepCurrentIndex = 3;
                                        } else {
                                          Fluttertoast.showToast(
                                              gravity: ToastGravity.TOP,
                                              textColor: Colors.white,
                                              backgroundColor: Colors.red,
                                              msg:
                                                  "Please Attach Identity Proof");
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            gravity: ToastGravity.TOP,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.red,
                                            msg:
                                                "Please Select Type of Identity");
                                      }
                                    },
                                    heroTag: null,
                                    child:
                                        Icon(Icons.arrow_forward_ios_rounded)),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  provider.stepCurrentIndex == 3
                      ? Padding(
                          padding: EdgeInsets.only(left: 31),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: FloatingActionButton(
                                backgroundColor: appPrimaryMaterialColor,
                                mini: true,
                                onPressed: () {
                                  provider.backButton();
                                },
                                heroTag: null,
                                child: Icon(Icons.arrow_back_ios_rounded)),
                          ),
                        )
                      : SizedBox()
                ],
              ));
  }

  // Choose BottomSheet Select

  chooseCameraOrGallery(BuildContext context, var forWhich) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 25.0, top: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Choose Selection",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey)),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);

                        if (forWhich == "Profile") {
                          final pickedFile = await ImagePicker.pickImage(
                              source: ImageSource.camera);

                          setState(() {
                            if (pickedFile != null) {
                              _userProfile = File(pickedFile.path);
                            } else {
                              print('No image selected.');
                            }
                          });
                        } else {
                          final pickedFile = await ImagePicker.pickImage(
                              source: ImageSource.camera);

                          setState(() {
                            if (pickedFile != null) {
                              _identityProof = File(pickedFile.path);
                            } else {
                              print('No image selected.');
                            }
                          });
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.camera_alt_rounded,
                              size: 40, color: Colors.grey),
                          Text("Camera")
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        if (forWhich == "Profile") {
                          final pickedFile = await ImagePicker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            if (pickedFile != null) {
                              setState(() {
                                _userProfile = File(pickedFile.path);
                              });
                            } else {
                              print('No image selected.');
                            }
                          });
                        } else {
                          final pickedFile = await ImagePicker.pickImage(
                              source: ImageSource.gallery);

                          setState(() {
                            if (pickedFile != null) {
                              _identityProof = File(pickedFile.path);
                            } else {
                              print('No image selected.');
                            }
                          });
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.photo, size: 40, color: Colors.grey),
                          Text("Gallery")
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  _saveDataToSession(var sessionData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Session.memberId, sessionData[0]["_id"] ?? "");
    prefs.setString(Session.memberNo, sessionData[0]["memberNo"] ?? "");
    prefs.setString(
        Session.userRole, sessionData[0]["userRole"].toString() ?? "");
    if (sessionData[0]["userRole"] == 1) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: MyProperties(), type: PageTransitionType.leftToRight));
    } else {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: MyProperties(), type: PageTransitionType.leftToRight));
    }
  }

  _userSignUp() async {
    try {
      LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        String userFileName, identityFileName = "";
        String userFilePath, identityFilePath = "";
        File userCompressedFile, identityCompressedFile;

        if (_userProfile != null && _identityProof != null) {
          userCompressedFile = await FlutterNativeImage.compressImage(
              _userProfile.path,
              quality: 90);
          identityCompressedFile = await FlutterNativeImage.compressImage(
              _identityProof.path,
              quality: 90);

          userFileName = _userProfile.path.split('/').last;
          userFilePath = userCompressedFile.path;

          identityFileName = _userProfile.path.split('/').last;
          identityFilePath = identityCompressedFile.path;
        } else if (_userFilePath != null && _identityFilePath != "") {
          userFilePath = _userFilePath;
          userFileName = _userFileName;

          identityFilePath = _identityFilePath;
          identityFileName = _identityFileName;
        }

        var body = FormData.fromMap({
          "firstName": txtFirstName.text,
          "lastName": txtLastName.text,
          "mobileNo1": widget.phoneNumber,
          "emailId": txtEmail.text,
          "password": txtPassword.text,
          "userRole": selectedRole,
          "societyCode": txtSocietyCode.text ?? "",
          "address": "",
          "fcmToken": "ssdfsd6sds8555sdsdsfdvdscdcDSfdfdefddccscddDD2",
          "refferBy": "",
          "deviceType": Platform.isAndroid ? "android" : "ios",
          "gender": selectedGender,
          "identityProof": selectedValue,
          "identityImage": (identityFilePath != null && identityFilePath != '')
              ? await MultipartFile.fromFile(identityFilePath,
                  filename: identityFileName.toString())
              : null,
          "memberImage": (userFilePath != null && userFilePath != '')
              ? await MultipartFile.fromFile(userFilePath,
                  filename: userFileName.toString())
              : null,
        });
        log(body.fields.toString());
        Services.responseHandler(apiName: "api/member/signUp", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            LoadingIndicator.close(context);
            Fluttertoast.showToast(msg: "Response ${responseData.Data}");
            _saveDataToSession(responseData.Data);
          } else {
            print(responseData);
            LoadingIndicator.close(context);
            Fluttertoast.showToast(msg: "Response ${responseData.Message}");
          }
        }).catchError((error) {
          LoadingIndicator.close(context);
          Fluttertoast.showToast(msg: "$error");
        });
      }
    } catch (e) {
      LoadingIndicator.close(context);
      Fluttertoast.showToast(msg: "${Messages.message}");
    }
  }
}
