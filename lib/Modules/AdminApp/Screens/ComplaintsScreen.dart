import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/AdminApp/Components/ComplainComponent.dart';

class ComplaintsScreen extends StatefulWidget {
  @override
  _ComplaintsScreenState createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> tabs = [
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("A"),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("B"),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("C"),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("D"),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("E"),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appPrimaryMaterialColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("F"),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text(
              "Complaints",
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: appPrimaryMaterialColor,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 4, right: 4),
                child: Container(
                  height: 35,
                  child: TabBar(
                      controller: _tabController,
                      labelPadding: EdgeInsets.only(left: 9.0, right: 9.0),
                      // indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.grey[600],
                      labelColor: Colors.white,
                      isScrollable: true,
                      indicatorColor: appPrimaryMaterialColor,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: appPrimaryMaterialColor),
                      onTap: (index) {},
                      tabs: tabs),
                ),
              ),
              Expanded(
                child: TabBarView(physics: BouncingScrollPhysics(), children: [
                  ListView.builder(
                      padding: EdgeInsets.only(top: 5, bottom: 18),
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return ComplainComponent();
                      }),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ]),
              ),
            ],
          )),
    );
  }
}
