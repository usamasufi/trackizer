import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {     
      FirebaseAuth.instance.currentUser != null
          ? Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.customBottomBar,
            (route) => false,
          )
          : Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.getStarted,
            (route) => false,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'),
          filterQuality: FilterQuality.high,
          height: 29,
          width: 178,
        ),
      ),
    );
  }
}
