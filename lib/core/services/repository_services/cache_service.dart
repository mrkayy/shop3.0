import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static CacheService? _instance;
  static SharedPreferences? _prefs;

  CacheService._internal();

  static Future<CacheService> getInstance() async {
    if (_instance == null) {
      _instance = CacheService._internal();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs!.setString(key, value);
  }

  String? getString(String key) {
    return _prefs!.getString(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs!.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs!.getInt(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs!.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs!.getBool(key);
  }

  Future<bool> remove(String key) async {
    return await _prefs!.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs!.clear();
  }
}