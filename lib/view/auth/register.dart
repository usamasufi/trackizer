// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool isChecked = false;
  bool isObscured = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailandPassword() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: 'The password provided is too weak.',
          gravity: ToastGravity.TOP,
          fontSize: 14,
          backgroundColor: AppColors.bgColor,
          textColor: AppColors.whiteColor,
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'The account already exists for that email.',
          gravity: ToastGravity.TOP,
          fontSize: 14,
          backgroundColor: AppColors.bgColor,
          textColor: AppColors.whiteColor,
        );
      } else {
        Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          fontSize: 14,
          backgroundColor: AppColors.bgColor,
          textColor: AppColors.whiteColor,
        );
      }
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
                  text: 'Full Name',
                  tColor: AppColors.whiteColor,
                  fSize: 14,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  cController: nameController,
                  hintText: 'Enter your full name',
                  obscureText: false,
                  validateFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    } else if (value.length < 5) {
                      return 'Name must be at least 5 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 28),
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
                    child: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  validateFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        isChecked = !isChecked;
                        setState(() {});
                      },
                      child: Icon(
                        isChecked == false
                            ? Icons.check_box_outline_blank_rounded
                            : Icons.check_box,
                        color:
                            isChecked == false
                                ? AppColors.fieldTextColor
                                : AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text.rich(
                      textAlign: TextAlign.start,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'By checking this you agree to our ',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.logTextColor,
                              letterSpacing: -.28,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of\nServices',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.primaryColor,
                              letterSpacing: -.28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                CustomButton(
                  btntext: 'Create Account',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (isChecked == true) {
                        await createUserWithEmailandPassword();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.customBottomBar,
                          (routes) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomText(
                              text: 'Please accept the terms of services.',
                              tColor: AppColors.whiteColor,
                              lspacing: 0.2,
                              fSize: 14,
                            ),
                            backgroundColor: AppColors.bgColor,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: CustomText(
                            text: 'Please fill in all fields.',
                            tColor: AppColors.whiteColor,
                            lspacing: 0.2,
                            fSize: 14,
                          ),
                          backgroundColor: AppColors.bgColor,
                        ),
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
                          text: 'Already have an Account? ',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.txtColor,
                            letterSpacing: 0.2,
                          ),
                        ),
                        TextSpan(
                          text: 'LOGIN',
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
                                    AppRoutes.login,
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
