import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  List bannerList = [
    "https://codecanyon.img.customer.envatousercontent.com/files/224348627/preview+image.JPG?auto=compress%2Cformat&fit=crop&crop=top&w=590&h=300&s=6382a8066531c8b9d309e3688249f39a",
    "https://previews.customer.envatousercontent.com/files/219112782/preview%20image.JPG",
    "https://i.pinimg.com/originals/14/14/5f/14145f84d1f7dbceddf9f6ffd9995594.jpg"
  ];

  List quickActions = [
    {"id": 1, "name": "Complaints", "icon": "images/EmergengyIcon.png"},
    {"id": 2, "name": "Complaints", "icon": "images/EmergengyIcon.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150.0,
          width: MediaQuery.of(context).size.width,
          child: Carousel(
            boxFit: BoxFit.cover,
            autoplay: false,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(seconds: 2),
            dotSize: 4.0,
            dotIncreasedColor: appPrimaryMaterialColor,
            dotBgColor: Colors.transparent,
            dotPosition: DotPosition.bottomCenter,
            dotVerticalPadding: 10.0,
            showIndicator: true,
            indicatorBgPadding: 7.0,
            images: bannerList
                .map(
                  (item) => Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      "$item",
                      fit: BoxFit.fitWidth,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    elevation: 2,
                    margin: EdgeInsets.all(4),
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Quick Actions",
            style: fontConstants.listTitles,
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: quickActions.map((data) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Column(
                    children: [
                      Image.asset(
                        "${data["icon"]}",
                        width: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "${data["name"]}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList()),
      ],
    );
  }
}
