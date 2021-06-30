import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/BottomNavigationBarCustom.dart';

class HelloScreen extends StatefulWidget {
  @override
  _HelloScreenState createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   elevation: 0.5,
      //   centerTitle: true,
      //   title: Text(
      //     "Hey, " + "${sharedPrefs.memberName}",
      //     style: TextStyle(color: Colors.black, fontSize: 17),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.only(left: 6.0, right: 6.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 7,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                "https://i.pinimg.com/originals/14/14/5f/14145f84d1f7dbceddf9f6ffd9995594.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text("chat"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}
