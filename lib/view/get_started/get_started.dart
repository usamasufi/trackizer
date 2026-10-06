import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/widgets/custom_button.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        image: DecorationImage(image: AssetImage('assets/images/group1.png')),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,
        body: Column(
          children: [
            SizedBox(height: 55),
            Image(image: AssetImage('assets/images/logo.png'), height: 29),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Congue malesuada in ac justo, a tristique leo massa. Arcu leo leo urna risus.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                      fontFamily: 'Manrope',
                    ),
                  ),

                  SizedBox(height: 20),
                  CustomButton(
                    btntext: 'Get Started',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.getStartedScreen);
                    },
                    fSize: 16,
                    fWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 25),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Alredy have an Account? ',
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
                                    (route) => false,
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
