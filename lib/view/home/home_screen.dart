import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:trackizer/database/db_helper.dart';
import 'package:trackizer/database/db_model.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/view/calender/subscription_info.dart';
import 'package:trackizer/view/home/circular_dots.dart';
import 'package:trackizer/widgets/custom_container.dart';
import 'package:trackizer/widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final dbHelper = DBHelper();
  List<ExpenseManagementModel> subList = [];
  Future<void> initValues() async {
    subList = await dbHelper.getExpenseDetails();
    setState(() {});
  }

  @override
  void initState() {
    initValues();
    super.initState();
  }

  String _getMonthFromDate(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return '';
    }
    try {
      List<String> dateParts = expiryDate.split('-');
      if (dateParts.length == 3) {
        String formattedDate =
            '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';
        DateTime date = DateTime.parse(formattedDate);
        return _monthName(date.month);
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  String _getDayFromDate(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return '';
    }
    try {
      List<String> dateParts = expiryDate.split('-');
      if (dateParts.length == 3) {
        String formattedDate =
            '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';
        DateTime date = DateTime.parse(formattedDate);
        return date.day.toString();
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  String _monthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final List<ExpenseManagementModel> filteredList =
        subList.where((element) => element.isFrom == 'Subscription').toList();
    final usedCardNumbers = filteredList.map((sub) => sub.cardNumber).toSet();

    final List<ExpenseManagementModel> usedCards =
        subList
            .where(
              (item) =>
                  item.isFrom == 'Card' &&
                  usedCardNumbers.contains(item.cardNumber),
            )
            .toList();

    double totalUsedCardAmount = usedCards.fold(0.0, (sum, item) {
      return sum + (double.tryParse(item.amount.toString()) ?? 0);
    });

    final highestSub =
        filteredList.isNotEmpty
            ? filteredList.reduce(
              (a, b) =>
                  (double.tryParse(a.amount.toString()) ?? 0) >
                          (double.tryParse(b.amount.toString()) ?? 0)
                      ? a
                      : b,
            )
            : null;

    final lowestSub =
        filteredList.isNotEmpty
            ? filteredList.reduce(
              (a, b) =>
                  (double.tryParse(a.amount.toString()) ?? 0) <
                          (double.tryParse(b.amount.toString()) ?? 0)
                      ? a
                      : b,
            )
            : null;

    double totalSpent = filteredList.fold(0.0, (sum, item) {
      return sum + (double.tryParse(item.amount.toString()) ?? 0);
    });

    var controller = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.settings);
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
        title: Image(
          image: AssetImage('assets/images/logo.png'),
          height: 20.93,
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
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.notificationScreen);
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
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 15),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularDots(radius: 80, numberOfDots: 80),
                    SleekCircularSlider(
                      min: 0,
                      max: totalUsedCardAmount < 10 ? 10 : totalUsedCardAmount,
                      initialValue: totalSpent,
                      appearance: CircularSliderAppearance(
                        animDurationMultiplier: .05,
                        size: 220,
                        customColors: CustomSliderColors(
                          progressBarColor: AppColors.primaryColor,
                          trackColor: AppColors.textFieldBorderColor,
                          dotColor: Colors.transparent,
                        ),
                        customWidths: CustomSliderWidths(
                          shadowWidth: 20,
                          progressBarWidth: 15,
                          trackWidth: 15,
                        ),
                      ),

                      innerWidget: (double value) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/images/logo.png'),
                              height: 20,
                              width: 80,
                            ),
                            SizedBox(height: 8),
                            CustomText(
                              text: '\$${value.toInt()}',
                              tColor: AppColors.whiteColor,
                              fSize: 32,
                              fWeight: FontWeight.w700,
                              lspacing: 0,
                            ),
                            SizedBox(height: 5),
                            CustomText(
                              text: 'spent out of',
                              tColor: AppColors.homeTextColor,
                              tAlign: TextAlign.center,
                              lspacing: 0,
                            ),
                            CustomText(
                              text:
                                  '\$${totalUsedCardAmount.toStringAsFixed(2)}',
                              tColor: AppColors.whiteColor,
                              tAlign: TextAlign.center,
                              lspacing: 0,
                              fSize: 14,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return Expanded(
                    child: CustomContainer(
                      borderRadius: BorderRadius.circular(15),
                      width: double.infinity,
                      text:
                          index == 0
                              ? 'Active Subs'
                              : index == 1
                              ? 'Highest Subs'
                              : 'Lowest Subs',
                      secondtext:
                          index == 0
                              ? filteredList.length.toString()
                              : index == 1
                              ? highestSub != null
                                  ? '\$${(double.tryParse(highestSub.amount.toString()) ?? 0).toStringAsFixed(2)}'
                                  : 'N/A'
                              : lowestSub != null
                              ? '\$${(double.tryParse(lowestSub.amount.toString()) ?? 0).toStringAsFixed(2)}'
                              : 'N/A',
                      lineColor:
                          index == 0
                              ? AppColors.firstLineColor
                              : index == 1
                              ? AppColors.secondLineColor
                              : AppColors.thirdLineColor,
                    ),
                  );
                }),
              ),
              SizedBox(height: 10),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.bodyColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TabBar(
                  indicatorPadding: EdgeInsets.all(4),
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 9),
                  controller: controller,
                  indicatorWeight: 0.0,
                  dividerColor: AppColors.transparentColor,
                  unselectedLabelStyle: TextStyle(
                    color: AppColors.white50Color,
                  ),
                  indicatorColor: AppColors.homeRowColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Color(0xff30303C),
                  ),
                  tabs: [
                    Tab(
                      child: CustomText(
                        text: 'Your subscriptions',
                        tColor: AppColors.whiteColor,
                        lspacing: 0,
                        fWeight: FontWeight.w600,
                      ),
                    ),
                    Tab(
                      child: CustomText(
                        text: 'Upcoming bills',
                        tColor: AppColors.whiteColor,
                        lspacing: 0,
                        fWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight:
                          filteredList.isEmpty ? 0 : constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: TabBarView(
                        controller: controller,
                        children: [
                          SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            child: Column(
                              children:
                                  filteredList.map((sub) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => SubscriptionInfo(
                                                  image: sub.imagePath!,
                                                  title: sub.categoryName,
                                                  price: sub.amount,
                                                  name: sub.categoryName,
                                                  description: sub.description!,
                                                  category: sub.subCategory!,
                                                  creationDate: sub.startDate!,
                                                  cardNo: sub.cardNumber!,
                                                  id: sub.id!,
                                                ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: AppColors.homeRowColor,
                                          ),
                                        ),
                                        child: ListTile(
                                          leading: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: AppColors.transparentColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: FileImage(
                                                  File(sub.imagePath!),
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: CustomText(
                                            text: sub.categoryName,
                                            tColor: AppColors.whiteColor,
                                            fWeight: FontWeight.w600,
                                            fSize: 16,
                                            lspacing: 0.0,
                                          ),
                                          trailing: CustomText(
                                            text: '\$${sub.amount}',
                                            tColor: AppColors.whiteColor,
                                            fWeight: FontWeight.w600,
                                            fSize: 14,
                                            lspacing: 0.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                          SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            child: Column(
                              children:
                                  filteredList.map((bill) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: AppColors.homeRowColor,
                                        ),
                                      ),
                                      child: ListTile(
                                        leading: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Color(0xff353542),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 4),
                                              CustomText(
                                                text: _getMonthFromDate(
                                                  bill.expiryDate!,
                                                ),
                                                lspacing: 0.2,
                                                fSize: 10,
                                                tColor: AppColors.logoBoxColor,
                                              ),
                                              CustomText(
                                                text: _getDayFromDate(
                                                  bill.expiryDate!,
                                                ),
                                                lspacing: 0.0,
                                                fSize: 14,
                                                tColor: AppColors.logoBoxColor,
                                                fWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ),
                                        title: CustomText(
                                          text: bill.categoryName,
                                          tColor: AppColors.whiteColor,
                                          fWeight: FontWeight.w600,
                                          fSize: 16,
                                          lspacing: 0.0,
                                        ),
                                        trailing: CustomText(
                                          text: '\$${bill.amount}',
                                          tColor: AppColors.whiteColor,
                                          fWeight: FontWeight.w600,
                                          fSize: 14,
                                          lspacing: 0.0,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
