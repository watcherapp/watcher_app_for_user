import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Data/Services.dart';

enum Status { Loading, Completed }

class AuthenticationProvider with ChangeNotifier {
  List userData = [];
  var _status;
  signIn({@required username, @required password}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _status = Status.Loading;
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var data = {
          "mobileNo1": "1234567890",
          "password": "1234567",
          "deviceType": "android"
        };
        Services.postForList(apiName: 'api/member/memberSignIn', body: data)
            .then((responseData) {
          _status = Status.Completed;
          if (responseData.length > 0) {
            preferences.setString(Session.memberId, responseData[0]["_id"]);
            preferences.setString(
                Session.memberNo, responseData[0]["memberNo"]);
            // preferences.setString(Session.deviceType, responseData[0]["_id"]);
            // preferences.setString(Session.societyId, responseData[0]["_id"]);
            // preferences.setString(Session.societyCode, responseData[0]["_id"]);
            preferences.setString(
                Session.userRole, responseData[0]["userRole"]);
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
