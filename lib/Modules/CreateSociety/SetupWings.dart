import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/ParticularWingSetup.dart';

class SetupWings extends StatefulWidget {
  @override
  _SetupWingsState createState() => _SetupWingsState();
}

class _SetupWingsState extends State<SetupWings> {
  int length = 12;
  List wingList = [];

  createWings() {
    int alphabet = "A".codeUnits.first;
    List temp = [];
    wingList.clear();
    for (int i = 0; i < length; i++) {
      temp.add(String.fromCharCode(alphabet++));
    }
    print(temp.toString());
    setState(() {
      setState(() {
        wingList = temp;
      });
    });
  }

  @override
  void initState() {
    createWings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text("Setup Wings"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: wingList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 1,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ParticularWingSetup(wingList[index]),
                                  type: PageTransitionType.rightToLeft));
                        },
                        child: Stack(
                          children: [
                            Center(
                              child: Text("${wingList[index]}",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black)),
                            ),
                            Positioned(
                                right: 10,
                                bottom: 10,
                                child: Icon(
                                  Icons.info_outline,
                                  color: Colors.redAccent,
                                  size: 18,
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
