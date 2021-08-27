import 'package:flutter/material.dart';

import 'routes.dart';
import 'services.dart';

class Nav {
  static Future<void> showHome(BuildContext context) =>
      Navigator.pushNamed(context, Routes.homeScreen);

  static Future<void> showJuzzIndex(BuildContext context) =>
      Navigator.pushNamed(context, Routes.juzzIndex);

  static Future<void> showJuzz(BuildContext context, int index) =>
      Navigator.pushNamed(context, Routes.juzz, arguments: index);

  static Future<void> showSajdaIndex(BuildContext context) =>
      Navigator.pushNamed(context, Routes.sajdaIndex);

  static Future<void> showSajda(BuildContext context, SajdaInfo info) =>
      Navigator.pushNamed(context, Routes.sajda, arguments: info);

  static Future<void> showSurahIndex(BuildContext context) =>
      Navigator.pushNamed(context, Routes.surahIndex);

  static Future<void> showSurah(BuildContext context, Surah surah) =>
      Navigator.pushNamed(context, Routes.surah, arguments: surah);
}
