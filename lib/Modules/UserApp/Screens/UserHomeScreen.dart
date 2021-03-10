import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/MyVisitorListComponent.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

/*
  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }
*/

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150.0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
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
          ),
          SizedBox(
            height: 7,
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
            padding: const EdgeInsets.only(
                left: 8.0, bottom: 6.0, top: 8.0, right: 8),
            child: Text(
              "My Visitors",
              style: fontConstants.listTitles,
            ),
          ),
          SizedBox(
              height: 300,
              child: PageView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return MyVisitorListComponent();
                  })
              /*ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MyVisitorComponent();
                }),*/
              ),
          /* SizedBox(
            height: 8,
          ),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                // If the video is playing, pause it.
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  // If the video is paused, play it.
                  _controller.play();
                }
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          )*/
        ],
      ),
    );
  }
}
