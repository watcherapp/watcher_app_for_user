import 'package:flutter/material.dart';

class MemberDirectoryScreen extends StatefulWidget {
  @override
  _MemberDirectoryScreenState createState() => _MemberDirectoryScreenState();
}

class _MemberDirectoryScreenState extends State<MemberDirectoryScreen> {
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
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active_rounded),
            onPressed: () {
            },
          ),
        ],
        title: Text("Member Directory"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
              Text("data"),

          ],
        ),
      ),
    );
  }
}
