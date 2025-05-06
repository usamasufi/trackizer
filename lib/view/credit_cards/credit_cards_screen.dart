import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trackizer/database/db_helper.dart';
import 'package:trackizer/database/db_model.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/view/credit_cards/no_card.dart';
import 'package:trackizer/view/home/notification_screen.dart';
import 'package:trackizer/view/settings/settings.dart';
import 'package:trackizer/widgets/custom_text.dart';

class CreditCardsScreen extends StatefulWidget {
  const CreditCardsScreen({super.key});

  @override
  State<CreditCardsScreen> createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  final DBHelper dbHelper = DBHelper();
  List<ExpenseManagementModel> cardList = [];
  List<ExpenseManagementModel> subList = [];
  String? selectedCardNumber;

  Future<void> initValues() async {
    cardList = await dbHelper.getExpenseDetails();
    subList = await dbHelper.getExpenseDetails();
    final filteredCards = cardList.where((e) => e.isFrom == 'Card').toList();
    if (filteredCards.isNotEmpty) {
      selectedCardNumber = filteredCards.first.cardNumber;
    }
    setState(() {});
  }

  @override
  void initState() {
    initValues();
    super.initState();
  }

  String maskCardNumber(String cardNo) {
    if (cardNo.length < 16) return cardNo;

    String lastFour = cardNo.substring(cardNo.length - 4);
    String masked = '**** **** **** $lastFour';
    return masked;
  }

  @override
  Widget build(BuildContext context) {
    final List<ExpenseManagementModel> filteredSubList =
        subList
            .where(
              (element) =>
                  element.isFrom == 'Subscription' &&
                  element.cardNumber == selectedCardNumber,
            )
            .toList();
    final List<ExpenseManagementModel> filteredList =
        cardList.where((element) => element.isFrom == 'Card').toList();
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Settings();
                  },
                ),
              );
            },
            child: Image(
              image: AssetImage('assets/images/profile.png'),
              height: 30,
            ),
          ),
        ),
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: AppColors.bgColor,

        centerTitle: true,
        title: CustomText(
          text: 'Credit Cards',
          tColor: AppColors.whiteColor,
          fSize: 16,
          fWeight: FontWeight.w600,
          lspacing: 0.2,
        ),
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
                      builder: (context) {
                        return NotificationScreen();
                      },
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
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Align(
            alignment: Alignment.center,
            child:
                filteredList.isEmpty
                    ? NoCard()
                    : Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * .54,
                          child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                selectedCardNumber =
                                    filteredList[index].cardNumber;
                              });
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              var card = filteredList[index];

                              return Container(
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff252530),
                                      Color(0xff30303A),
                                      Color(0xff444454),
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xff36363F)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(
                                        0xff444453,
                                      ).withValues(alpha: .7),
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                      offset: Offset(2, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                          'assets/images/MasterCard Logo.png',
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      CustomText(
                                        text: 'Virtual Card',
                                        tColor: AppColors.whiteColor,
                                        fSize: 16,
                                        fWeight: FontWeight.w600,
                                        lspacing: 0.0,
                                      ),
                                      SizedBox(height: 80),

                                      CustomText(
                                        text: maskCardNumber(
                                          card.cardNumber ?? '',
                                        ),
                                        tColor: AppColors.white50Color,
                                        fSize: 12,
                                        fWeight: FontWeight.w600,
                                        lspacing: 0.0,
                                      ),

                                      SizedBox(height: 8),
                                      CustomText(
                                        text: card.categoryName,
                                        tColor: AppColors.whiteColor,
                                        fSize: 16,
                                        fWeight: FontWeight.w600,
                                        lspacing: 0.0,
                                      ),
                                      SizedBox(height: 8),
                                      CustomText(
                                        text: card.expiryDate!,
                                        tColor: AppColors.whiteColor,
                                        fSize: 14,
                                        fWeight: FontWeight.w600,
                                        lspacing: 0.0,
                                      ),
                                      SizedBox(height: 16),
                                      Image(
                                        image: AssetImage(
                                          'assets/images/Chip.png',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 31),
                        filteredSubList.isEmpty
                            ? CustomText(
                              text: "No subscriptions against this card",
                              tColor: AppColors.whiteColor,
                            )
                            : CustomText(
                              text: 'Subscriptions',
                              tColor: AppColors.whiteColor,
                              lspacing: 0.0,
                              fSize: 16,
                              fWeight: FontWeight.w600,
                            ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: filteredSubList.length,
                            itemBuilder: (context, index) {
                              var sub = filteredSubList[index];
                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.transparentColor,
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(File(sub.imagePath!)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
