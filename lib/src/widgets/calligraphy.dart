import 'dart:io';

import 'package:flutter/material.dart';

import '../assets.dart';

class Calligraphy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Positioned(
      right: size.width * 0.01,
      top: height * 0.045,
      child: Image.file(
        File(Images.gradLogo),
        height: height * 0.28,
      ),
    );
  }
}
