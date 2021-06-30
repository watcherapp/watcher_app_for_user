import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:watcher_app_for_user/Chat/AllChatsPage.dart';
import 'package:watcher_app_for_user/Chat/ChatModel.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/BottomNavigationBarCustomForAdmin.dart';

class ChattingScreeen extends StatefulWidget {
  @override
  _ChattingScreeenState createState() => _ChattingScreeenState();
}

class _ChattingScreeenState extends State<ChattingScreeen> {
  // @override
  // Widget build(BuildContext context) {
  //   return ScopedModel(
  //     model: ChatModel(),
  //     child: AllChatsPage(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   elevation: 0.5,
      //   centerTitle: true,
      //   title: Text(
      //     "Hey, " + "${sharedPrefs.memberName}",
      //     style: TextStyle(color: Colors.black, fontSize: 17),
      //   ),
      // ),
      body: Container(
        child: Center(
          child: Text(
            "Chat",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustomForAdmin(),
    );
  }
}
