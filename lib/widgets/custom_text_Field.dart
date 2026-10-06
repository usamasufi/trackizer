// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackizer/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController cController;
  final bool obscureText;
  final double textSize;
  final double textLetterSpacing;
  final String? hintText;
  final Widget? suffix;
  final TextInputType? kTpye;
  final bool aFocus;
  final Widget? suffixIcon;
  final double hintTextSize;
  final Color hintTextColor;
  final double hintTextLetterSpacing;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validateFunction;
  const CustomTextField({
    super.key,
    required this.cController,
    this.obscureText = true,
    this.textSize = 14,
    this.textLetterSpacing = -0.28,
    this.hintText,
    this.suffix,
    this.kTpye,
    this.aFocus = true,
    this.suffixIcon,
    this.hintTextSize = 12,
    this.hintTextColor = AppColors.fieldTextColor,
    this.hintTextLetterSpacing = -0.28,
    this.inputFormatters,
    this.readOnly,
    this.validateFunction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.all(16),
      controller: cController,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      readOnly: readOnly ?? false,
      style: TextStyle(
        fontFamily: 'Manrope',
        color: AppColors.whiteColor,
        fontSize: textSize,
        letterSpacing: textLetterSpacing,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Manrope',
          color: hintTextColor,
          fontSize: hintTextSize,
          letterSpacing: hintTextLetterSpacing,
        ),
        suffixIcon: suffixIcon,
        suffix: suffix,

        suffixStyle: TextStyle(
          fontFamily: 'Manrope',
          color: AppColors.primaryColor,
          fontSize: 12,
          letterSpacing: -0.28,
          fontWeight: FontWeight.w500,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        filled: true,
        fillColor: AppColors.textFieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(width: 1),
        ),
      ),
      keyboardType: kTpye,
      validator: validateFunction,
      
    );
  }
}
