import 'dart:io' show File;

import 'package:flutter/material.dart';

import '../assets.dart';

class QuranRail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      //left: size.width * 0,
      //bottom: size.height * 0,
      left: 0,
      bottom: 0,
      child: Opacity(
        opacity: 0.2,
        child: QuranRailImage(height: size.height * 0.4),
      ),
    );
  }
}

class QuranRailImage extends StatelessWidget {
  final double? width;
  final double? height;

  const QuranRailImage({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(Images.quranRail),
      width: width,
      height: height,
    );
  }
}
