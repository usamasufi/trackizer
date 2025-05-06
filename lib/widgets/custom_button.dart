import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String btntext;
  final VoidCallback onPressed;
  final double fSize;
  final FontWeight fWeight;
  const CustomButton({
    super.key,
    required this.btntext,
    required this.onPressed,
    required this.fSize, required this.fWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
        fixedSize: WidgetStateProperty.all(Size(328, 48)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        btntext,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontFamily: 'Manrope',
          fontWeight: fWeight,
          fontSize: fSize,
          letterSpacing: -0.28,
        ),
      ),
    );
  }
}
