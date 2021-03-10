import 'dart:async';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/VisitorComponent.dart';
import 'package:watcher_app_for_user/CommonWidgets/MySearchField.dart';

class UserVisitorList extends StatefulWidget {
  @override
  _UserVisitorListState createState() => _UserVisitorListState();
}

class _UserVisitorListState extends State<UserVisitorList> {
  Future<void> getReport() async {
    print("Refresh");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: RefreshIndicator(
          onRefresh: () {
            return getReport();
          },
          child: Column(
            children: [
              MySearchField(
                icon: Icon(Icons.search_rounded,),
                hintText: "search",
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return VisitorComponent();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
