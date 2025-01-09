import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorage {
  const PersistentStorage({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  Future<String?> read({required String key}) async {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(Exception(error), stackTrace);
    }
  }

  Future<bool?> readBool({required String key}) async {
    try {
      return _sharedPreferences.getBool(key);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(Exception(error), stackTrace);
    }
  }

  Future<void> write({required String key, required String value}) async {
    try {
      await _sharedPreferences.setString(key, value);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(Exception(error), stackTrace);
    }
  }

  Future<bool?> writeBool({required String key, required bool value}) async {
    try {
      return _sharedPreferences.setBool(key, value);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(Exception(error), stackTrace);
    }
  }

  Future<void> delete({required String key}) async {
    try {
      await _sharedPreferences.remove(key);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(Exception(error), stackTrace);
    }
  }

  Future<void> clear() async {
    try {
      await _sharedPreferences.clear();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(Exception(error), stackTrace);
    }
  }
}
