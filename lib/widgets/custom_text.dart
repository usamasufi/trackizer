import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fSize;
  final double lspacing;
  final Color tColor;
  final FontWeight fWeight;
  final TextAlign? tAlign;
  const CustomText({
    super.key,
    required this.text,
    this.fSize = 12,
    this.lspacing = -0.28,
    required this.tColor,
    this.fWeight = FontWeight.w500, this.tAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: tAlign,
      style: TextStyle(
        color: tColor,
        fontSize: fSize,
        letterSpacing: lspacing,
        fontWeight: fWeight,
      ),
    );
  }
}
