import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset link sent to your email.'),
          backgroundColor: AppColors.bgColor,
        ),
      );
      Navigator.pushNamed(context, AppRoutes.login);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Unable to send reset email.'),
          backgroundColor: AppColors.bgColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: 'Forget Password',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
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
                    tAlign: TextAlign.center,
                    text: 'Email Address',
                    tColor: AppColors.whiteColor,
                    fSize: 14,
                  ),
                  SizedBox(height: 8),
                  CustomTextField(
                    cController: emailController,
                    hintText: 'Enter your email address',
                    kTpye: TextInputType.emailAddress,
                    obscureText: false,
                    validateFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }

                      final emailRegExp = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );
                      if (!emailRegExp.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 120),
                  CustomButton(
                    btntext: 'Send email',
                    onPressed: sendResetEmail,
                    fSize: 16,
                    fWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
