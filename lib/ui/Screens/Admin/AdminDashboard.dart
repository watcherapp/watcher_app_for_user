import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyBottomBar.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      bottomNavigationBar: MyBottomBar(),
    );
  }
}
