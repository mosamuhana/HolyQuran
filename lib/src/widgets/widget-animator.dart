import 'dart:async';

import 'package:flutter/material.dart';

class WidgetAnimator extends StatelessWidget {
  final Widget child;

  WidgetAnimator(this.child);

  @override
  Widget build(BuildContext context) => _Animator(child, wait());
}

class _Animator extends StatefulWidget {
  final Widget child;
  final Duration duration;

  _Animator(this.child, this.duration);

  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<_Animator>
    with SingleTickerProviderStateMixin {
  late Timer timer;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 290), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    timer = Timer(widget.duration, _controller.forward);
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (_, Widget? child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(0.0, (1 - _animation.value) * 20),
            child: child,
          ),
        );
      },
    );
  }
}

Timer? _timer;
Duration _duration = Duration();

Duration wait() {
  if (_timer == null || !_timer!.isActive) {
    _timer = Timer(Duration(microseconds: 120), () => _duration = Duration());
  }
  _duration += Duration(milliseconds: 100);
  return _duration;
}
