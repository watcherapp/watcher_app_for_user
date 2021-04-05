import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';


class PollingComponent extends StatefulWidget {
  @override
  _PollingComponentState createState() => _PollingComponentState();
}

class _PollingComponentState extends State<PollingComponent> {
  double option1 = 2.0;
  double option2 = 0.0;
  double option3 = 2.0;
  double option4 = 3.0;

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10.0,left: 10,right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Padding(
          padding: const EdgeInsets.only(left:17.0,right: 17,top:12,bottom: 10),
          child: Container(
            child: Text("")
            ),
        ),
      ),
    );
      /*Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        //height: 210,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18),
              child: Text(
                "Shoud we go on a quest for the mini golf location ? ",
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                height: 0.3,
                color: Colors.grey,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 2),
                    borderRadius:
                    BorderRadius.all(Radius.circular(3))),
              ),
              onPressed: () {
              },
              child: Text(
                'Add',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                height: 0.4,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 18, bottom: 12),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: appPrimaryMaterialColor[100],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        "mukeshbhai",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                    height: 33,
                    width: 100,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: appPrimaryMaterialColor[100],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                        "Keval Mangroliya",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: appPrimaryMaterialColor),
                        ),
                      ),
                      height: 33,
                      width: 86,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
