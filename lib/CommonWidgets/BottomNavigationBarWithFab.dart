import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Common/ClassList.dart';

// ignore: must_be_immutable
class BottomNavigationBarWithFab extends StatefulWidget {
  List<BottomBarItem> items;
  Color selectedColor;
  Color unSelectedColor;
  NotchedShape notchedShape;
  double height;
  BottomNavigationBarWithFab(
      {@required this.items,
      this.selectedColor,
      this.unSelectedColor,
      this.height,
      this.notchedShape});
  @override
  _BottomNavigationBarWithFabState createState() =>
      _BottomNavigationBarWithFabState();
}

class _BottomNavigationBarWithFabState
    extends State<BottomNavigationBarWithFab> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: BottomAppBar(
        shape: widget.notchedShape,
        child: Row(
            children: List.generate(4, (index) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(widget.items[index].icon)],
            ),
          );
        })),
      ),
    );
  }
}
