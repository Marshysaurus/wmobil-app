import 'package:flutter/material.dart';

class BlinkingCircle extends StatefulWidget {
  @override
  _BlinkingCircleState createState() => _BlinkingCircleState();
}

class _BlinkingCircleState extends State<BlinkingCircle>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Animation _colorTween;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 2.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _colorTween = ColorTween(begin: Color(0xFF960018), end: Color(0xFFFF2400))
        .animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 5,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _colorTween.value,
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(130, 237, 125, 58),
                blurRadius: _animation.value,
                spreadRadius: _animation.value)
          ]),
    );
  }
}
