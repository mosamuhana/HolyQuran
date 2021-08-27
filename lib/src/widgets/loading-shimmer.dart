import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../assets.dart';
import 'widget-animator.dart';

class LoadingShimmer extends StatelessWidget {
  final String text;

  LoadingShimmer({required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.transparent,
      highlightColor: Color(0xfff9e9b8),
      enabled: true,
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.transparent,
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(
                Images.logo.toFile,
                height: size.height * 0.1,
              ),
              WidgetAnimator(
                Text(
                  "Loading $text..!",
                  style: TextStyle(fontSize: size.height * 0.02),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
