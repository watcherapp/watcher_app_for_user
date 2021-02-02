import 'dart:developer';

import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';

class SetupWingsFinalStep extends StatefulWidget {
  int flatFormatId, totalFloor, totalCountPerFloor;
  String wingName;

  SetupWingsFinalStep(
      {this.flatFormatId,
      this.totalFloor,
      this.totalCountPerFloor,
      this.wingName});

  @override
  _SetupWingsFinalStepState createState() => _SetupWingsFinalStepState();
}

class _SetupWingsFinalStepState extends State<SetupWingsFinalStep> {
  List wingFlatData = [];
  final ScrollController _scrollController = new ScrollController();
  int rowsColumn = 0;
  int total;
  List flatColorsList = [
    appPrimaryMaterialColor,
    Colors.grey,
    Colors.orange,
    Colors.black,
    Colors.blueAccent,
  ];

  @override
  void initState() {
    total = widget.totalFloor * widget.totalCountPerFloor;
    createGridFlatList();
  }

  createGridFlatList() {
    setState(() {
      rowsColumn = widget.totalFloor * widget.totalCountPerFloor;
    });
    if (widget.flatFormatId == 1) {
      int flatNo = 1;
      for (int i = 0; i < widget.totalFloor; i++) {
        for (int j = 0; j < widget.totalCountPerFloor; j++) {
          wingFlatData.add({"flatNo": flatNo, "flatColor": flatColorsList[0]});
          flatNo++;
        }
      }
    }
  }

  changeColor({int index}) {
    setState(() {
      int colorIndex = flatColorsList.indexOf(wingFlatData[index]["flatColor"]);
      if (colorIndex <= 3)
        wingFlatData[index]["flatColor"] = flatColorsList[colorIndex + 1];
      else
        wingFlatData[index]["flatColor"] = flatColorsList[0];
    });
  }

  List<Widget> _buildCells(int count, int temp) {
    int flatNo = total - (temp * widget.totalCountPerFloor);
    return List.generate(count, (index) {
      flatNo++;
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 40,
          child: RaisedButton(
              color: wingFlatData[index]["flatColor"],
              onPressed: () {
                changeColor(index: index);
              },
              child: Text("$flatNo",
                  style: Theme.of(context).textTheme.subtitle1)),
        ),
      );
    });
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
      count,
      (index) => Row(
        children: _buildCells(widget.totalCountPerFloor, index + 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.totalCountPerFloor,
          ),
          scrollDirection: Axis.vertical,
          itemCount: wingFlatData.length,
          itemBuilder: (c, i) {
            return Card(
              child: Container(
                height: 100,
                width: 100,
                child: Center(child: Text("$i")),
              ),
            );
          },
        ));
  }
}
