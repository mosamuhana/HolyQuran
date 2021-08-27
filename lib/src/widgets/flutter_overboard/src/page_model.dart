import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';

class PageModel {
  Color? color;
  String? url;
  String? title;
  String? body;
  Widget? child;
  bool doAnimateChild = false;
  bool doAnimateImage = false;

  PageModel({
    this.color,
    required this.url,
    required this.title,
    required this.body,
    this.doAnimateImage = false,
  });

  PageModel.withChild({
    required this.child,
    required this.color,
    this.doAnimateChild = false,
  });
}
