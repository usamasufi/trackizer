import 'package:flutter/material.dart';
import 'package:trackizer/view/auth/change_password.dart';
import 'package:trackizer/view/auth/forget_password.dart';
import 'package:trackizer/view/auth/login.dart';
import 'package:trackizer/view/auth/otp_screen.dart';
import 'package:trackizer/view/auth/register.dart';
import 'package:trackizer/view/calender/calender_screen.dart';
import 'package:trackizer/view/calender/new_subscription.dart';
// import 'package:trackizer/view/calender/subscription_info.dart';
import 'package:trackizer/view/credit_cards/add_new_card.dart';
// import 'package:trackizer/view/credit_cards/credit_cards_screen.dart';
import 'package:trackizer/view/get_started/get_started.dart';
import 'package:trackizer/view/get_started/get_started_screen.dart';
import 'package:trackizer/view/home/home_screen.dart';
import 'package:trackizer/view/home/notification_screen.dart';
import 'package:trackizer/view/settings/settings.dart';
import 'package:trackizer/view/spending_and_budgets/add_new_category_screen.dart';
import 'package:trackizer/view/spending_and_budgets/spending_budeget_screen.dart';
import 'package:trackizer/view/splash/splash_screen.dart';
import 'package:trackizer/widgets/custom_bottom_bar.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String getStarted = '/getStarted';
  static const String getStartedScreen = '/getStartedScreen';
  static const String register = '/register';
  static const String login = '/login';
  static const String forgetPassword = '/forgetPassword';
  static const String otpScreen = '/otp';
  static const String changePassword = '/changePassword';
  static const String customBottomBar = '/customBottomBar';
  static const String newSubscription = '/newSubscription';
  static const String addNewCard = '/addNewCard';
  static const String addNewCategoryScreen = '/addNewCategoryScreen';
  static const String homeScreen = '/homeScreen';
  static const String settings = '/settings';
  static const String notificationScreen = '/notificationScreen';
  // static const String subscriptionInfo = '/subscriptionInfo';
  static const String spendingBudegetScreen = '/spendingBudegetScreen';
  static const String calenderScreen = '/calenderScreen';
  static const String creditCardsScreen = '/creditCardsScreen';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    getStarted: (context) => GetStarted(),
    getStartedScreen: (context) => GetStartedScreen(),
    register: (context) => Register(),
    login: (context) => Login(),
    forgetPassword: (context) => ForgetPassword(),
    otpScreen: (context) => OtpScreen(),
    changePassword: (context) => ChangePassword(),
    customBottomBar: (context) => CustomBottomBar(),
    newSubscription: (context) => NewSubscription(),
    addNewCard: (context) => AddNewCard(),
    addNewCategoryScreen: (context) => AddNewCategoryScreen(),
    homeScreen: (context) => HomeScreen(),
    settings: (context) => Settings(),
    notificationScreen: (context) => NotificationScreen(),
    // subscriptionInfo: (context) => SubscriptionInfo(),
    spendingBudegetScreen: (context) => SpendingBudgetScreen(),
    calenderScreen: (context) => CalenderScreen(),
    // creditCardsScreen: (context) => CreditCardsScreen(),
  };
}
