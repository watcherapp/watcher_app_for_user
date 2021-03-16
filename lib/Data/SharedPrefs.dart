import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
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
}

final sharedPrefs = SharedPrefs();
