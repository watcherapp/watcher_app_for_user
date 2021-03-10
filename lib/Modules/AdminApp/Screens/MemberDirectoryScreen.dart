import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class MemberDirectoryScreen extends StatefulWidget {
  @override
  _MemberDirectoryScreenState createState() => _MemberDirectoryScreenState();
}

class _MemberDirectoryScreenState extends State<MemberDirectoryScreen> {
  List dataList = [
    {
      "lable": "A1",
      "img": "images/building.png",
    },
    {
      "lable": "B1",
      "img": "images/building.png",
    },
    {
      "lable": "C1",
      "img": "images/building.png",
    },
    {
      "lable": "D1",
      "img": "images/building.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active_rounded),
            onPressed: () {},
          ),
        ],
        title: Text(
          "Member Directory",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Select Building",
              style: TextStyle(
                  color: appPrimaryMaterialColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: dataList.map((data) {
                return Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: Image(
                                    color: appPrimaryMaterialColor,
                                    image: AssetImage(
                                      data["img"],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  data["lable"],
                                  style: TextStyle(
                                      color: appPrimaryMaterialColor,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          print(data["lable"]);
                          // launchUrl("tel:9879208321");
                        },
                      )
                    ],
                  ),
                );
              }).toList()),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset('images/user.png', width: 70, height: 70),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'smit vaghani',
                            style: TextStyle(
                                color: appPrimaryMaterialColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('B1 - 07'),
                          SizedBox(
                            height: 2,
                          ),
                          Text('8735069293'),
                          SizedBox(
                            height: 2,
                          ),
                          Text('Resident'),
                        ],
                      ),
                      SizedBox(
                        width: 105,
                      ),
                      IconButton(
                        icon: Icon(Icons.message),
                        iconSize: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 120,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset('images/user.png', width: 70, height: 70),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'smit vaghani',
                            style: TextStyle(
                                color: appPrimaryMaterialColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('B1 - 07'),
                          SizedBox(
                            height: 2,
                          ),
                          Text('8735069293'),
                          SizedBox(
                            height: 2,
                          ),
                          Text('Resident'),
                        ],
                      ),
                      SizedBox(
                        width: 105,
                      ),
                      IconButton(
                        icon: Icon(Icons.message),
                        iconSize: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 120,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset('images/user.png', width: 70, height: 70),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'smit vaghani',
                            style: TextStyle(
                                color: appPrimaryMaterialColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('B1 - 07'),
                          SizedBox(
                            height: 2,
                          ),
                          Text('8735069293'),
                          SizedBox(
                            height: 2,
                          ),
                          Text('Resident'),
                        ],
                      ),
                      SizedBox(
                        width: 105,
                      ),
                      IconButton(
                        icon: Icon(Icons.message),
                        iconSize: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 120,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset('images/user.png', width: 70, height: 70),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'smit vaghani',
                            style: TextStyle(
                                color: appPrimaryMaterialColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('B1 - 07'),
                          SizedBox(
                            height: 2,
                          ),
                          Text('8735069293'),
                          SizedBox(
                            height: 2,
                          ),
                          Text('Resident'),
                        ],
                      ),
                      SizedBox(
                        width: 105,
                      ),
                      IconButton(
                        icon: Icon(Icons.message),
                        iconSize: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Card(
            //   child: Padding(
            //     padding: const EdgeInsets.all(5.0),
            //     child: ListTile(
            //       leading:
            //           Image.asset('images/user.png', width: 60, height: 60),
            //       title: Text('smit vaghani'),
            //       subtitle: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('B1 - 07'),
            //           Text('8735069293'),
            //           Text('Resident'),
            //         ],
            //       ),
            //       // trailing: SizedBox(
            //       //   width: 130,
            //       //   height: 40,
            //       //   child: RaisedButton(
            //       //       child: Text(
            //       //         "Request Number",
            //       //         style: TextStyle(
            //       //             color: Colors.white,
            //       //             fontSize: 11,
            //       //             fontWeight: FontWeight.bold),
            //       //       ),
            //       //       shape: RoundedRectangleBorder(
            //       //           borderRadius: BorderRadius.circular(6)),
            //       //       color: appPrimaryMaterialColor,
            //       //       onPressed: () {}),
            //       // ),
            //       trailing: IconButton(
            //         icon: Icon(Icons.message),
            //         iconSize: 25,
            //       ),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}
