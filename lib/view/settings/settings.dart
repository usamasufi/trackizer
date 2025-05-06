import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/database/db_helper.dart';
import 'package:trackizer/database/db_model.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/view/home/notification_screen.dart';
import 'package:trackizer/view/settings/edit_profile.dart';
import 'package:trackizer/view/settings/select_currency.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final dbHelper = DBHelper();
  final user = FirebaseAuth.instance.currentUser;
  List<ExpenseManagementModel> profileList = [];
  bool isSwitched = false;
  bool isThemeWhite = false;
  Future<void> initValues() async {
    profileList = await dbHelper.getExpenseDetails();
    setState(() {});
  }

  @override
  void initState() {
    initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ExpenseManagementModel> filteredList =
        profileList.where((element) => element.isFrom == 'Profile').toList();
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.bgColor,
        backgroundColor: AppColors.bgColor,
        title: CustomText(
          text: 'Settings',
          tColor: AppColors.whiteColor,
          fSize: 16,
          fWeight: FontWeight.w600,
          lspacing: 0.2,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        actions: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textFieldBorderColor),
              shape: BoxShape.circle,
              color: AppColors.textFieldColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                },
                child: Image(
                  height: 18,
                  image: AssetImage('assets/images/notification-bing.png'),
                ),
              ),
            ),
          ),
          SizedBox(width: 25),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.5,
                        ),
                        shape: BoxShape.circle,
                        image:
                            filteredList.isNotEmpty &&
                                    filteredList.first.imagePath != null
                                ? DecorationImage(
                                  image: FileImage(
                                    File(filteredList.first.imagePath!),
                                  ),
                                  fit: BoxFit.cover,
                                )
                                : DecorationImage(
                                  image: AssetImage(
                                    'assets/images/profile.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: '${user?.displayName}',
                      tColor: AppColors.whiteColor,
                      fSize: 22,
                      fWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: '${user?.email}',
                      tColor: AppColors.white50Color,
                      fSize: 14,
                      fWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 222,
                      child: CustomButton(
                        btntext: 'Edit Profile',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(),
                            ),
                          );
                        },
                        fSize: 14,
                        fWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              SizedBox(height: 25),
              CustomText(
                text: 'My subscriptions',
                tColor: AppColors.whiteColor,
                fSize: 14,
                fWeight: FontWeight.w600,
                lspacing: 0.0,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.bodyColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textFieldBorderColor,
                      offset: Offset(-0.8, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectCurrency(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.money_outlined, color: Color(0xffc1c1cd)),
                          SizedBox(width: 20),
                          CustomText(
                            text: 'Default currency',
                            tColor: AppColors.whiteColor,
                            fSize: 14,
                            fWeight: FontWeight.w600,
                            lspacing: 0.0,
                          ),
                          Spacer(),
                          CustomText(
                            text: 'USD',
                            tColor: AppColors.white50Color,
                            fSize: 12,
                            fWeight: FontWeight.w500,
                            lspacing: 0.2,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.white50Color,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              CustomText(
                text: 'Appearance',
                tColor: AppColors.whiteColor,
                fSize: 14,
                fWeight: FontWeight.w600,
                lspacing: 0.0,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.bodyColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textFieldBorderColor,
                      offset: Offset(-0.8, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.light_mode_outlined,
                          color: Color(0xffc1c1cd),
                        ),
                        SizedBox(width: 20),
                        CustomText(
                          text: 'Theme',
                          tColor: AppColors.whiteColor,
                          fSize: 14,
                          fWeight: FontWeight.w600,
                          lspacing: 0.0,
                        ),
                        Spacer(),
                        SizedBox(
                          height: 24,
                          child: Switch(
                            trackOutlineWidth: WidgetStateProperty.all(0),
                            inactiveThumbColor: AppColors.whiteColor,
                            inactiveTrackColor: AppColors.cntrBorderSBColor,
                            activeColor: AppColors.primaryColor,
                            activeTrackColor: AppColors.whiteColor,
                            value: isThemeWhite,
                            onChanged: (value) {
                              setState(() {
                                isThemeWhite = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              CustomText(
                text: 'Other Settings',
                tColor: AppColors.whiteColor,
                fSize: 14,
                fWeight: FontWeight.w600,
                lspacing: 0.0,
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (routes) => false,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.bodyColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textFieldBorderColor,
                        offset: Offset(-0.8, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.logout_outlined, color: Color(0xffc1c1cd)),
                          SizedBox(width: 20),
                          CustomText(
                            text: 'Log out',
                            tColor: AppColors.whiteColor,
                            fSize: 14,
                            fWeight: FontWeight.w600,
                            lspacing: 0.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
