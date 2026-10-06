// ignore_for_file: use_build_context_synchronously

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

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  final cardNoController = TextEditingController();
  final nameController = TextEditingController();
  final cvvController = TextEditingController();
  final expirayDateController = TextEditingController();
  final cardAmountController = TextEditingController();

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

          title: CustomText(
            text: 'Add new Card',
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
                text: 'Card Number',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 14,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 16,
                cController: cardNoController,
                obscureText: false,
                kTpye: TextInputType.phone,
                hintText: '0544 5465 4665 6655',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CardNumberInputFormatter(),
                ],

                hintTextSize: 16,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image(
                    image: AssetImage('assets/images/visa_logo.png'),
                    width: 15,
                  ),
                ),
              ),
              SizedBox(height: 16),
              CustomText(
                text: 'Card Holder Name',
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
                kTpye: TextInputType.name,
                hintText: 'Kevin Backer',

                hintTextSize: 16,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: 'Expiry Date',
                      tColor: AppColors.addCategoryHeadingColor,
                      fSize: 14,
                      lspacing: 0.2,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: CustomText(
                      text: 'CVV',
                      tColor: AppColors.addCategoryHeadingColor,
                      fSize: 14,
                      lspacing: 0.2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      textLetterSpacing: 0.2,
                      textSize: 13.3,
                      readOnly: true,
                      cController: expirayDateController,
                      obscureText: false,
                      kTpye: TextInputType.numberWithOptions(),
                      hintText: 'MM/YYYY',
                      hintTextSize: 13.3,
                      hintTextColor: AppColors.white50Color,
                      hintTextLetterSpacing: 0.2,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.white50Color,
                        ),
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            initialDatePickerMode: DatePickerMode.year,
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2070, 12, 31),
                            initialDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            final month = selectedDate.month.toString().padLeft(
                              2,
                              '0',
                            );
                            final year = selectedDate.year.toString();
                            expirayDateController.text = "$month/$year";
                          }
                        },

                        color: AppColors.white50Color,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: CustomTextField(
                      textLetterSpacing: 0.2,
                      textSize: 16,
                      cController: cvvController,
                      obscureText: false,
                      kTpye: TextInputType.phone,
                      hintText: '345',
                      hintTextSize: 16,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      hintTextColor: AppColors.white50Color,
                      hintTextLetterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              CustomText(
                text: 'Card Amount',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 14,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 16,
                cController: cardAmountController,
                obscureText: false,
                kTpye: TextInputType.phone,
                hintText: '\$45000',
                hintTextSize: 16,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),

              SizedBox(height: 170),
              CustomButton(
                btntext: 'Confirm',
                onPressed: () async {
                  final dbHelper = DBHelper();
                  String cardNo = cardNoController.text.replaceAll(' ', '');
                  String name = nameController.text.trim();
                  String cvv = cvvController.text.trim();
                  String expiry = expirayDateController.text.trim();
                  String amount = cardAmountController.text.trim();

                  if (cardNo.isEmpty ||
                      name.isEmpty ||
                      cvv.isEmpty ||
                      expiry.isEmpty ||
                      amount.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields.')),
                    );
                    return;
                  }

                  // Check card number length
                  if (cardNo.length < 16) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Card number must be 16 digits.')),
                    );
                    return;
                  }

                  // Check expiry format
                  final expiryRegex = RegExp(r'^(0[1-9]|1[0-2])\/\d{4}$');
                  if (!expiryRegex.hasMatch(expiry)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Expiry date must be in MM/YYYY format.'),
                      ),
                    );
                    return;
                  }

                  // Check CVV length
                  if (cvv.length != 3) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('CVV must be 3 digits.')),
                    );
                    return;
                  }

                  // Check amount format
                  final amountRegex = RegExp(r'^\d+(\.\d{1,2})?$');
                  if (!amountRegex.hasMatch(amount)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid amount format.')),
                    );
                    return;
                  }

                  await dbHelper
                      .insert(
                        ExpenseManagementModel(
                          isFrom: 'Card',
                          cardNumber: cardNo,
                          categoryName: name,
                          expiryDate: expiry,
                          cVV: cvv,
                          amount: amount,
                        ),
                      )
                      .then((_) {
                        Fluttertoast.showToast(
                          msg: "Card added successfully!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: AppColors.whiteColor,
                          textColor: AppColors.blackColor,
                          fontSize: 16.0,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CustomBottomBar(selectedIndex: 3),
                          ),
                        );
                      })
                      .onError((error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error adding card: $error')),
                        );
                      });
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

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
