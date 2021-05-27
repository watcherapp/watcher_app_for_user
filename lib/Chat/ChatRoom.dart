import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_user/Chat/Chatting.dart';
import 'package:watcher_app_for_user/Chat/DataBase.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;
  String uid;

  String name = '', imageUrl;

  @override
  void initState() {
    // getUserName();
    getUserInfogetChats();
    super.initState();
  }

  Future<String> getUserName(String parUid) async {
    final list = await DatabaseMethods().getPartnerUserData(parUid);
    print(list[0]);
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    parUid:
                        snapshot.data.documents[index]['userName'].toString(),
                    chatRoomId: snapshot.data.documents[index]["chatRoomId"],
                    uid: uid,
                  );
                })
            : Container();
      },
    );
  }

  getUserInfogetChats() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    uid = pre.getString('uid');

    getUserChats(uid).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(snapshots);
        print("we got the data + ${chatRooms.toString()} this is name  $uid");
      });
    });
  }

  getUserChats(String itIsMyUid) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyUid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6270DD).withOpacity(.5),
      appBar: AppBar(
        title: Text(
          "Your Chat",
          // height: 40,
        ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.search),
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Search()));
      //   },
      // ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String chatRoomId;
  final String parUid, uid;

  ChatRoomsTile({this.chatRoomId, this.parUid, this.uid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chatting(
              chatRoomId: chatRoomId,
              parUid: parUid,
              myUid: uid,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(parUid.substring(0, 1),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(parUid,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
