import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _sharedPrefs;

  factory SharedPref() => SharedPref._internal();
  SharedPref._internal();

  static Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  static setData(String key, String value) {
    _sharedPrefs.setString(key, value);
  }

  static setBool(String key, bool value) {
    _sharedPrefs.setBool(key, value);
  }

  static bool getBool(String key) {
    return _sharedPrefs.getBool(key) ?? false;
  }

  static deleteData(key) {
    _sharedPrefs.remove(key);
  }

  static deleteAll() async {
    await _sharedPrefs.clear();
  }

  static String? getData(String key) {
    return _sharedPrefs.getString(key);
  }
}
