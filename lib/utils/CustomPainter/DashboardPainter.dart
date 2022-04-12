import 'package:flutter/material.dart';
import 'package:wmobil/constants/colors.dart';

class DashboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint()
        ..color = wColorsBrand
        ..style = PaintingStyle.fill;

    var path = Path()
        ..moveTo(0, size.height / 5)
        ..quadraticBezierTo(size.width /2, size.height * 0.3, size.width, size.height * 0.2)
        ..lineTo(size.width, 0)
        ..lineTo(0, 0);

    canvas.drawPath(path, paint);

    var paintFill = Paint()
        ..color = Color(0xFFF0F3F7)
        ..style = PaintingStyle.fill;

    var pathFill = Path()
        ..moveTo(0, size.height * 0.21)
        ..lineTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, size.height * 0.21)
        ..quadraticBezierTo(size.width / 2, size.height * 0.3, 0, size.height * 0.21);

    canvas.drawPath(pathFill, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}