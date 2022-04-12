import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';

class DotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final point = TextPainter(
        text: TextSpan(
          text: ".",
          style: wBlackCardHeader500,
        ),
        textDirection: TextDirection.ltr);
    point.layout(maxWidth: size.width);

    for (double i = 0; i < size.width; i += (point.width + 5)) {
      point.paint(canvas, Offset(i, -5));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
