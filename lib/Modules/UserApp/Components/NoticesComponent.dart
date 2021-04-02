import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class NoticesComponent extends StatefulWidget {
  @override
  _NoticesComponentState createState() => _NoticesComponentState();
}

class _NoticesComponentState extends State<NoticesComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          // border: Border.all(color: appPrimaryMaterialColor, width: 1)
        ),
        //height: 210,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18),
              child: Text(
                "Covid Checking",
                style:
                TextStyle(fontFamily: 'Montserrat', fontSize: 15),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                height: 0.3,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 13.0, left: 18, right: 18),
              child: Text(
                "Coronavirus India Live Updates: As covid cases rise in Maharashtra, Pune hospitals say they’re short on Covaxin doses",
                textAlign: TextAlign.justify,
                style:
                TextStyle(fontFamily: 'Montserrat', fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, top: 14, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " - Covid Checking",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        color: appPrimaryMaterialColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                height: 0.4,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 10.0, left: 18, bottom: 7),
              child: Row(
                children: [
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    height: 32,
                    color: appPrimaryMaterialColor[100],
                    onPressed: () {},
                    child: Text(
                      "22 Jan 2021",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: appPrimaryMaterialColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      height: 32,
                      color: appPrimaryMaterialColor[100],
                      onPressed: () {},
                      child: Text(
                        "02:46 PM",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
