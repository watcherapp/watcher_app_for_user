import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class fontConstants {
  static const bigTitleWhite = TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat');
  static const bigTitleBlack = TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat');
  static const listTitles = TextStyle(
      color: Colors.black87,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat-Bold');
  static const subTitleText = TextStyle(color: Colors.grey, fontSize: 16);

  // TextFormField label
  static const formFieldLabel = TextStyle(
      color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold);

  // Bottombar FontStyle
  static const activeFonts = TextStyle(fontSize: 12);

  //Label fontStyle
  static const labelFonts =
      TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Montserrat');
  static const valueFonts = TextStyle(
      fontSize: 15,
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat');

  //ProfilePage Fonts
  static const titleFonts = TextStyle(
      fontSize: 14,
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat-Bold');
  static const smallText = TextStyle(
    color: Colors.grey,
    fontSize: 14,
    fontFamily: 'WorkSans',
  );
}

class paddingConstant {
  static const authScreenContentPadding =
      EdgeInsets.only(top: 20, left: 20.0, right: 20.0);
  static const createSocietyScreenPadding =
      EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0);
}
