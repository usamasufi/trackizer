import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trackizer/database/db_helper.dart';
import 'package:trackizer/database/db_model.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final dbHelper = DBHelper();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final incomeController = TextEditingController();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    final data = await dbHelper.getExpenseDetails();
    final profile = data.firstWhere(
      (e) => e.isFrom == 'Profile',
      orElse:
          () => ExpenseManagementModel(
            isFrom: 'Profile',
            categoryName: '',
            amount: '',
          ),
    );

    setState(() {
      nameController.text = profile.categoryName;
      incomeController.text = profile.amount;
      if (profile.imagePath != null && profile.imagePath!.isNotEmpty) {
        _pickedImage = File(profile.imagePath!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          surfaceTintColor: AppColors.bgColor,
          backgroundColor: AppColors.bgColor,
          title: CustomText(
            text: 'Edit Profile',
            tColor: AppColors.whiteColor,
            fSize: 16,
            fWeight: FontWeight.w600,
            lspacing: 0.2,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.whiteColor),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xff67ce67),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: 12),
                  CustomText(
                    text: 'Avatar',
                    tColor: AppColors.whiteColor,
                    fSize: 16,
                  ),
                ],
              ),
              SizedBox(height: 29),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            _pickedImage != null
                                ? FileImage(_pickedImage!)
                                : AssetImage('assets/images/profile.png')
                                    as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 190,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.primaryColor,
                        ),
                        fixedSize: WidgetStateProperty.all(Size(328, 48)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.bgColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              height: 220,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.delete_outline,
                                      color: AppColors.white50Color,
                                    ),
                                    title: CustomText(
                                      text: 'Delete Avatar',
                                      tColor: AppColors.whiteColor,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _pickedImage = null;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    height: 0.5,
                                    color: AppColors.white50Color,
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.upload_rounded,
                                      color: AppColors.white50Color,
                                    ),
                                    title: CustomText(
                                      text: 'Upload from Gallery',
                                      tColor: AppColors.whiteColor,
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      final pickedFile = await ImagePicker()
                                          .pickImage(
                                            source: ImageSource.gallery,
                                          );
                                      if (pickedFile != null) {
                                        setState(() {
                                          _pickedImage = File(pickedFile.path);
                                        });
                                      }
                                    },
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    height: 0.5,
                                    color: AppColors.white50Color,
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.camera_alt_rounded,
                                      color: AppColors.white50Color,
                                    ),
                                    title: CustomText(
                                      text: 'Take a photo',
                                      tColor: AppColors.whiteColor,
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      final pickedFile = await ImagePicker()
                                          .pickImage(
                                            source: ImageSource.camera,
                                          );
                                      if (pickedFile != null) {
                                        setState(() {
                                          _pickedImage = File(pickedFile.path);
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, color: AppColors.whiteColor),
                          SizedBox(width: 8),
                          Text(
                            'Edit Avatar',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              letterSpacing: -0.28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xffec2326),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: 12),
                  CustomText(
                    text: 'Personal Information',
                    tColor: AppColors.whiteColor,
                    fSize: 16,
                  ),
                ],
              ),
              SizedBox(height: 25),
              CustomText(
                text: 'Full Name',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 14,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 16,
                cController: nameController,
                obscureText: false,
                hintText: 'Kevin Backer',
                hintTextSize: 16,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),
              SizedBox(height: 16),
              CustomText(
                text: 'Email Address',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 14,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 16,
                cController: emailController,
                obscureText: false,
                hintText: 'creator@gmail.com',
                hintTextSize: 16,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),
              SizedBox(height: 16),
              CustomText(
                text: 'Monthly Income',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 14,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 16,
                cController: incomeController,
                obscureText: false,
                hintText: '\$25000',
                hintTextSize: 16,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),
              Spacer(),
              CustomButton(
                btntext: 'Update',
                onPressed: () async {
                  await dbHelper.update(
                    ExpenseManagementModel(
                      isFrom: 'Profile',
                      imagePath: _pickedImage!.path,
                      categoryName: nameController.text,
                      amount: incomeController.text,
                    ),
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
