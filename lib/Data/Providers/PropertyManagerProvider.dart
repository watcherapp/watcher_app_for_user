import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class PropertyManagerProvider extends ChangeNotifier {
  List ManagerDatailList = [];

  PropertyManagerProvider() {
    getManagerData();
  }

  getManagerData([var status]) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = {
          "requestStatusCode": status,
        };
        Services.responseHandler(
                apiName: 'api/admin/getListOfRequestPropertyManager',
                body: body)
            .then((responselist) async {
          if (responselist.Data.length > 0) {
            ManagerDatailList = responselist.Data;
            notifyListeners();
          }
        }, onError: (e) {
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }
}
