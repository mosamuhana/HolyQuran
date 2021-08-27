import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingService {
  static const NAME = 'SETTINGS';
  static const KEY_DARK_MODE = "DARK_MODE";
  static const KEY_FIRST_TIME = "FIRST_TIME";

  static bool _isInitialized = false;
  static late Box _box;

  Box get box => _box;

  static Future<void> initialize() async {
    if (!_isInitialized) {
      _box = await Hive.openBox(NAME);
      _isInitialized = true;
    }
  }

  //_box.watch(key: 'key').listen((e) {});
  static ValueListenable<Box> listen() =>
      _box.listenable(keys: [KEY_DARK_MODE]);

  static bool get isDark => _box.get(KEY_DARK_MODE, defaultValue: true) == true;

  static set isDark(bool value) => _box.put(KEY_DARK_MODE, value);

  static bool get isFirstTime =>
      _box.get(KEY_FIRST_TIME, defaultValue: true) == true;

  static void setFirstTime() {
    final v = _box.get(KEY_FIRST_TIME);
    if (v == null) {
      _box.put(KEY_FIRST_TIME, false);
    }
  }
}
