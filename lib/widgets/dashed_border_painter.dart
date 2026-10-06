import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = AppColors.cntrBorderSBColor
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    double dashWidth = 4, dashSpace = 5;
    double radius = 16;

    Path path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(radius),
          ),
        );

    PathMetrics pathMetrics = path.computeMetrics();

    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0;
      while (distance < pathMetric.length) {
        Tangent? tangentStart = pathMetric.getTangentForOffset(distance);
        Tangent? tangentEnd = pathMetric.getTangentForOffset(
          distance + dashWidth,
        );

        if (tangentStart != null && tangentEnd != null) {
          canvas.drawLine(tangentStart.position, tangentEnd.position, paint);
        }

        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
