import 'package:flutter/material.dart';

import 'entrance-fader.dart';

class Flare extends StatelessWidget {
  final Offset offset;
  final Color color;
  final Duration duration;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? height;
  final double? width;

  Flare({
    required this.offset,
    required this.color,
    required this.duration,
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: EntranceFader(
        offset: offset,
        duration: duration,
        delay: Duration(milliseconds: 100),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color,
                color.withAlpha(150),
                color.withAlpha(100),
                color.withAlpha(50),
                color.withAlpha(5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
