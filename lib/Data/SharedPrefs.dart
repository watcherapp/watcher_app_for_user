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
  String get mobileNo => _sharedPrefs.getString(Session.mobileNo) ?? "";
  String get memberNo => _sharedPrefs.getString(Session.memberNo) ?? "";
  String get userRole => _sharedPrefs.getString(Session.userRole) ?? "";
  String get societyId => _sharedPrefs.getString(Session.societyId) ?? "";
  String get flatId => _sharedPrefs.getString(Session.FlatId) ?? "";
  String get wingId => _sharedPrefs.getString(Session.WingId) ?? "";
  String get societyCode => _sharedPrefs.getString(Session.societyCode) ?? "";
  String get societyName => _sharedPrefs.getString(Session.societyName) ?? "";
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

  set societyName(String value) {
    _sharedPrefs.setString(Session.societyName, value);
  }

  set deviceType(String value) {
    _sharedPrefs.setString(Session.deviceType, value);
  }

  set wingId(String value) {
    _sharedPrefs.setString(Session.WingId, value);
  }
  set mobileNo(String value) {
    _sharedPrefs.setString(Session.mobileNo, value);
  }

  set flatId(String value) {
    _sharedPrefs.setString(Session.FlatId, value);
  }
}

final sharedPrefs = SharedPrefs();
