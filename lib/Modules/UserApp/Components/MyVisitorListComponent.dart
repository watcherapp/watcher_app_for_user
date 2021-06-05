import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';

class MyVisitorListComponent extends StatefulWidget {
  var visitorData;
  int index;

  MyVisitorListComponent({
    this.visitorData,
    this.index,
  });

  @override
  _MyVisitorListComponentState createState() => _MyVisitorListComponentState();
}

class _MyVisitorListComponentState extends State<MyVisitorListComponent> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  var videoUrl;
  bool isVolume = false;

  DateTime selectedFromDate = DateTime.now();
  var dateFormate = DateFormat('dd - MM -yyyy');

  @override
  void initState() {
    print(widget.visitorData["guestVideo"]);
    videoUrl = API_URL + widget.visitorData["guestVideo"];
    print("video -->${videoUrl}");
    _controller = VideoPlayerController.network(
      '${videoUrl}',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    print("${widget.visitorData["guestVideo"]}");
    print("${widget.visitorData["guestImage"]}");
    print("${widget.visitorData["guestName"]}");
    print(widget.index);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("---------->${widget.visitorData}");
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Container(
                      width: 70,
                      height: 70,
                      child: ClipOval(
                        child: widget.visitorData
                                    ["guestImage"] !=
                                ""
                            ? Image.network(
                                API_URL +
                                    "${widget.visitorData["guestImage"]}",
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "https://randomuser.me/api/portraits/men/9.jpg",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 6.0, top: 6, bottom: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${widget.visitorData["guestName"]}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        Text("Meeting",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black87)),
                        Text("${dateFormate.format(selectedFromDate)}",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black)),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            height: 22,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.verified,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Approved",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 4.0,
                    right: 4,
                    top: 4,
                  ),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 1,
                    child: FutureBuilder(
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
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
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
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 46),
                  ),
                ),
                Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                        icon: Icon(
                          isVolume == false
                              ? Icons.volume_up
                              : Icons.volume_off,
                          color: Colors.black,
                          size: 23,
                        ),
                        onPressed: () {
                          setState(() {
                            isVolume = !isVolume;
                            isVolume == false
                                ? _controller.setVolume(100.0)
                                : _controller.setVolume(0.0);
                          });
                        })),
                /*  Align(
                  alignment: Alignment.center,
                  child: FlatButton(
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
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 25),
                  ),
                )*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
