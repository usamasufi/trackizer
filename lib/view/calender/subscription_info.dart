// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trackizer/database/db_helper.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/widgets/app_layout_builder.dart';
import 'package:trackizer/widgets/custom_bottom_bar.dart';
import 'package:trackizer/widgets/custom_text.dart';

class SubscriptionInfo extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final String name;
  final String description;
  final String category;
  final String creationDate;
  final String cardNo;
  final int id;
  const SubscriptionInfo({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.name,
    required this.description,
    required this.category,
    required this.creationDate,
    required this.cardNo,
    required this.id,
  });

  @override
  State<SubscriptionInfo> createState() => _SubscriptionInfoState();
}

class _SubscriptionInfoState extends State<SubscriptionInfo> {
  final dbHelper = DBHelper();

  String maskCardNumber(String cardNo) {
    if (cardNo.length < 16) return cardNo;

    String lastFour = cardNo.substring(cardNo.length - 4);
    String masked = '**** **** **** $lastFour';
    return masked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.bgColor,
        backgroundColor: AppColors.bgColor,
        title: CustomText(
          text: 'Subscription Info',
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
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: AppColors.bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: CustomText(
                          text: 'Delete item?',
                          tColor: AppColors.whiteColor,
                          fSize: 16,
                          fWeight: FontWeight.w600,
                        ),

                        content: CustomText(
                          text: 'Are you sure you want to delete this item?',
                          tColor: AppColors.white50Color,
                          fSize: 14,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: CustomText(
                              text: 'Cancle',
                              tColor: AppColors.white50Color,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              dbHelper
                                  .delete(widget.id)
                                  .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => CustomBottomBar(
                                              selectedIndex: 0,
                                            ),
                                      ),
                                    );
                                  })
                                  .catchError((error) {});
                            },
                            child: CustomText(
                              text: 'Delete',
                              tColor: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Image(
                  height: 18,
                  image: AssetImage('assets/images/trash.png'),
                ),
              ),
            ),
          ),
          SizedBox(width: 25),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: 15),
              Center(
                child: Card(
                  color: AppColors.bodyColor,
                  child: Container(
                    padding: EdgeInsets.only(top: 29, bottom: 19),
                    width: 328,
                    height: 563,
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.cntrBorderSBColor,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(File(widget.image)),
                            ),
                          ),
                        ),

                        SizedBox(height: 5),
                        CustomText(
                          text: widget.title,
                          tColor: AppColors.whiteColor,
                          fSize: 32,
                          fWeight: FontWeight.w700,
                          lspacing: 0.0,
                        ),
                        CustomText(
                          text: '\$${widget.price}',
                          tColor: AppColors.white50Color,
                          fSize: 20,
                          fWeight: FontWeight.w700,
                          lspacing: 0.0,
                        ),
                        SizedBox(height: 15),
                        AppLayoutBuilder(randomDivider: 15),
                        SizedBox(height: 17),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          width: 288,
                          decoration: BoxDecoration(
                            color: AppColors.bgColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.logTextColor,
                                offset: Offset(-.4, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Name',
                                        tColor: AppColors.whiteColor,
                                        fSize: 14,
                                        fWeight: FontWeight.w600,
                                        lspacing: 0.0,
                                      ),
                                      SizedBox(height: 28),
                                      CustomText(
                                        text: 'Description',
                                        tColor: AppColors.whiteColor,
                                        fSize: 14,
                                        fWeight: FontWeight.w600,
                                        lspacing: 0.0,
                                      ),
                                      SizedBox(height: 28),
                                      CustomText(
                                        text: 'Category',
                                        tColor: AppColors.whiteColor,
                                        fSize: 14,
                                        fWeight: FontWeight.w600,
                                        lspacing: 0.0,
                                      ),
                                      SizedBox(height: 28),
                                      CustomText(
                                        text: 'Creation Date',
                                        tColor: AppColors.whiteColor,
                                        fSize: 14,
                                        fWeight: FontWeight.w600,
                                        lspacing: 0.0,
                                      ),
                                      SizedBox(height: 28),
                                      CustomText(
                                        text: 'Card No.',
                                        tColor: AppColors.whiteColor,
                                        fSize: 14,
                                        fWeight: FontWeight.w600,
                                        lspacing: 0.0,
                                      ),
                                      SizedBox(height: 28),
                                      CustomText(
                                        text: 'Price',
                                        tColor: AppColors.whiteColor,
                                        fSize: 14,
                                        fWeight: FontWeight.w600,
                                        lspacing: 0.0,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CustomText(
                                        text: widget.name,
                                        tColor: AppColors.white50Color,
                                        fSize: 12,
                                        lspacing: 0.2,
                                      ),
                                      SizedBox(height: 30),
                                      CustomText(
                                        text: widget.description,
                                        tColor: AppColors.white50Color,
                                        fSize: 12,
                                        lspacing: 0.2,
                                      ),
                                      SizedBox(height: 30),
                                      CustomText(
                                        text: widget.category,
                                        tColor: AppColors.white50Color,
                                        fSize: 12,
                                        lspacing: 0.2,
                                      ),
                                      SizedBox(height: 30),
                                      CustomText(
                                        text: widget.creationDate,
                                        tColor: AppColors.white50Color,
                                        fSize: 12,
                                        lspacing: 0.2,
                                      ),
                                      SizedBox(height: 30),
                                      CustomText(
                                        text: maskCardNumber(widget.cardNo),
                                        tColor: AppColors.white50Color,
                                        fSize: 12,
                                        lspacing: 0.2,
                                      ),
                                      SizedBox(height: 30),
                                      CustomText(
                                        text: widget.price,
                                        tColor: AppColors.white50Color,
                                        fSize: 12,
                                        lspacing: 0.2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 225,
            left: 8,
            child: Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.bgColor,
              ),
            ),
          ),
          Positioned(
            top: 225,
            right: 8,
            child: Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.bgColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
