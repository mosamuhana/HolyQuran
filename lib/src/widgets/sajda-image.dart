import 'package:flutter/material.dart';

import '../assets.dart';

class SajdaImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.bottomRight,
      child: Opacity(
        opacity: 0.15,
        child: Image.file(
          Images.sajda.toFile,
          height: height * 0.35,
        ),
      ),
    );
  }
}
