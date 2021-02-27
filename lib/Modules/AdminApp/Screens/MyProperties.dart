import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/MyPropertieComponent.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 8, left: 3, right: 3, bottom: 3),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0),
              itemBuilder: (BuildContext context, int index) {
                return MyPropertiesComponent();
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}
