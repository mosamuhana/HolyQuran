// https://pub.dev/packages/hive_listener
// https://github.com/malibayram91/hive_listener/blob/master/lib/hive_listener.dart

//library hive_listener;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// HiveListener(
//  box: Hive.box('settings'),
//  keys: ['dark_theme'], // keys is optional to specify listening value changes
//  builder: (context, box) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: box.get('dark_theme', defaultValue: false) ? ThemeData.dark() : ThemeData.light(),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  },
// )
class HiveListener<T> extends StatefulWidget {
  final Box<T> box;
  final List<String>? keys;

  /// if you want to close your box when disposing set [closeOnDispose] to true
  final bool closeOnDispose;
  final Widget Function(BuildContext context, Box<T> bx) builder;
  final WidgetBuilder? waitingBuilder;

  const HiveListener({
    Key? key,
    required this.box,
    required this.builder,
    this.keys,
    this.closeOnDispose = false,
    this.waitingBuilder,
  }) : super(key: key);

  @override
  _HiveListenerState createState() => _HiveListenerState();
}

class _HiveListenerState<T> extends State<HiveListener<T>> {
  bool isOpened = false;
  late Box<T> box;

  String get boxName => box.name;

  void _valueChanged() {
    box = widget.box;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    box = widget.box;
    isOpened = Hive.isBoxOpen(boxName);
    if (isOpened) {
      listen();
    } else {
      Hive.openBox<T>(boxName).then((value) {
        box = value;
        isOpened = box.isOpen;
        listen();
      });
    }

    super.initState();
  }

  void listen() {
    if (isOpened) {
      box.listenable(keys: widget.keys).addListener(_valueChanged);
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    if (isOpened) {
      box.listenable(keys: widget.keys).removeListener(_valueChanged);
    }

    if (widget.closeOnDispose) widget.box.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isOpened)
      return widget.builder(context, box);
    else
      return widget.waitingBuilder?.call(context) ??
          Center(child: CircularProgressIndicator());
  }
}
