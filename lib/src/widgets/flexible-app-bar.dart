import 'package:flutter/material.dart';

import '../widgets.dart' show QuranRailImage;

class FlexibleAppBar extends StatelessWidget {
  final String title;
  final double height;
  final Widget? child;

  const FlexibleAppBar({
    Key? key,
    required this.title,
    required this.height,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: height * 0.045,
        ),
      ),
      background: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: 0.3,
              child: QuranRailImage(height: height * 0.4),
            ),
          ),
          if (child != null) Center(child: child),
        ],
      ),
    );
  }
}
