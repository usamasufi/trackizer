import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btntext;
  final Color btnTextColor;
  final double fSize;
  final FontWeight fWeight;
  final double lspacing;
  final ImageProvider? assetImage;
  final double? imageHeight;
  final double? imageWidth;
  final String? fFamily;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.btntext,
    required this.btnTextColor,
    required this.fSize,
    required this.fWeight,
    required this.lspacing,
    this.assetImage,
    this.imageHeight,
    this.imageWidth, this.fFamily,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all<Size>(Size(328, 47.14)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.91),
            side: BorderSide(width: 0.98),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (assetImage != null)
            Image(
              image: assetImage!,
              width: imageWidth,
              height: imageHeight,
              filterQuality: FilterQuality.high,
            ),
          if (assetImage != null) const SizedBox(width: 10),
          SizedBox(width: 6),
          Text(
            btntext,
            style: TextStyle(
              fontFamily: fFamily,
              fontSize: fSize,
              color: btnTextColor,
              fontWeight: fWeight,
              letterSpacing: lspacing,
            ),
          ),
        ],
      ),
    );
  }
}
