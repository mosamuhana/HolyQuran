import 'package:flutter/material.dart';

import '../constants.dart' show APP_NAME, APP_VERSION;

class AppVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            APP_NAME,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height * 0.018,
            ),
          ),
          Text(
            "Version: $APP_VERSION\n",
            style: TextStyle(fontSize: height * 0.015),
          )
        ],
      ),
    );
  }
}
