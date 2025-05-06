import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';

class AppLayoutBuilder extends StatelessWidget {
  final int randomDivider;
  final double width;
  final bool? isColor;
  const AppLayoutBuilder({
    super.key,
    required this.randomDivider,
    this.width = 5,
    this.isColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (boxConstraints, constraints) {
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(
            (constraints.constrainWidth() / randomDivider).floor(),
            (index) => SizedBox(
              width: width,
              height: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: isColor == null ? AppColors.bgColor : Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
