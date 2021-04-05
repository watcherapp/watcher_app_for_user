import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/ClassList/Gender.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';

class InviteGuest extends StatefulWidget {
  @override
  _InviteGuestState createState() => _InviteGuestState();
}

class _InviteGuestState extends State<InviteGuest> {
  //Controllers
  TextEditingController txtGuestName = new TextEditingController();
  TextEditingController txtNumOfGuest = new TextEditingController();
  TextEditingController txtLastname = new TextEditingController();
  TextEditingController txtMobileNo = new TextEditingController();
  TextEditingController txtEmailId = new TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

   //datepicer coding

  //DateTime selectedFromDate = DateTime.now() ;
  DateTime selectedFromDate;
  DateTime selectedToDate;

  var fromDate = DateFormat('dd / MM / yyyy');
  var toDate = DateFormat('dd / MM / yyyy');

  Future<Null> showFromDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedFromDate)
      setState(() {
        selectedFromDate = picked;
      });
  }
  Future<Null> showToDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedToDate)
      setState(() {
        selectedToDate = picked;
      });
  }



  String selectedPurpose;

  List purposeList = [
    {
      "PurposeType" : "Meeting"
    },
    {
      "PurposeType" : "Delivery"
    },
    {
      "PurposeType" : "Guest"
    },
  ];


  //FocusNode
  FocusNode guestName;
  FocusNode numofguest;
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
    guestName = new FocusNode();
    numofguest = new FocusNode();
    lastName = new FocusNode();
    mobileNo = new FocusNode();
    emailId = new FocusNode();
    save = new FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    guestName.dispose();
    numofguest.dispose();
    lastName.dispose();
    mobileNo.dispose();
    emailId.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Invite Guest",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
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
                  controller: txtGuestName,
                  focusNode: guestName,
                  lable: "Guest Name",
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "name can't be empty";
                    } else {
                      return null;
                    }
                  },
                  onFieldSubmitted: (term) {
                    guestName.unfocus();
                    FocusScope.of(context).requestFocus(numofguest);
                  },
                  hintText: "Enter Guest Name",
                ),
                MyTextFormField(
                  focusNode: numofguest,
                  controller: txtNumOfGuest,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term) {
                    numofguest.unfocus();
                    FocusScope.of(context).requestFocus(lastName);
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return "mi";
                    }
                    else{
                      return null;
                    }
                  },
                  lable: "Number Of Guest",
                  hintText: "Enter Number Of Guest ",
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
                Padding(
                  padding: const EdgeInsets.only(top: 13.0, bottom: 9.0),
                  child: Text("Select Purpose Type",style: fontConstants.formFieldLabel),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:4.0,right: 4),
                  child: Container(
                    height: 47,
                   width: MediaQuery.of(context).size.width,
                   // padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[200]),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: purposeList.map((item) {
                          return new DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.only(left:11.0),
                              child: new Text(item['PurposeType'],style:  TextStyle(fontFamily: 'Montserrat',fontSize: 14),),
                            ),
                            value: item['PurposeType'].toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            selectedPurpose = newVal;
                          });
                        },
                        value: selectedPurpose,
                        hint: Padding(
                          padding: const EdgeInsets.only(left:13.0),
                          child: Text(
                            "Select Purpose Type",
                            style: TextStyle(color: Colors.grey,fontFamily: 'Montserrat',fontSize: 13),
                          ),
                        ),
                        /*style:
                        TextStyle(color: Colors.black, decorationColor: Colors.red),*/
                      ),

                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Valid From",style: fontConstants.formFieldLabel),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: GestureDetector(
                          onTap: (){
                            showFromDatePicker(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[200]),
                            height: 35,
                            width: 130,
                            child:Center(child: Text(selectedFromDate!=null?fromDate.format(selectedFromDate):"Select Date",)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Valid To",style: fontConstants.formFieldLabel),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: GestureDetector(
                          onTap: (){
                            showToDatePicker(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[200]),
                            height: 35,
                            width: 130,
                            child:Center(child: Text(selectedToDate!=null?toDate.format(selectedToDate):"Select Date",)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /*  Padding(
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
*/

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
                inviteGuest();
              }
            },
            title: "Save"),
      ),
    );
  }

  inviteGuest() async {
    try {
      LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "memberNo": "${sharedPrefs.memberNo}",
          "societyId": "6038838fd00ee22d24a09c7a",
          "validFrom": "08/03/2021",
          "validTo": "08/03/2021",
          "purpose": "Ni kev",
          "guestType": "6018dc018ca5940d100c1d40",
          "guestName": "Top Secret",
          "numberOfGuest": "1",
          "emailId": "private@gmal.com",
          "mobileNo": "9898494312",
          "wingName": "A",
          "flateNo": "101"
        };
        print(body);
        Services.responseHandler(apiName: "api/member/inviteGuest", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            LoadingIndicator.close(context);
            Fluttertoast.showToast(msg: "Guest Added Successfully");
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
