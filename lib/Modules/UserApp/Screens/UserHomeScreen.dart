import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/MyVisitorsComponent.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  List bannerList = [
    "https://graphicsfamily.com/wp-content/uploads/edd/2020/11/Tasty-Food-Web-Banner-Design-scaled.jpg",
    "https://previews.customer.envatousercontent.com/files/219112782/preview%20image.JPG",
    "https://i.pinimg.com/originals/14/14/5f/14145f84d1f7dbceddf9f6ffd9995594.jpg"
  ];

  List quickActions = [
    {"id": 0, "icon": CupertinoIcons.number_square, "title": "Notice"},
    {"id": 0, "icon": Icons.album, "title": "Emergency"},
    {"id": 0, "icon": CupertinoIcons.number_square, "title": "Advertisement"},
    {"id": 0, "icon": CupertinoIcons.car_detailed, "title": "Parking"},
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
            autoplay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(seconds: 1),
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
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 6.0, top: 8.0),
          child: Text(
            "Quick Actions",
            style: fontConstants.listTitles,
          ),
        ),
        SizedBox(
          height: 85,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: quickActions.map((e) {
              return Card(
                elevation: 0,
                child: SizedBox(
                  width: 85,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/complain.png",
                            width: 35,
                            color: appPrimaryMaterialColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${e["title"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 6.0, top: 8.0),
          child: Text(
            "My Visitors",
            style: fontConstants.listTitles,
          ),
        ),
        SizedBox(
          height: 102,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MyVisitorComponent();
              }),
        )
      ],
    );
  }
}
