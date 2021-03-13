import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class PropertyManagersDetail extends StatefulWidget {
  @override
  _PropertyManagersDetailState createState() => _PropertyManagersDetailState();
}

class _PropertyManagersDetailState extends State<PropertyManagersDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Property Manager Detail",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.apartment,
                color: Colors.black54,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 9.0),
                child: Text(
                  "Krishna Society",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 23,
                      //fontWeight: FontWeight.bold,
                      color: appPrimaryMaterialColor),
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                "0FGDEFT4A",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    //fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.person,
                size: 20,
                color: Colors.black54,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meghana Solanki',
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  textScaleFactor: 1,
                ),
                Text(
                  'Property Manager',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Divider(
              height: 2,
              color: Colors.grey[300],
              indent: 20,
              endIndent: 20,
            ),
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.call,
                size: 20,
                color: Colors.black54,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '9429828152',
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  textScaleFactor: 1,
                ),
                Text(
                  'Mobile No',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Divider(
              height: 2,
              color: Colors.grey[300],
              indent: 20,
              endIndent: 20,
            ),
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.mail,
                size: 20,
                color: Colors.black54,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'meghatech9teen@gmail.com',
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  textScaleFactor: 1,
                ),
                Text(
                  'E-Mail',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Divider(
              height: 2,
              color: Colors.grey[300],
              indent: 20,
              endIndent: 20,
            ),
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.location_on,
                size: 20,
                color: Colors.black54,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'E-173 , Matrushakti , Punagam , Varacha',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  textScaleFactor: 1,
                ),
                Text(
                  'Address',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Divider(
              height: 2,
              color: Colors.grey[300],
              indent: 20,
              endIndent: 20,
            ),
          ),
          ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Icon(
                  Icons.location_city,
                  size: 20,
                  color: Colors.black54,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Surat',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500),
                          textScaleFactor: 1,
                        ),
                        Text(
                          'City',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gujrat',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500),
                        textScaleFactor: 1,
                      ),
                      Text(
                        'State',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'India',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500),
                          textScaleFactor: 1,
                        ),
                        Text(
                          'Country',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Divider(
              height: 2,
              color: Colors.grey[300],
              indent: 20,
              endIndent: 20,
            ),
          ),
        ],
      ),
    );
  }
}
