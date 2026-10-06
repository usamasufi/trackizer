import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    final newPassword = newPasswordController.text.trim();
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please sign in before changing your password.'),
          backgroundColor: AppColors.bgColor,
        ),
      );
      return;
    }

    try {
      await user.updatePassword(newPassword);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password updated successfully.'),
          backgroundColor: AppColors.bgColor,
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (routes) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Unable to update your password.'),
          backgroundColor: AppColors.bgColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: 'Change Password',
            tColor: AppColors.whiteColor,
            fSize: 16,
            fWeight: FontWeight.w600,
            lspacing: 0.2,
          ),
          centerTitle: true,
          backgroundColor: AppColors.bodyColor,
          surfaceTintColor: AppColors.bodyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.bodyColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 24,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: CustomText(
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing\nelit, sed do eiusmod magna aliqua.',
                    tColor: AppColors.logTextColor,
                    tAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                CustomText(
                  text: 'New Password',
                  tColor: AppColors.addCategoryHeadingColor,
                  fSize: 14,
                  lspacing: 0.2,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  textLetterSpacing: 0.2,
                  textSize: 13,
                  cController: newPasswordController,
                  obscureText: _isObscured,
                  hintText: 'New Password',
                  hintTextSize: 13,
                  hintTextColor: AppColors.white50Color,
                  hintTextLetterSpacing: 0.2,
                  suffix: GestureDetector(
                    onTap: () => setState(() => _isObscured = !_isObscured),
                    child: Text(_isObscured ? 'show' : 'hide'),
                  ),
                  validateFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomText(
                  text: 'Confirm Password',
                  tColor: AppColors.addCategoryHeadingColor,
                  fSize: 14,
                  lspacing: 0.2,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  textLetterSpacing: 0.2,
                  textSize: 13,
                  cController: confirmPasswordController,
                  obscureText: _isObscured,
                  hintText: 'Confirm Password',
                  hintTextSize: 13,
                  hintTextColor: AppColors.white50Color,
                  hintTextLetterSpacing: 0.2,
                  suffix: GestureDetector(
                    onTap: () => setState(() => _isObscured = !_isObscured),
                    child: Text(_isObscured ? 'show' : 'hide'),
                  ),
                  validateFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != newPasswordController.text.trim()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 100),
                CustomButton(
                  btntext: 'Continue',
                  onPressed: updatePassword,
                  fSize: 16,
                  fWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
