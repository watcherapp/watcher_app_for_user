import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class MasterAdminDashboard extends StatefulWidget {
  @override
  _MasterAdminDashboardState createState() => _MasterAdminDashboardState();
}

class _MasterAdminDashboardState extends State<MasterAdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Container(),
    );
  }
}
