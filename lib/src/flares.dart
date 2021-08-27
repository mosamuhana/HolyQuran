import 'package:flutter/material.dart';

import 'services.dart';
import 'widgets/flare.dart';

List<Widget> createFlares(Size size) {
  if (!SettingService.isDark) return [];
  final width = size.width;
  final height = size.height;
  return [
    Flare(
      color: Color(0xfff9e9b8),
      offset: Offset(width, -height),
      bottom: -50,
      duration: Duration(seconds: 17),
      left: 100,
      height: 60,
      width: 60,
    ),
    Flare(
      color: Color(0xfff9e9b8),
      offset: Offset(width, -height),
      bottom: -50,
      duration: Duration(seconds: 12),
      left: 10,
      height: 25,
      width: 25,
    ),
    Flare(
      color: Color(0xfff9e9b8),
      offset: Offset(width, -height),
      bottom: -40,
      left: -100,
      duration: Duration(seconds: 18),
      height: 50,
      width: 50,
    ),
    Flare(
      color: Color(0xfff9e9b8),
      offset: Offset(width, -height),
      bottom: -50,
      left: -80,
      duration: Duration(seconds: 15),
      height: 50,
      width: 50,
    ),
    Flare(
      color: Color(0xfff9e9b8),
      offset: Offset(width, -height),
      bottom: -20,
      left: -120,
      duration: Duration(seconds: 12),
      height: 40,
      width: 40,
    ),
  ];
}
