import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

class PropertyManagerProvider extends ChangeNotifier {
  List ManagerDetailList = [];

  PropertyManagerProvider() {
    getManagerData();
  }

  Future<int> getManagerData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.responseHandler(
                apiName: 'api/admin/getListOfRequestPropertyManager')
            .then((responselist) async {
          if (responselist.Data.length > 0) {
            ManagerDetailList = responselist.Data;
            notifyListeners();
          }
          return 0;
        }, onError: (e) {
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
          return 0;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
      return 0;
    }
  }
}
