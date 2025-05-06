import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trackizer/database/db_helper.dart';
import 'package:trackizer/database/db_model.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/widgets/custom_bottom_bar.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

class AddNewCategoryScreen extends StatefulWidget {
  final bool isEdit;
  final int? id;
  final String? categoryName;
  final String? description;
  final String? amount;
  final String? totalBudget;

  const AddNewCategoryScreen({
    super.key,
    this.isEdit = false,
    this.id,
    this.categoryName,
    this.description,
    this.amount,
    this.totalBudget,
  });

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  final dbHelper = DBHelper();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final moneySpendController = TextEditingController();
  final budgetController = TextEditingController();

  List<ExpenseManagementModel> budgetList = [];
  Future<void> initValues() async {
    budgetList = await dbHelper.getExpenseDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initValues();

    if (widget.isEdit == true) {
      categoryController.text = widget.categoryName!;
      descriptionController.text = widget.description!;
      moneySpendController.text = widget.amount!;
      budgetController.text = widget.totalBudget!;
    }
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
          backgroundColor: AppColors.bgColor,
          surfaceTintColor: AppColors.bgColor,
          automaticallyImplyLeading: widget.isEdit == true ? false : true,
          title: CustomText(
            text:
                widget.isEdit == true ? 'Update Category' : 'Add new Category',
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
              CustomText(
                text: 'Category',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 14,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 16,
                cController: categoryController,
                obscureText: false,
                hintText: 'Entertainment',
                hintTextSize: 16,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),
              SizedBox(height: 16),
              CustomText(
                text: 'Description',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 14,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 16,
                cController: descriptionController,
                obscureText: false,
                hintText: 'Description',
                hintTextSize: 16,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),
              SizedBox(height: 16),
              CustomText(
                text: 'Money Spend',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 14,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 16,
                cController: moneySpendController,
                obscureText: false,
                hintText: '\$10.99',
                hintTextSize: 16,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
                kTpye: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              SizedBox(height: 16),
              CustomText(
                text: 'Budget',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 14,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 16,
                cController: budgetController,
                obscureText: false,
                hintText: '\$100',
                hintTextSize: 16,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
                kTpye: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Total Budget',
                    tColor: AppColors.addCategoryHeadingColor,
                    fSize: 14,
                    lspacing: 0.2,
                  ),

                  CustomText(
                    text: '\$${budgetController.text}',
                    tColor: AppColors.addCategoryHeadingColor,
                    fSize: 14,
                    lspacing: 0.2,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Money Spend',
                    tColor: AppColors.addCategoryHeadingColor,
                    fSize: 14,
                    lspacing: 0.2,
                  ),

                  CustomText(
                    text: '\$${moneySpendController.text}',
                    tColor: AppColors.addCategoryHeadingColor,
                    fSize: 14,
                    lspacing: 0.2,
                  ),
                ],
              ),
              SizedBox(height: 44),
              CustomButton(
                btntext: widget.isEdit == true ? 'Update' : 'Confirm',
                onPressed: () {
                  String category = categoryController.text.trim();
                  String description = descriptionController.text.trim();
                  String moneySpendText = moneySpendController.text.trim();
                  String budgetText = budgetController.text.trim();

                  if (category.isEmpty ||
                      description.isEmpty ||
                      moneySpendText.isEmpty ||
                      budgetText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }

                  double moneySpend = double.tryParse(moneySpendText) ?? 0.0;
                  double budget = double.tryParse(budgetText) ?? 0.0;

                  if (moneySpend > budget) {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: CustomText(
                              text: 'Warning',
                              fWeight: FontWeight.w700,
                              tColor: Colors.red,
                              fSize: 22,
                            ),
                            content: CustomText(
                              text: 'Money spent exceeds the budget!',
                              tColor: AppColors.blackColor,
                              fSize: 14,
                            ),
                            actions: [
                              TextButton(
                                child: CustomText(
                                  text: 'OK',
                                  fWeight: FontWeight.w600,
                                  tColor: AppColors.primaryColor,
                                  fSize: 16,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                    );
                    return;
                  }

                  if (widget.isEdit == true) {
                    dbHelper
                        .update(
                          ExpenseManagementModel(
                            id: widget.id,
                            isFrom: 'Budget',
                            categoryName: category,
                            description: description,
                            amount: moneySpendText,
                            totalBudget: budgetText,
                          ),
                        )
                        .then((value) {})
                        .catchError((e) {});
                  } else {
                    dbHelper
                        .insert(
                          ExpenseManagementModel(
                            isFrom: 'Budget',
                            categoryName: category,
                            description: description,
                            amount: moneySpendText,
                            totalBudget: budgetText,
                          ),
                        )
                        .then((value) {})
                        .catchError((e) {});
                  }

                  Fluttertoast.showToast(
                    msg:
                        widget.isEdit
                            ? "Budget updated successfully."
                            : "Budget added successfully.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: AppColors.primaryColor,
                    textColor: AppColors.whiteColor,
                    fontSize: 16.0,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomBottomBar(selectedIndex: 1),
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
