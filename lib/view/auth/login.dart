// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscured = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUserWithEmailPassword() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.bodyColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 65),
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
                    } else if (!RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 28),
                CustomText(
                  tAlign: TextAlign.center,
                  text: 'Password',
                  tColor: AppColors.whiteColor,
                  fSize: 14,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  cController: passwordController,
                  hintText: '*******',
                  obscureText: isObscured,

                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    child: Text(isObscured ? 'show' : 'hide'),
                  ),
                  validateFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.forgetPassword);
                    },
                    child: CustomText(
                      text: 'Forget Password?',
                      tColor: AppColors.primaryColor,
                      fSize: 14,
                      lspacing: 0.2,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                CustomButton(
                  btntext: 'Confirm',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await loginUserWithEmailPassword();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.customBottomBar,
                        (routes) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields.')),
                      );
                    }
                  },
                  fSize: 16,
                  fWeight: FontWeight.w600,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an Account? ',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.txtColor,
                            letterSpacing: 0.2,
                          ),
                        ),
                        TextSpan(
                          text: 'REGISTER',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.primaryColor,
                            letterSpacing: 0.2,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.register,
                                    (routes) => false,
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
