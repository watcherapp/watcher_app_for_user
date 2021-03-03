import 'dart:io';

import 'package:flutter/material.dart';

class AddMyStaff extends StatefulWidget {
  @override
  _AddMyStaffState createState() => _AddMyStaffState();
}

class _AddMyStaffState extends State<AddMyStaff> {
  File _staffProfile;

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
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: ClipOval(
                child: Image.asset(
                  'images/user.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
