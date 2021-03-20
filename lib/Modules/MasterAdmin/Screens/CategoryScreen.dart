import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/BusinessCategory.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/ComplaintCategory.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/GuestCategory.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/SocietyCategory.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/StaffCategory.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/VendorCategory.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List catFields = [
    {
      "label": " Guest Category",
      "img": "images/guest.png",
      "screenName": GuestCategory(),
    },
    {
      "label": " Business Category",
      "img": "images/bussiness.png",
      "screenName": BusinessCategory(),
    },
    {
      "label": " Staff Category",
      "img": "images/staff.png",
      "screenName": StaffCategory(),
    },
    {
      "label": "Society Category",
      "img": "images/building.png",
      "screenName": SocietyCategory(),
    },
    {
      "label": "Vendor Category",
      "img": "images/seller.png",
      "screenName": VendorCategory(),
    },
    {
      "label": "Complaint Category",
      "img": "images/complaint.png",
      "screenName": ComplaintCategory(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 8, left: 11, right: 11),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: catFields[index]["screenName"],
                              type: PageTransitionType.rightToLeft));
                    },
                    child: Container(
                        height: 130,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                catFields[index]["img"],
                                color: appPrimaryMaterialColor,
                                width: 42,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  catFields[index]["label"],
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      //  fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                },
                itemCount: catFields.length),
          ],
        ),
      ),
    );
  }
}
