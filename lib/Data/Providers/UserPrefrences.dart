import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';

class UserPreferenceProvider with ChangeNotifier {
  String memberId, memberNo, deviceType, userRole, societyId, societyCode;
  UserPreferenceProvider() {
    getSessionData();
  }

  getSessionData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    memberId = preferences.getString(Session.memberId);
    memberNo = preferences.getString(Session.memberNo);
    deviceType = preferences.getString(Session.deviceType);
    userRole = preferences.getString(Session.userRole);
    societyId = preferences.getString(Session.societyId);
    societyCode = preferences.getString(Session.societyCode);
    notifyListeners();
  }
}
