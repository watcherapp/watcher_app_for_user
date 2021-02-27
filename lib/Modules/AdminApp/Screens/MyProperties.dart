import 'package:flutter/material.dart';

class MyProperties extends StatefulWidget {
  @override
  _MyPropertiesState createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Properties",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
      ),
    );
  }
}
