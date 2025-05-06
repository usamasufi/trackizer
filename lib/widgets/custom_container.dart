import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double width;
  final Color lineColor;
  final String text;
  final String? secondtext;
  final Color textColor;
  final BorderRadius? borderRadius;
  final FontWeight fontWeight;
  const CustomContainer({
    super.key,
    this.height,
    required this.width,
    required this.lineColor,
    required this.text,
    this.secondtext,
    this.borderRadius,
    this.textColor = AppColors.homeTextColor,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(12.0),

      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.textFieldBorderColor,
            offset: Offset(-0.5, -0.5),
            blurRadius: 0.1,
            blurStyle: BlurStyle.solid,
          ),
        ],
        borderRadius: borderRadius,
        color: AppColors.homeRowColor,
        border: Border(top: BorderSide(color: lineColor, width: 2)),
      ),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12,
              fontWeight: fontWeight,
              letterSpacing: 0,
              color: textColor,
            ),
          ),
          SizedBox(height: 6),
          if (secondtext != null)
            Text(
              secondtext!,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
                color: AppColors.whiteColor,
              ),
            ),
        ],
      ),
    );
  }
}
