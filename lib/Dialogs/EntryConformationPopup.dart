import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class EntryConfirmationPopup extends StatefulWidget {
  @override
  _EntryConfirmationPopupState createState() => _EntryConfirmationPopupState();
}

class _EntryConfirmationPopupState extends State<EntryConfirmationPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 32, 82, 0.7),
      body: Center(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                    ),
                    Text(
                      "Guest is waiting At Gate",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          //width: 130,
                          child: Flexible(
                            child: Text(
                              "smit vaghani",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.grey[800]),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 30,
                        // ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Image.asset('images/icons/success.png',
                                      width: 40, height: 40),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Image.asset('images/icons/success.png',
                                      width: 40, height: 40),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
            true == true
                ? Positioned(
                    left: 20,
                    right: 20,
                    child: Column(
                      children: [
                        AvatarGlow(
                          glowColor: Colors.orangeAccent,
                          endRadius: 90.0,
                          duration: Duration(milliseconds: 2000),
                          repeat: true,
                          showTwoGlows: true,
                          repeatPauseDuration: Duration(milliseconds: 100),
                          child: CircleAvatar(
                            radius: 50,
                            child: ClipOval(
                              child: Image.network(
                                "https://randomuser.me/api/portraits/men/11.jpg",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Positioned(
                    left: 20,
                    right: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 65,
                      backgroundImage: NetworkImage(
                        "images/icons/success.png",
                      ),
                    ),
                  ),
            //company image
            Positioned(
              top: 80,
              left: 20,
              right: -180,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                // maxRadius: 30,
                radius: 30,
                child: Container(
                  // height: 60,
                  // width: 60,
                  child: Image.network(
                    "images/icons/success.png",
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -25,
              left: 20,
              right: -180,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 25,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(65)),
                          child: Image.asset("images/icons/success.png")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "APPROVE",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -25,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 25,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(65)),
                          child: Image.asset("images/icons/success.png")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "LEAVE AT GATE",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -25,
              left: -180,
              right: 20,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 25,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(65)),
                          child: Image.asset("images/icons/error.png")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "DENY",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
