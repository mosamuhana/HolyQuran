import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class OverBoardAnimator {
  late TickerProvider _vsync;
  late AnimationController _controller;
  late Animation<double> _animation;

  OverBoardAnimator(TickerProvider vsync) {
    this._vsync = vsync;
    _controller = AnimationController(
      vsync: _vsync,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    //print('creating new animator');
  }

  AnimationController get controller => _controller;
  Animation<double> get animator => _animation;

  //AnimationController getController() => _controller;
  //Animation<double> getAnimator() => _animation;

  void dispose() => _controller.dispose();
}
