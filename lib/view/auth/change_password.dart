import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                obscureText: false,
                hintText: 'New Password',
                hintTextSize: 13,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
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
                obscureText: false,
                hintText: 'Confirm Password',
                hintTextSize: 13,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),
              SizedBox(height: 100),
              CustomButton(
                btntext: 'Continue',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (routes) => false,
                  );
                },
                fSize: 16,
                fWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
