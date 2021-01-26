import 'package:flutter/material.dart';

class SetupWings extends StatefulWidget {
  @override
  _SetupWingsState createState() => _SetupWingsState();
}

class _SetupWingsState extends State<SetupWings> {
  List<String> gridItems = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Eleven',
    'Twelve',
    'Thirteen',
    'Fourteen',
    'Fifteen',
    'Sixteen',
    'Seventeen',
    'Eighteen',
    'Nineteen',
    'Twenty'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (2 / 1),
            children: gridItems
                .map((data) => GestureDetector(
                    onTap: () {},
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        color: Colors.lightBlueAccent,
                        child: Center(
                            child: Text(data,
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                                textAlign: TextAlign.center)))))
                .toList(),
          ),
        ),
      ]),
    );
  }
}
