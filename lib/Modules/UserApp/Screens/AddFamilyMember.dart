import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';

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

  //FocusNode
  FocusNode firstName;
  FocusNode middleName;
  FocusNode lastName;
  FocusNode mobileNo;
  FocusNode emailId;
  FocusNode save;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Column(
            children: [
              MyTextFormField(
                controller: txtFirstame,
                focusNode: firstName,
                lable: "Firstname",
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term) {
                  firstName.unfocus();
                  FocusScope.of(context).requestFocus(middleName);
                },
                hintText: "Enter First Name",
              ),
              MyTextFormField(
                focusNode: middleName,
                controller: txtMiddlename,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term) {
                  middleName.unfocus();
                  FocusScope.of(context).requestFocus(lastName);
                },
                lable: "Middlename",
                hintText: "Enter Middle Name",
              ),
              MyTextFormField(
                focusNode: lastName,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term) {
                  lastName.unfocus();
                  FocusScope.of(context).requestFocus(mobileNo);
                },
                controller: txtLastname,
                lable: "Lastname",
                hintText: "Enter Last Name",
              ),
              MyTextFormField(
                controller: txtMobileNo,
                lable: "MobileNo",
                focusNode: mobileNo,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
        child: MyButton(focusNode: save, onPressed: () {}, title: "Save"),
      ),
    );
  }
}
