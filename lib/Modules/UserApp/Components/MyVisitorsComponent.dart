import 'package:flutter/material.dart';

class MyVisitorComponent extends StatefulWidget {
  @override
  _MyVisitorComponentState createState() => _MyVisitorComponentState();
}

class _MyVisitorComponentState extends State<MyVisitorComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                child: ClipOval(
                  child: Image.network(
                    "https://randomuser.me/api/portraits/men/9.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Keval Mangroliya",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    Text("Meeting",
                        style: TextStyle(fontSize: 12, color: Colors.black87)),
                    Text("17 - 02 - 2021",
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                    Row(
                      children: [
                        Container(
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
                                  size: 14,
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
