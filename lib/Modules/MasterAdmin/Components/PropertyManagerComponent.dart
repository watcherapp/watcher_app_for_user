import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class PropertyManagetComponent extends StatefulWidget {
  var propertyManagerData;
  PropertyManagetComponent({this.propertyManagerData});

  @override
  _PropertyManagetComponentState createState() =>
      _PropertyManagetComponentState();
}

class _PropertyManagetComponentState extends State<PropertyManagetComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              4.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 4,
                    height: 70,
                    decoration: BoxDecoration(
                        color: appPrimaryMaterialColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 11.0, right: 5),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "13" + " - " + "May",
                          // "${date[0]}" + " - " + "May",
                          //  "-" + "${funMonth("${date[1]}")}",
                          style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            "09:00 PM",
                            //  '${new DateFormat.MMM().format(DateTime.parse(DateFormat("yyyy-MM-dd").parse(widget.notification["Date"].toString().substring(0,10)).toString()))},${widget.notification["Date"].substring(0, 4)}',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      color: Colors.grey[300],
                      width: 0.8,
                      height: 54,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sunshine Place",
                                //'${widget.notification["Title"]}',
                                style: TextStyle(
                                    color: appPrimaryMaterialColor,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              "160 st , Fresh Meado , NY , 11365",
                              //'${widget.notification["Title"]}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ]),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 25,
                      width: 70,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          // side: BorderSide(color: Colors.red)
                        ),
                        color: appPrimaryMaterialColor[100],
                        onPressed: () {},
                        child: Text(
                          "View",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: appPrimaryMaterialColor),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
