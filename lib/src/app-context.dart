import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'constants.dart' show APP_DIR_NAME, RESOURCES_URL;
import 'services.dart';
import 'utils.dart';

class AppContext {
  AppContext._();

  static late Directory _appDir;
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;
    //await Future.delayed(Duration(seconds: 3));

    _appDir = await _getAppDir();
    final exists = await _appDir.exists();
    print('Application dir exists: $exists');
    if (!exists) {
      await _appDir.create(recursive: true);
    }

    await _initResources();
    await _initHive();
    await QuranData.initialize();

    _isInitialized = true;
  }

  static Future<Directory> _getAppDir() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final dirPath = p.dirname(Platform.resolvedExecutable);
      return Directory(p.join(dirPath, 'resources'));
    }
    final dir = await getApplicationDocumentsDirectory();
    return Directory(p.join(dir.path, APP_DIR_NAME));
  }

  static Future<void> _initHive() async {
    await Hive.initFlutter(appDir.path);
    await SettingService.initialize();
  }

  static Future<void> _initResources() async {
    final dataFile = File(AppContext.getPath('data.json'));
    if (await dataFile.exists()) return;

    final file = File(AppContext.getPath('temp.zip'));
    await downloadFile(RESOURCES_URL, file);
    await extractZipFile(file, AppContext.appDir.path);
    await file.delete();
  }

  static Directory get appDir => _appDir;

  static String getPath(String fileName) => p.join(_appDir.path, fileName);
}
