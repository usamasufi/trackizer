import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/widgets/custom_outlined_button.dart';
import 'package:trackizer/widgets/custom_text.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/netflix.jpeg'),
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(197, 0, 0, 0),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: Column(
            children: [
              SizedBox(height: 65),
              Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 24,
                ),
              ),
              SizedBox(height: 20),
              CustomText(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod magna aliqua.',
                tColor: AppColors.whiteColor,
                tAlign: TextAlign.center,
              ),
              SizedBox(height: 103),
              CustomOutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                fFamily: 'SF Pro',
                btntext: 'Continue with Email Address',
                assetImage: AssetImage('assets/images/mail.png'),
                imageWidth: 17.68,
                btnTextColor: AppColors.whiteColor,
                fSize: 13.75,
                fWeight: FontWeight.w500,
                lspacing: -.27,
              ),
              SizedBox(height: 12),
              CustomOutlinedButton(
                onPressed: () {},
                fFamily: 'SF Pro',
                btntext: 'Continue with Apple ID',
                assetImage: AssetImage('assets/images/apple.png'),
                imageHeight: 17.68,
                btnTextColor: AppColors.whiteColor,
                fSize: 13.75,
                fWeight: FontWeight.w500,
                lspacing: -.27,
              ),
              SizedBox(height: 12),
              CustomOutlinedButton(
                onPressed: () {},
                fFamily: 'SF Pro',
                btntext: 'Continue with Facebook',
                assetImage: AssetImage('assets/images/facebook.png'),
                imageHeight: 17.68,
                btnTextColor: AppColors.whiteColor,
                fSize: 13.75,
                fWeight: FontWeight.w500,
                lspacing: -.27,
              ),
              SizedBox(height: 12),
              CustomOutlinedButton(
                onPressed: () {},
                fFamily: 'SF Pro',
                btntext: 'Continue with Google',
                assetImage: AssetImage('assets/images/google.png'),
                imageHeight: 17.68,
                btnTextColor: AppColors.whiteColor,
                fSize: 13.75,
                fWeight: FontWeight.w500,
                lspacing: -.27,
              ),
              SizedBox(height: 20),
              CustomText(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore',
                tColor: AppColors.whiteColor,
                tAlign: TextAlign.start,
                fWeight: FontWeight.w600,
              ),
              Spacer(),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Automatic payment, can be cancelled at any time ',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.whiteColor,
                        letterSpacing: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'Terms of Service ',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        letterSpacing: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'and ',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.whiteColor,
                        letterSpacing: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
