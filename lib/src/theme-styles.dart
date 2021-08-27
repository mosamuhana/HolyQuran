import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeStyles {
  static ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: Color(0xFF212121),
    accentColor: Color(0xff896277),
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    fontFamily: _kFontFamily,
    textTheme: TextTheme(
      headline1: _headline1Style,
      headline2: _headline2Style,
      bodyText1: _bodyText1Style,
      caption: _captionStyle,
    ),
  );

  static ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.orange,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    accentColor: Color(0xff896277),
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white60,
    fontFamily: _kFontFamily,
    textTheme: TextTheme(
      headline1: _headline1Style,
      headline2: _headline2Style,
      bodyText1: _bodyText1Style,
      caption: _captionStyle,
    ),
  );

  static ThemeData themeData(BuildContext buildContext, bool isDark) {
    return isDark ? _darkTheme : _lightTheme;
  }
}

const _headline1Style = TextStyle(
    fontFamily: _kFontFamily, fontWeight: FontWeight.w600, fontSize: 42);
const _headline2Style = TextStyle(
    fontFamily: _kFontFamily, fontWeight: FontWeight.w600, fontSize: 28);
const _bodyText1Style = TextStyle(
    fontFamily: _kFontFamily, fontWeight: FontWeight.w600, fontSize: 18);

const _captionStyle = TextStyle(fontFamily: _kFontFamily, fontSize: 14);

const _kFontFamily = 'Sogeo';
