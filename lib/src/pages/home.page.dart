import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../nav.dart';
import '../services.dart';
import '../widgets.dart'
    show AppDrawer, AppName, Calligraphy, QuranRail, WidgetAnimator;

class HomePage extends StatefulWidget {
  final double maxSlide;

  HomePage({required this.maxSlide});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _canBeDragged = false;

  bool get isDismissedOrCompleted =>
      _animationController.isDismissed || _animationController.isCompleted;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        behavior: HitTestBehavior.translucent,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: _animatedBuilder,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          "Exit Application",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text("Are You Sure?"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              shape: StadiumBorder(),
            ),
            child: Text("Yes", style: TextStyle(color: Colors.red)),
            onPressed: () => exit(0),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              shape: StadiumBorder(),
            ),
            child: Text("No", style: TextStyle(color: Colors.blue)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Widget _animatedBuilder(BuildContext context, Widget? child) {
    final isDark = SettingService.isDark;
    final mq = MediaQuery.of(context);
    final width = mq.size.width;

    return Material(
      color: isDark ? Colors.grey[850] : Colors.white70,
      child: SafeArea(
        child: Stack(
          children: [
            Transform.translate(
              offset:
                  Offset(widget.maxSlide * (_animationController.value - 1), 0),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(math.pi / 2 * (1 - _animationController.value)),
                alignment: Alignment.centerRight,
                child: AppDrawer(),
              ),
            ),
            Transform.translate(
              offset: Offset(widget.maxSlide * _animationController.value, 0),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(-math.pi / 2 * _animationController.value),
                alignment: Alignment.centerLeft,
                child: _MainScreen(),
              ),
            ),
            Positioned(
              top: 4.0 + mq.padding.top,
              left: width * 0.01 + _animationController.value * widget.maxSlide,
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: _toggle,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggle() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _onDragStart(DragStartDetails details) {
    _canBeDragged = isDismissedOrCompleted;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      _animationController.value +=
          (details.primaryDelta ?? 0) / widget.maxSlide;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (isDismissedOrCompleted) return;
    final dx = details.velocity.pixelsPerSecond.dx;
    if (dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = dx / MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }
}

class _MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: MediaQuery.of(context).size.width,
      color: SettingService.isDark ? Colors.grey[800] : Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppName(),
          Calligraphy(),
          QuranRail(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                  size: size,
                  onPressed: () => Nav.showSurahIndex(context),
                  title: 'Surah Index',
                ),
                _buildButton(
                  size: size,
                  onPressed: () => Nav.showJuzzIndex(context),
                  title: 'Juzz Index',
                ),
                _buildButton(
                  size: size,
                  onPressed: () => Nav.showSajdaIndex(context),
                  title: 'Sajda Index',
                ),
              ],
            ),
          ),
          //_buildAyahBottom(context),
        ],
      ),
    );
  }

  Widget _buildAyahBottom(BuildContext context) {
    final captionStyle = Theme.of(context).textTheme.caption;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "\"Indeed, It is We who sent down the Qur'an\nand indeed, We will be its Guardian\"\n",
            textAlign: TextAlign.center,
            style: captionStyle,
          ),
          Text(
            "Surah Al-Hijr\n",
            style: captionStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required Size size,
    required VoidCallback onPressed,
    required String title,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: SizedBox(
        width: size.width * 0.7,
        height: size.height * 0.06,
        child: ElevatedButton(
          style: _buttonStyle,
          onPressed: onPressed,
          child: WidgetAnimator(
            Text(
              title,
              style: TextStyle(
                fontSize: size.height * 0.023,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final _buttonStyle = ElevatedButton.styleFrom(
    primary: Color(0xffee8f8b),
    shape: StadiumBorder(),
  );
}

const double _kMinFlingVelocity = 365.0;
