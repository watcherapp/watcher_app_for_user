import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  logout() {
    _sharedPrefs.clear();
  }

  factory SharedPrefs() => SharedPrefs._internal();
  SharedPrefs._internal();

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs ??= await SharedPreferences.getInstance();
    }
  }

  String get memberId => _sharedPrefs.getString(Session.memberId) ?? "";
  String get memberNo => _sharedPrefs.getString(Session.memberNo) ?? "";
  String get userRole => _sharedPrefs.getString(Session.userRole) ?? "";
  String get societyId => _sharedPrefs.getString(Session.societyId) ?? "";
  String get societyCode => _sharedPrefs.getString(Session.societyCode) ?? "";
  String get deviceType => _sharedPrefs.getString(Session.deviceType) ?? "";

  set memberId(String value) {
    _sharedPrefs.setString(Session.memberId, value);
  }

  set memberNo(String value) {
    _sharedPrefs.setString(Session.memberNo, value);
  }

  set userRole(String value) {
    _sharedPrefs.setString(Session.userRole, value);
  }

  set societyId(String value) {
    _sharedPrefs.setString(Session.societyId, value);
  }

  set societyCode(String value) {
    _sharedPrefs.setString(Session.societyCode, value);
  }

  set deviceType(String value) {
    _sharedPrefs.setString(Session.deviceType, value);
  }
}

final sharedPrefs = SharedPrefs();
