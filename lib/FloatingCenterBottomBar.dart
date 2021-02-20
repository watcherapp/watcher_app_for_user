import 'package:flutter/material.dart';

class BottomBarItem {
  BottomBarItem({this.iconData, this.title});
  IconData iconData;
  String title;
}

class FloatingCenterBottomBar extends StatefulWidget {
  FloatingCenterBottomBar(
      {Key key,
      this.items,
      this.centerItemText,
      this.height,
      this.iconSize,
      this.backgroundColor,
      this.color,
      this.selectedColor,
      this.notchedShape,
      this.onTabSelected}) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<BottomBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  _FloatingCenterBottomBarState createState() =>
      _FloatingCenterBottomBarState();
}

class _FloatingCenterBottomBarState extends State<FloatingCenterBottomBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildTabItem({
    BottomBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
        child: SizedBox(
      height: widget.height,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onPressed(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.iconData,
                color: color,
                size: widget.iconSize,
              ),
              Text(item.title, style: TextStyle(color: color))
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
          item: widget.items[index], index: index, onPressed: _updateIndex);
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());
    return BottomAppBar(
      notchMargin: 6.0,
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }
}
