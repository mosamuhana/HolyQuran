import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services.dart';

class CustomTitle extends StatelessWidget {
  final String title;

  CustomTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      top: size.height * 0.12,
      left: size.width * 0.1,
      child: Shimmer.fromColors(
        baseColor: SettingService.isDark ? Colors.white : Colors.black,
        highlightColor: Colors.grey,
        enabled: true,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
