import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVisitorListComponent extends StatefulWidget {
  @override
  _MyVisitorListComponentState createState() => _MyVisitorListComponentState();
}

class _MyVisitorListComponentState extends State<MyVisitorListComponent> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      child: ClipOval(
                        child: Image.network(
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
                        Text("Keval Mangroliya",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        Text("Meeting",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black87)),
                        Text("17 - 02 - 2021",
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
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4, top: 10),
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