import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'circular_clipper.dart';
import 'overboard_animator.dart';
import 'page_model.dart';

enum SwipeDirection { LEFT_TO_RIGHT, RIGHT_TO_LEFT, SKIP_TO_LAST }

class OverBoard extends StatefulWidget {
  final List<PageModel> pages;
  final Offset? center;
  final bool showBullets;
  final VoidCallback finishCallback;
  final VoidCallback? skipCallback;
  final String? skipText, nextText, finishText;
  final Color buttonColor;

  OverBoard({
    Key? key,
    required this.pages,
    this.center,
    this.showBullets = true,
    this.skipText,
    this.nextText,
    this.finishText,
    required this.finishCallback,
    this.skipCallback,
    this.buttonColor = Colors.white,
  }) : super(key: key);

  @override
  _OverBoardState createState() => _OverBoardState();
}

class _OverBoardState extends State<OverBoard> with TickerProviderStateMixin {
  late OverBoardAnimator _animator;

  ScrollController _scrollController = ScrollController();
  double _bulletPadding = 5.0, _bulletSize = 10.0, _bulletContainerWidth = 0;

  int _counter = 0, _last = 0;
  int _total = 0;
  double initial = 0, distance = 0;
  Random random = Random();
  SwipeDirection _swipeDirection = SwipeDirection.RIGHT_TO_LEFT;

  @override
  void initState() {
    super.initState();

    _animator = OverBoardAnimator(this);
    _total = widget.pages.length;
  }

  @override
  Widget build(BuildContext context) => Container(child: _getStack());

  Widget _getStack() {
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        initial = details.globalPosition.dx;
      },
      onPanUpdate: (DragUpdateDetails details) {
        distance = details.globalPosition.dx - initial;
      },
      onPanEnd: (DragEndDetails details) {
        initial = 0.0;
        setState(() => _last = _counter);
        if (distance > 1 && _counter > 0) {
          _counter--;
          _swipeDirection = SwipeDirection.LEFT_TO_RIGHT;
          setState(() {});
          _animate();
        } else if (distance < 0 && _counter < _total - 1) {
          _counter++;
          _swipeDirection = SwipeDirection.RIGHT_TO_LEFT;
          setState(() {});
          _animate();
        }
      },
      child: Stack(
        children: [
          _getPage(_last),
          AnimatedBuilder(
            animation: _animator.animator,
            builder: (context, child) {
              return ClipOval(
                clipper: CircularClipper(
                  _animator.animator.value,
                  widget.center,
                ),
                child: _getPage(_counter),
              );
            },
            child: Container(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Opacity(
                  child: _getTextButton(
                    widget.skipText ?? "SKIP",
                    (widget.skipCallback != null ? widget.skipCallback : _skip),
                  ),
                  opacity: (_counter < _total - 1) ? 1.0 : 0.0,
                ),
                Expanded(
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        _bulletContainerWidth = constraints.maxWidth - 40.0;
                        return Container(
                          padding: const EdgeInsets.all(20.0),
                          child: (widget.showBullets
                              ? SingleChildScrollView(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  controller: _scrollController,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0; i < _total; i++)
                                        Padding(
                                          padding:
                                              EdgeInsets.all(_bulletPadding),
                                          child: Container(
                                            height: _bulletSize,
                                            width: _bulletSize,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (i == _counter
                                                  ? Colors.white
                                                  : Colors.white30),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                )
                              : Container()),
                        );
                      },
                    ),
                  ),
                ),
                (_counter < _total - 1
                    ? _getTextButton(
                        (widget.nextText ?? "NEXT"),
                        _next,
                      )
                    : _getTextButton((widget.finishText ?? "FINISH"),
                        widget.finishCallback)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPage(index) {
    PageModel page = widget.pages[index];
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: page.color,
      child: page.child != null
          ? Center(
              child: page.doAnimateChild
                  ? AnimatedBoard(
                      animator: _animator,
                      child: page.child,
                    )
                  : page.child,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getPageImage(page),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Text(
                    page.title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 75.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Text(
                    page.body!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _getPageImage(PageModel page) {
    //final image = Image.asset(page.url!, width: 300.0, height: 300.0);
    final image = Image.file(File(page.url!), width: 300.0, height: 300.0);
    if (page.doAnimateImage) {
      return AnimatedBoard(
        animator: _animator,
        child: Padding(
          padding: EdgeInsets.only(bottom: 25.0),
          child: image,
        ),
      );
    }
    return image;
  }

  Widget _getTextButton(_text, _onPress) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(20.0),
      ),
      child: Text(
        _text,
        style: TextStyle(color: widget.buttonColor),
      ),
      onPressed: _onPress,
    );
  }

  void _next() {
    _swipeDirection = SwipeDirection.RIGHT_TO_LEFT;
    _last = _counter;
    _counter++;
    setState(() {});
    _animate();
  }

  void _skip() {
    _swipeDirection = SwipeDirection.SKIP_TO_LAST;
    _last = _counter;
    _counter = _total - 1;
    setState(() {});
    _animate();
  }

  void _animate() {
    _animator.controller.forward(from: 0.0);

    double _bulletDimension = (_bulletPadding * 2) + (_bulletSize);
    double _scroll = _bulletDimension * _counter;
    double _maxScroll = _bulletDimension * _total - 1;
    if (_scroll > _bulletContainerWidth &&
        _swipeDirection == SwipeDirection.RIGHT_TO_LEFT) {
      double _scrollDistance =
          (((_scroll - _bulletContainerWidth) ~/ _bulletDimension) + 1) *
              _bulletDimension;
      _scrollController.animateTo(_scrollDistance,
          curve: Curves.easeIn, duration: Duration(milliseconds: 100));
    } else if (_scroll < (_maxScroll - _bulletContainerWidth) &&
        _swipeDirection == SwipeDirection.LEFT_TO_RIGHT) {
      _scrollController.animateTo(_scroll,
          curve: Curves.easeIn, duration: Duration(milliseconds: 100));
    } else if (_swipeDirection == SwipeDirection.SKIP_TO_LAST) {
      _scrollController.animateTo(_maxScroll,
          curve: Curves.easeIn, duration: Duration(milliseconds: 100));
    }
  }
}

class AnimatedBoard extends StatelessWidget {
  final Widget? child;
  final OverBoardAnimator animator;

  const AnimatedBoard({
    Key? key,
    required this.animator,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
        0.0,
        50.0 * (1.0 - animator.animator.value),
        0.0,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.0),
        child: child,
      ),
    );
  }
}
