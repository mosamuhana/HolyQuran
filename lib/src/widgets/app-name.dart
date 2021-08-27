import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.12,
      left: size.width * 0.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text("The", style: textTheme.headline2),
          Text("Holy\nQur'an", style: textTheme.headline1)
        ],
      ),
    );
  }
}
