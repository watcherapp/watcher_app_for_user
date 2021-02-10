import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:watcher_app_for_user/Common/Custom_Icons.dart';
import 'package:watcher_app_for_user/ui/CustomWidgets/MyBottomBar.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(),
      body: Column(
        children: [
          Image.network(
            "https://media.istockphoto.com/vectors/banner-design-with-set-of-various-ice-cream-ice-cream-parlor-or-shop-vector-id1226254079?k=6&m=1226254079&s=170667a&w=0&h=PeIbCRaAFrxhEBlOUDxoafLPZR_7OsnGhXVk8a33B2M=",
            height: 70,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Text(("data"))
        ],
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }
}
