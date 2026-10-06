import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trackizer/database/db_helper.dart';
import 'package:trackizer/database/db_model.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/view/spending_and_budgets/add_new_category_screen.dart';
import 'package:trackizer/widgets/custom_bottom_bar.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/dashed_border_painter.dart';

class SpendingBudgetScreen extends StatefulWidget {
  const SpendingBudgetScreen({super.key});

  @override
  State<SpendingBudgetScreen> createState() => _SpendingBudgetScreenState();
}

class _SpendingBudgetScreenState extends State<SpendingBudgetScreen> {
  final dbHelper = DBHelper();

  List<ExpenseManagementModel> budgetList = [];
  List<Color> barColors = [
    AppColors.graphfirstColor,
    AppColors.graphsecondColor,
    AppColors.graphthirdColor,
    AppColors.firstLineColor,
    AppColors.thirdLineColor,
  ];

  Future<void> initValues() async {
    budgetList = await dbHelper.getExpenseDetails();
    setState(() {});
  }

  double getTotalBudget() {
    return budgetList
        .where((e) => e.isFrom == 'Budget')
        .fold(
          0,
          (sum, item) => sum + (double.tryParse(item.totalBudget ?? '0') ?? 0),
        );
  }

  double getTotalSpent() {
    return budgetList
        .where((e) => e.isFrom == 'Budget')
        .fold(0, (sum, item) => sum + (double.tryParse(item.amount) ?? 0));
  }

  List<ChartData> getChartData() {
    final List<ExpenseManagementModel> budgets =
        budgetList.where((e) => e.isFrom == 'Budget').toList();

    return budgets.map((e) {
      return ChartData(e.categoryName, double.tryParse(e.amount) ?? 0);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    initValues();
  }

  @override
  Widget build(BuildContext context) {
    final List<ExpenseManagementModel> filteredList =
        budgetList.where((element) => element.isFrom == 'Budget').toList();

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: Image.asset('assets/images/profile.png', height: 30),
        ),
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: AppColors.bgColor,
        centerTitle: true,
        title: CustomText(
          text: 'Spending & Budgets',
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
              child: Image.asset(
                'assets/images/notification-bing.png',
                height: 18,
              ),
            ),
          ),
          SizedBox(width: 25),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.53,
              child: SfCircularChart(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                annotations: [
                  CircularChartAnnotation(
                    height: '80%',
                    width: '80%',
                    widget: Column(
                      children: [
                        CustomText(
                          text: '\$${getTotalSpent().toStringAsFixed(2)}',
                          tColor: AppColors.whiteColor,
                          fSize: 24,
                          fWeight: FontWeight.w700,
                          lspacing: 0,
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          text:
                              'of \$${getTotalBudget().toStringAsFixed(2)} budget',
                          tColor: AppColors.white50Color,
                          fSize: 12,
                          fWeight: FontWeight.w500,
                          lspacing: 0.2,
                        ),
                      ],
                    ),
                  ),
                ],
                palette: [
                  AppColors.graphfirstColor,
                  AppColors.graphsecondColor,
                  AppColors.graphthirdColor,
                  AppColors.firstLineColor,
                  AppColors.thirdLineColor,
                ],
                series: <CircularSeries>[
                  DoughnutSeries(
                    enableTooltip: false,
                    explode: true,
                    explodeAll: true,
                    explodeOffset: '5%',
                    cornerStyle: CornerStyle.bothCurve,
                    innerRadius: '90%',
                    radius: '75%',
                    startAngle: 270,
                    endAngle: 90,
                    selectionBehavior: SelectionBehavior(enable: false),
                    dataSource: getChartData(),
                    xValueMapper: (data, _) => data.category,
                    yValueMapper: (data, _) => data.value,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 35),

          filteredList.isEmpty
              ? GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewCategoryScreen(),
                    ),
                  );
                  await initValues();
                },
                child: CustomPaint(
                  painter: DashedBorderPainter(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 42),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        CustomText(
                          text: 'Add new category',
                          tColor: AppColors.white50Color,
                          fSize: 14,
                          lspacing: 0,
                          fWeight: FontWeight.w600,
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.add_circle_outline,
                          color: AppColors.white50Color,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cntrBorderSBColor),
                ),
                child: Center(
                  child: Text(
                    'Your budgets are on track   👍',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.0,
                      fontSize: 14,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
          SizedBox(height: 10),
          Column(
            children: List.generate(filteredList.length, (index) {
              var sb = filteredList[index];
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: AppColors.cntrBorderSBColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Icon(Icons.edit, color: Colors.blue)],
                  ),
                ),
                secondaryBackground: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: AppColors.cntrBorderSBColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.delete_outline_rounded, color: Colors.red),
                    ],
                  ),
                ),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            backgroundColor: AppColors.bgColor,
                            title: CustomText(
                              text: 'Delete Category?',
                              tColor: AppColors.whiteColor,
                              fSize: 16,
                              fWeight: FontWeight.w600,
                            ),
                            content: CustomText(
                              text:
                                  'Are you sure you want to Update this Budget?',
                              tColor: AppColors.white50Color,
                              fSize: 14,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },

                                child: CustomText(
                                  text: 'No',
                                  tColor: AppColors.white50Color,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => AddNewCategoryScreen(
                                            isEdit: true,
                                            id: sb.id,
                                            categoryName: sb.categoryName,
                                            amount: sb.amount,
                                            totalBudget: sb.totalBudget,
                                            description: sb.description,
                                          ),
                                    ),
                                  );
                                },
                                child: CustomText(
                                  text: 'Update',
                                  tColor: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                    );

                    await initValues();
                  } else if (direction == DismissDirection.endToStart) {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            backgroundColor: AppColors.bgColor,
                            title: CustomText(
                              text: 'Delete Category?',
                              tColor: AppColors.whiteColor,
                              fSize: 16,
                              fWeight: FontWeight.w600,
                            ),
                            content: CustomText(
                              text:
                                  'Are you sure you want to delete this category?',
                              tColor: AppColors.white50Color,
                              fSize: 14,
                            ),
                            actions: [
                              TextButton(
                                onPressed:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => CustomBottomBar(
                                              selectedIndex: 1,
                                            ),
                                      ),
                                    ),
                                child: CustomText(
                                  text: 'Cancle',
                                  tColor: AppColors.white50Color,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  dbHelper.delete(sb.id!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              CustomBottomBar(selectedIndex: 1),
                                    ),
                                  );
                                },
                                child: CustomText(
                                  text: 'Delete',
                                  tColor: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                    );
                  }
                },

                child: Container(
                  padding: EdgeInsets.only(top: 18, left: 20, right: 16),
                  margin: EdgeInsets.only(top: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cntrSBColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            color: AppColors.white50Color,
                            size: 26,
                          ),
                          SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: sb.categoryName,
                                tColor: AppColors.whiteColor,
                                fSize: 14,
                                fWeight: FontWeight.w700,
                                lspacing: 0.0,
                              ),
                              SizedBox(height: 3),
                              CustomText(
                                text:
                                    '\$${(double.tryParse(sb.totalBudget ?? '0') ?? 0) - (double.tryParse(sb.amount) ?? 0)} left to spend',
                                tColor: AppColors.white50Color,
                                fSize: 12,
                                fWeight: FontWeight.w500,
                                lspacing: 0.2,
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                text: '\$${sb.amount}',
                                tColor: AppColors.whiteColor,
                                fSize: 14,
                                fWeight: FontWeight.w700,
                                lspacing: 0.0,
                              ),
                              SizedBox(height: 3),
                              CustomText(
                                text: 'of \$${sb.totalBudget}',
                                tColor: AppColors.white50Color,
                                fSize: 12,
                                fWeight: FontWeight.w500,
                                lspacing: 0.2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: barColors[index % barColors.length],
                          inactiveTrackColor: AppColors.cntrBorderSBColor,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 3,
                          ),
                        ),
                        child: Slider(
                          activeColor: barColors[index % barColors.length],
                          inactiveColor: AppColors.cntrBorderSBColor,
                          max: double.tryParse(sb.totalBudget ?? '0') ?? 0.0,
                          min: 0,
                          value: (double.tryParse(sb.amount) ?? 0.0).clamp(
                            0,
                            double.tryParse(sb.totalBudget ?? '0') ?? 1.0,
                          ),
                          onChanged: (double value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 110),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.category, this.value);
  final String category;
  final double value;
}
