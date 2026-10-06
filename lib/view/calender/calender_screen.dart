import 'dart:io';
import 'package:intl/intl.dart';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/database/db_helper.dart';
import 'package:trackizer/database/db_model.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/widgets/custom_text.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final dbHelper = DBHelper();
  List<ExpenseManagementModel> subList = [];

  Future<void> initValues() async {
    subList = await dbHelper.getExpenseDetails();
    setState(() {});
  }

  final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    final now = DateTime.now();
    selectedMonth = months[now.month - 1];
    selectedDay = now.day;
    selectedDate = "${now.day}-${now.month}-${now.year}";
    finalDate = dateFormatter.format(now);
    initValues();
    super.initState();
  }

  /// List of months
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  String selectedMonth = "January";
  String selectedDate = '';
  DateTime currentDate = DateTime.now();
  String finalDate = '';
  int selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    final List<ExpenseManagementModel> filteredList =
        subList.where((element) => element.isFrom == 'Subscription').toList();
    final List<ExpenseManagementModel> subscriptionsForSelectedDate =
        filteredList.where((sub) {
          return sub.expiryDate == finalDate;
        }).toList();

    final double totalAmountForSelectedDate = subscriptionsForSelectedDate.fold(
      0.0,
      (sum, item) {
        final amount = double.tryParse(item.amount);
        return sum + (amount ?? 0.0);
      },
    );

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: Image(
            image: AssetImage('assets/images/profile.png'),
            height: 30,
          ),
        ),
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: AppColors.bgColor,

        centerTitle: true,
        title: CustomText(
          text: 'Calendar',
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
              padding: const EdgeInsets.all(5.0),
              child: Image(
                height: 18,
                image: AssetImage('assets/images/notification-bing.png'),
              ),
            ),
          ),
          SizedBox(width: 25),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Subs\nSchedule',
              tColor: AppColors.whiteColor,
              fSize: 40,
              lspacing: 0.0,
              fWeight: FontWeight.w700,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text:
                      '${subscriptionsForSelectedDate.length} subscriptions for today',
                  tColor: AppColors.white50Color,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.homeBtnColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.fieldTextColor.withValues(alpha: .3),
                        offset: Offset(-.5, -.5),
                      ),
                    ],
                  ),
                  child: DropdownButton(
                    alignment: Alignment.bottomCenter,
                    value: selectedMonth,
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    menuMaxHeight: 350,
                    menuWidth: 100,
                    borderRadius: BorderRadius.circular(10),
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    iconEnabledColor: AppColors.primaryColor,
                    elevation: 0,
                    isDense: true,
                    underline: SizedBox(),
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Manrope',
                    ),

                    dropdownColor: AppColors.homeBtnColor,
                    items:
                        months.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value!;
                        final now = DateTime.now();
                        int monthIndex = months.indexOf(selectedMonth) + 1;

                        int day = (monthIndex == now.month) ? now.day : 1;

                        currentDate = DateTime(now.year, monthIndex, day);

                        selectedDay = currentDate.day;
                        selectedDate =
                            "${currentDate.day}-${currentDate.month}-${currentDate.year}";
                        finalDate = dateFormatter.format(currentDate);
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            ///
            DatePicker(
              currentDate,
              key: ValueKey(currentDate),
              height: 103,
              width: 48,
              initialSelectedDate: currentDate,
              selectionColor: AppColors.addCategoryHeadingColor,
              monthTextStyle: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12,
                color: AppColors.white50Color,
                fontWeight: FontWeight.w500,
              ),
              dateTextStyle: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 20,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w800,
              ),
              dayTextStyle: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12,
                color: const Color(0xffFF7966).withValues(alpha: .6),
                fontWeight: FontWeight.w500,
              ),
              onDateChange: (date) {
                setState(() {
                  selectedDay = date.day;
                  selectedMonth = months[date.month - 1];
                  selectedDate = "${date.day}-${date.month}-${date.year}";
                  finalDate = dateFormatter.format(date);
                });
              },
            ),

            SizedBox(height: 55),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: selectedMonth,
                  tColor: AppColors.whiteColor,
                  fSize: 20,
                  fWeight: FontWeight.w700,
                  lspacing: 0.0,
                ),
                CustomText(
                  text: '\$${totalAmountForSelectedDate.toStringAsFixed(2)}',
                  tColor: AppColors.whiteColor,
                  fSize: 20,
                  fWeight: FontWeight.w700,
                  lspacing: 0.0,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: selectedDate,
                  tColor: AppColors.white50Color,
                  fSize: 12,
                  lspacing: 0.2,
                ),
                CustomText(
                  text: 'in upcoming bills',
                  tColor: AppColors.white50Color,
                  fSize: 12,
                  lspacing: 0.2,
                ),
              ],
            ),
            SizedBox(height: 22),
            LayoutBuilder(
              builder: (context, constraints) {
                int totalItems = subscriptionsForSelectedDate.length;
                int rows = ((totalItems % 4) / 2).ceil();

                double tileHeight = 180;
                double spacing = 8;
                double calculatedHeight =
                    totalItems == 0
                        ? 0
                        : (rows * tileHeight) + ((rows - 1) * spacing);
                return SizedBox(
                  height: calculatedHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (subscriptionsForSelectedDate.length / 4).ceil(),
                    itemBuilder: (context, pageIndex) {
                      final startIndex = pageIndex * 4;
                      final endIndex = (startIndex + 4).clamp(
                        0,
                        subscriptionsForSelectedDate.length,
                      );

                      final items = subscriptionsForSelectedDate.sublist(
                        startIndex,
                        endIndex,
                      );

                      return Container(
                        width: MediaQuery.of(context).size.width - 50,
                        margin: EdgeInsets.only(right: 16),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 160 / 180,
                              ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final sub = items[index];
                            return Container(
                              height: 168,
                              width: 160,
                              margin: EdgeInsets.all(3),
                              padding: EdgeInsets.only(
                                top: 14,
                                bottom: 8,
                                left: 14,
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.fieldTextColor.withValues(
                                      alpha: .3,
                                    ),
                                    offset: Offset(-1, -1),
                                  ),
                                ],
                                color: AppColors.cntrSBColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.transparentColor,
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(File(sub.imagePath!)),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  CustomText(
                                    text: sub.categoryName,
                                    tColor: AppColors.whiteColor,
                                    fSize: 14,
                                    fWeight: FontWeight.w600,
                                    lspacing: 0.0,
                                  ),
                                  SizedBox(height: 5),
                                  CustomText(
                                    text: '\$${sub.amount}',
                                    tColor: AppColors.whiteColor,
                                    fSize: 20,
                                    lspacing: 0.0,
                                    fWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
