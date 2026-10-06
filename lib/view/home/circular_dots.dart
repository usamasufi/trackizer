import 'dart:math';
import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';

class CircularDots extends StatelessWidget {
  final int numberOfDots;
  final double radius;
  final double dotSize;
  final Color dotColor;

  const CircularDots({
    super.key,
    this.numberOfDots = 15,
    this.radius = 50,
    this.dotSize = 3,
    this.dotColor = AppColors.white50Color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (radius * 2) + (dotSize * 2), // Ensuring extra space
      height: (radius * 2) + (dotSize * 2),
      child: Stack(
        alignment: Alignment.center, // Ensuring proper centering
        children: List.generate(numberOfDots, (index) {
          double angle = (index / numberOfDots) * 2 * pi;
          double x = (radius * cos(angle)); // Centered x
          double y = (radius * sin(angle)); // Centered y

          return Positioned(
            left: (radius + x), // Ensure left spacing
            top: (radius + y), // Ensure top spacing
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor,
              ),
            ),
          );
        }),
      ),
    );
  }
}
