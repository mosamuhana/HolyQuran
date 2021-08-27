import 'dart:io';

import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final double opacity;
  final String url;
  final double? height;
  final bool isAsset;
  final bool isFile;

  CustomImage({
    required this.url,
    required this.opacity,
    this.height,
    this.isAsset = false,
    this.isFile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Align(
          alignment: Alignment.topRight,
          child: _image,
        ),
      ),
    );
  }

  Widget get _image {
    if (isAsset) {
      return Image.asset(url, height: height);
    }
    if (isFile) {
      return Image.file(File(url), height: height);
    }
    return Image.network(url, height: height);
  }
}
