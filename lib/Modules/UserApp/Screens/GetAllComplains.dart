import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetAllComplains extends StatefulWidget {
  @override
  _GetAllComplainsState createState() => _GetAllComplainsState();
}

class _GetAllComplainsState extends State<GetAllComplains> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("My Complains"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          height: 130,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 33,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image:
                              NetworkImage("https://picsum.photos/250?image=9"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // child: Image.network(
                      //   'https://picsum.photos/250?image=9',
                      // ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 66,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 25,
                          child: Center(child: Text('Complains Category')),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Expanded(
                          flex: 40,
                          child: Text(
                            'Complains Description: water tap is not working in my sink hiiiiii',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Expanded(
                            flex: 35,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.date_range),
                                SizedBox(width: 10,),
                                Text("12 jan 2021"),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
