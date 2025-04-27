import 'package:hive/hive.dart';

class HiveService {
  static var box = Hive.box("settingsBox");


  static Future<void> saveSwitchState(String key, bool value) async {
    await box.put(key, value);
  }

  static Future<bool> getSwitchState(String key) async {
    return box.get(key, defaultValue: false);
  }

  static Future<void> saveTime(String key, DateTime value) async {
    await box.put(key, value.toIso8601String());
  }

  static Future<DateTime?> getTime(String key) async {
    String? value = box.get(key);
    return value != null ? DateTime.parse(value) : null;
  }

  static Future<void> saveEndTime(String key, String value) async {
    await box.put(key, value);
  }

  static Future<String?> getEndTime(String key) async {
    return box.get(key);
  }


  static Future<void> saveSeparateTime(String key, String value) async {
    await box.put(key, value);
  }

  static Future<String?> getSeparateTime(String key) async {
    return box.get(key);
  }
}

