import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import 'app-context.dart';

class ShareIcons {
  ShareIcons._();

  static const _kFontFam = 'ShareIcon';
  static const _kFontPkg = null;

  static const IconData list_nested =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData github =
      IconData(0xf09b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData google_play =
      IconData(0xf3ab, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class Images {
  static String _create(String name) =>
      p.join(AppContext.appDir.path, 'images', name);

  static String get drawer3d => _create('drawer3d.gif');
  static String get sajda => _create('sajda.jpg');
  static String get easyNav => _create('easy_nav.png');
  static String get gradLogo => _create('grad_logo.png');
  static String get gradLogoSmall => _create('grad_logo_small.png');
  static String get kaaba => _create('kaaba.png');
  static String get logo => _create('logo.png');
  static String get quranRail => _create('quran_rail.png');
  static String get roza => _create('roza.png');
  static String get sajdaIndex => _create('sajda_index.png');
  static String get ui => _create('ui.png');
  static String get sun => _create('sun.png');
  static String get moon => _create('moon.png');
}

extension StringImageExt on String {
  File get toFile => File(this);
}
