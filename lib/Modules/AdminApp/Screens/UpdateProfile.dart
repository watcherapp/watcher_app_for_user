import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "images/perso-outline.png",
                  color: Colors.white,
                  width: 160,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Divider(
                    height: 0.1,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Choose Image",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
            color: appPrimaryMaterialColor,
            height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: paddingConstant.authScreenContentPadding,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: MyTextFormField(
                      lable: "First Name",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter First Name";
                        }
                        return "";
                      },
                      hintText: "Enter first name"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MyTextFormField(
                      lable: "Last Name",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Last Name";
                        }
                        return "";
                      },
                      hintText: "Enter last name"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              child: MyTextFormField(
                                  lable: "Code",
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Code";
                                    }
                                    return "";
                                  },
                                  hintText: "Code"),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Container(
                            width: 200,
                            child: MyTextFormField(
                                lable: "Mobile Number",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter Mobile Number";
                                  }
                                  return "";
                                },
                                hintText: "Enter mobile number"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: MyTextFormField(
                      lable: "Email ( Optional )",
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Email";
                        }
                        return "";
                      },
                      hintText: "Enter email"),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12.0),
        child: SizedBox(
          height: 45,
          child: RaisedButton(
            onPressed: () {},
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: appPrimaryMaterialColor,
            child: Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ),
    );
  }
}
