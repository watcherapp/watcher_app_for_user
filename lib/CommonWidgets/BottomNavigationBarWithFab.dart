import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Constants/ClassList.dart';
import 'package:watcher_app_for_user/Data/Providers/IndexCountProvider.dart';

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
  double opaCity = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<IndexCountProvider>(context);
    return SizedBox(
      height: widget.height,
      child: BottomAppBar(
        child: Row(
            children: List.generate(widget.items.length, (index) {
          return Expanded(
            child: InkWell(
              onTap: () {
                provider.bottomBarCurrentIndex = index;
                setState(() {
                  opaCity = 1;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (provider.bottomBarCurrentIndex != 2 &&
                      widget.items[index].imageIcon != null) ...[
                    Image.asset("${widget.items[index].imageIcon}", width: 45)
                  ] else ...[
                    Icon(widget.items[index].icon,
                        color: provider.bottomBarCurrentIndex == index
                            ? widget.selectedColor
                            : widget.unSelectedColor),
                    Text(widget.items[index].title,
                        style: TextStyle(
                            fontSize: 11,
                            color: provider.bottomBarCurrentIndex == index
                                ? widget.selectedColor
                                : widget.unSelectedColor,
                            fontWeight: FontWeight.bold)),
                  ]
                ],
              ),
            ),
          );
        })),
      ),
    );
  }
}
