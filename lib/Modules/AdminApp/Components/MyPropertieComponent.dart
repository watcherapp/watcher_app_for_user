import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class MyPropertiesComponent extends StatefulWidget {
  @override
  _MyPropertiesComponentState createState() => _MyPropertiesComponentState();
}

class _MyPropertiesComponentState extends State<MyPropertiesComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        side: new BorderSide(color: Colors.grey, width: 0.1),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: GridTile(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Image.asset(
              "images/building.png",
              width: 38,
              color: appPrimaryMaterialColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, bottom: 30),
            child: FittedBox(
              // fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3, top: 4),
                child: Text(
                  "Megha",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: appPrimaryMaterialColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ]),
        footer: Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
              color: appPrimaryMaterialColor,
              onPressed: () {},
              child: Text(
                "Admin",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
