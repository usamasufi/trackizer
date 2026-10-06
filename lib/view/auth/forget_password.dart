import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
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
                ),
                SizedBox(height: 120),
                CustomButton(
                  btntext: 'Send email',
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.otpScreen);
                  },
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
