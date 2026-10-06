import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

class SelectCurrency extends StatefulWidget {
  const SelectCurrency({super.key});

  @override
  State<SelectCurrency> createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrency> {
  final currencyController = TextEditingController();
  static const String _currencyKey = 'selected_currency';

  @override
  void initState() {
    super.initState();
    _loadSavedCurrency();
  }

  Future<void> _loadSavedCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCurrency = prefs.getString(_currencyKey) ?? 'USD';
    if (!mounted) return;
    setState(() {
      currencyController.text = savedCurrency;
    });
  }

  Future<void> _saveCurrency() async {
    final value = currencyController.text.trim();
    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a currency.')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currencyKey, value);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Currency updated to $value')),
    );
    Navigator.pop(context, value);
  }

  @override
  void dispose() {
    currencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.bgColor,
        backgroundColor: AppColors.bgColor,
        title: CustomText(
          text: 'Select Currency',
          tColor: AppColors.whiteColor,
          fSize: 16,
          fWeight: FontWeight.w600,
          lspacing: 0.2,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            SizedBox(height: 10),
            CustomTextField(
              suffixIcon: IconButton(
                color: AppColors.whiteColor,
                onPressed: () {
                  showCurrencyPicker(
                    context: context,
                    onSelect: (selectedCurrency) {
                      setState(() {
                        currencyController.text = selectedCurrency.code;
                      });
                    },
                  );
                },
                icon: Icon(Icons.search),
              ),
              textLetterSpacing: 0.2,
              textSize: 16,
              cController: currencyController,
              obscureText: false,
              hintText: 'USD',
              hintTextSize: 16,
              hintTextColor: AppColors.white50Color,
              hintTextLetterSpacing: 0.2,
            ),
            Spacer(),
            CustomButton(
              btntext: 'Update',
              onPressed: _saveCurrency,
              fSize: 16,
              fWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
