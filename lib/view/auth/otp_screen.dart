import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bodyColor,
        appBar: AppBar(
          title: CustomText(
            text: 'OTP Verification',
            tColor: AppColors.whiteColor,
            fSize: 16,
            fWeight: FontWeight.w600,
            lspacing: 0.2,
          ),
          centerTitle: true,
          backgroundColor: AppColors.bodyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.whiteColor),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
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
                text: 'Enter the OTP sent to your email address',
                tColor: AppColors.whiteColor,
                fSize: 14,
                lspacing: 0.2,
              ),
              SizedBox(height: 30),
              PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                textStyle: TextStyle(color: AppColors.whiteColor),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeColor: AppColors.primaryColor,
                  selectedColor: AppColors.primaryColor,
                  inactiveColor: AppColors.fieldTextColor,
                  activeFillColor: AppColors.bodyColor,
                  inactiveFillColor: AppColors.transparentColor,
                  selectedFillColor: AppColors.transparentColor,
                ),
                animationDuration: Duration(milliseconds: 250),
                enableActiveFill: true,
                onChanged: (value) {},
              ),
              SizedBox(height: 50),
              CustomButton(
                btntext: 'Verify',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.changePassword);
                },
                fSize: 16,
                fWeight: FontWeight.w600,
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                child: CustomText(
                  text: 'Resend code',
                  tColor: AppColors.primaryColor,
                  fSize: 12,
                  lspacing: 0.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
