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
      body:    Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          height: 120,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 33,
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(130),
                      ),
                      child: Image.network(
                        'https://picsum.photos/250?image=9',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 66,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 25,
                          child: Center(child: Text('Complains Category')),
                        ),
                        Expanded(flex: 40, child: Text('Complains Description')),
                        Expanded(flex: 35, child: Text('ghi')),
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
