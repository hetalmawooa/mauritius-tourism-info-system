import 'package:flutter/material.dart';

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // Approximate shape of Mauritius using a Path
    final path = Path();

    // Starting from the northern tip
    path.moveTo(size.width * 0.5, size.height * 0.1);

    // Drawing the outline clockwise
    path.lineTo(size.width * 0.7, size.height * 0.15);
    path.lineTo(size.width * 0.8, size.height * 0.3);
    path.lineTo(size.width * 0.85, size.height * 0.5);
    path.lineTo(size.width * 0.8, size.height * 0.7);
    path.lineTo(size.width * 0.6, size.height * 0.85);
    path.lineTo(size.width * 0.4, size.height * 0.9);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.15, size.height * 0.6);
    path.lineTo(size.width * 0.2, size.height * 0.4);
    path.lineTo(size.width * 0.3, size.height * 0.2);
    path.close();

    canvas.drawPath(path, paint);

    // Draw outline
    final outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}