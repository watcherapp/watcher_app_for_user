import 'package:flutter/material.dart';

class BottomBarItem {
  BottomBarItem({this.icon, this.title, this.onTap});
  IconData icon;
  Function onTap;
  String title;
}
