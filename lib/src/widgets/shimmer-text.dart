import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services.dart';

class ShimmerText extends StatelessWidget {
  final String title;

  ShimmerText({required this.title});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: SettingService.isDark ? Colors.white : Colors.black,
      highlightColor: Colors.grey,
      enabled: true,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
