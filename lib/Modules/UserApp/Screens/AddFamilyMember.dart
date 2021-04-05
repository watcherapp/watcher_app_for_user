import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/ClassList/Gender.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class AddFamilyMember extends StatefulWidget {
  @override
  _AddFamilyMemberState createState() => _AddFamilyMemberState();
}

class _AddFamilyMemberState extends State<AddFamilyMember> {
  //Controllers
  TextEditingController txtFirstame = new TextEditingController();
  TextEditingController txtMiddlename = new TextEditingController();
  TextEditingController txtLastname = new TextEditingController();
  TextEditingController txtMobileNo = new TextEditingController();
  TextEditingController txtEmailId = new TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  //FocusNode
  FocusNode firstName;
  FocusNode middleName;
  FocusNode lastName;
  FocusNode mobileNo;
  FocusNode emailId;
  FocusNode save;

  String selectedGender = "";

  List<Gender> genderList = [
    Gender(icon: "images/male.png", name: "male", isSelected: false),
    Gender(icon: "images/female.png", name: "female", isSelected: false),
    Gender(icon: "images/other.png", name: "other", isSelected: false),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(sharedPrefs.memberId);
    setState(() {
      genderList.forEach((gender) => gender.isSelected = false);
      genderList[0].isSelected = true;
      selectedGender = genderList[0].name;
    });
    firstName = new FocusNode();
    middleName = new FocusNode();
    lastName = new FocusNode();
    mobileNo = new FocusNode();
    emailId = new FocusNode();
    save = new FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstName.dispose();
    middleName.dispose();
    lastName.dispose();
    mobileNo.dispose();
    emailId.dispose();
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
        title: Text("Add Family Member"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFormField(
                  controller: txtFirstame,
                  focusNode: firstName,
                  lable: "Firstname",
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "name can't be empty";
                    } else {
                      return null;
                    }
                  },
                  onFieldSubmitted: (term) {
                    firstName.unfocus();
                    FocusScope.of(context).requestFocus(middleName);
                  },
                  hintText: "Enter First Name",
                ),
                // MyTextFormField(
                //   focusNode: middleName,
                //   controller: txtMiddlename,
                //   textInputAction: TextInputAction.next,
                //   onFieldSubmitted: (term) {
                //     middleName.unfocus();
                //     FocusScope.of(context).requestFocus(lastName);
                //   },
                //   validator: (value){
                //     if(value.isEmpty){
                //       return "mi";
                //     }
                //     else{
                //       return null;
                //     }
                //   },
                //   lable: "Middlename",
                //   hintText: "Enter Middle Name",
                // ),
                MyTextFormField(
                  focusNode: lastName,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term) {
                    lastName.unfocus();
                    FocusScope.of(context).requestFocus(mobileNo);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "last name can't be empty";
                    } else {
                      return null;
                    }
                  },
                  controller: txtLastname,
                  lable: "Lastname",
                  hintText: "Enter Last Name",
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Text("Gender", style: fontConstants.formFieldLabel),
                ),
                Row(
                  children: genderList.map((value) {
                    int index = genderList.indexOf(value);
                    return Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: SizedBox(
                        width: 90,
                        child: OutlinedButton(
                            style: ButtonStyle(),
                            onPressed: () {
                              setState(() {
                                genderList.forEach(
                                    (gender) => gender.isSelected = false);
                                genderList[index].isSelected = true;
                                selectedGender = genderList[index].name;
                              });
                              print(selectedGender);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    genderList[index].icon,
                                    color: genderList[index].isSelected
                                        ? appPrimaryMaterialColor
                                        : Colors.grey,
                                    width: 18,
                                  ),
                                  Text(genderList[index].name,
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: genderList[index].isSelected
                                              ? appPrimaryMaterialColor
                                              : Colors.grey)),
                                ],
                              ),
                            )),
                      ),
                    );
                  }).toList(),
                ),
                MyTextFormField(
                  controller: txtMobileNo,
                  lable: "MobileNo",
                  focusNode: mobileNo,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "mobile number can't be empty";
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term) {
                    mobileNo.unfocus();
                    FocusScope.of(context).requestFocus(emailId);
                  },
                  hintText: "Enter Mobile Number",
                  keyboardType: TextInputType.number,
                ),
                MyTextFormField(
                  focusNode: emailId,
                  controller: txtEmailId,
                  textInputAction: TextInputAction.done,
                  lable: "Email",
                  validator: (value) {
                    if (value.isEmpty) {
                      return "mobile number can't be empty";
                    } else {
                      return null;
                    }
                  },
                  onFieldSubmitted: (term) {
                    emailId.unfocus();
                    FocusScope.of(context).requestFocus(save);
                  },
                  hintText: "Enter Email",
                  keyboardType: TextInputType.emailAddress,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
        child: MyButton(
            focusNode: save,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                addFamilyMember();
              }
            },
            title: "Save"),
      ),
    );
  }

  addFamilyMember() async {
    try {
      LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = FormData.fromMap({
          "parentId": "${sharedPrefs.memberId}",
          "firstName": txtFirstame.text,
          "lastName": txtLastname.text,
          "mobileNo1": txtMobileNo.text,
          "emailId": txtEmailId.text,
          "gender": selectedGender,
        });
        print(body);
        Services.responseHandler(
                apiName: "api/member/addFamilyMember", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            LoadingIndicator.close(context);
            Fluttertoast.showToast(msg: "Family Member Added Successfully");
            Navigator.pop(context);
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
