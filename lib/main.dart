import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:desktop_window/desktop_window.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await DesktopWindow.setMinWindowSize(Size(500, 600));
    //await DesktopWindow.setMaxWindowSize(Size(700, 700));
    //await DesktopWindow.setWindowSize(Size(800, 700));
  }

  runApp(App());
}
