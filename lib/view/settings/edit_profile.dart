import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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
            categoryName: FirebaseAuth.instance.currentUser?.displayName ?? '',
            amount: '',
            description: FirebaseAuth.instance.currentUser?.email ?? '',
          ),
    );

    if (!mounted) return;
    setState(() {
      nameController.text = profile.categoryName;
      emailController.text =
          profile.description ?? FirebaseAuth.instance.currentUser?.email ?? '';
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
        body: SingleChildScrollView(
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
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  btntext: 'Update',
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.maybeOf(context);
                    final navigator = Navigator.of(context);
                    final currentUser = FirebaseAuth.instance.currentUser;
                    final trimmedName = nameController.text.trim();
                    final trimmedEmail = emailController.text.trim();
                    final trimmedIncome = incomeController.text.trim();

                    if (trimmedName.isEmpty || trimmedEmail.isEmpty) {
                      messenger?.showSnackBar(
                        SnackBar(content: Text('Name and email are required.')),
                      );
                      return;
                    }

                    final existingProfiles = await dbHelper.getExpenseDetails();
                    final profileMatch = existingProfiles.firstWhere(
                      (entry) => entry.isFrom == 'Profile',
                      orElse:
                          () => ExpenseManagementModel(
                            isFrom: 'Profile',
                            categoryName: trimmedName,
                            amount: trimmedIncome,
                            description: trimmedEmail,
                            imagePath: _pickedImage?.path,
                          ),
                    );

                    final profile = ExpenseManagementModel(
                      id: profileMatch.id,
                      isFrom: 'Profile',
                      imagePath: _pickedImage?.path,
                      categoryName: trimmedName,
                      amount: trimmedIncome,
                      description: trimmedEmail,
                    );

                    try {
                      if (profileMatch.id == null) {
                        await dbHelper.insert(profile);
                      } else {
                        await dbHelper.update(profile);
                      }

                      if (currentUser != null) {
                        try {
                          await currentUser.updateDisplayName(trimmedName);
                          if (currentUser.email != trimmedEmail) {
                            await currentUser.verifyBeforeUpdateEmail(
                              trimmedEmail,
                            );
                          }
                        } catch (_) {
                          // Keep local profile data consistent even if auth email update is blocked.
                        }
                      }

                      if (!mounted) return;
                      messenger?.showSnackBar(
                        SnackBar(
                          content: Text('Profile updated successfully.'),
                        ),
                      );
                      navigator.pop();
                    } catch (error) {
                      if (!mounted) return;
                      messenger?.showSnackBar(
                        SnackBar(
                          content: Text('Failed to update profile: $error'),
                        ),
                      );
                    }
                  },
                  fSize: 16,
                  fWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
