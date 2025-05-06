import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

class SelectCurrency extends StatelessWidget {
  SelectCurrency({super.key});
  final currencyController = TextEditingController();

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
            // CustomText(
            //   text: 'Search Currency',
            //   tColor: AppColors.addCategoryHeadingColor,
            //   fSize: 14,
            //   lspacing: 0.2,
            // ),
            // SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () {
            //     showCurrencyPicker(
            //       context: context,
            //       onSelect: (selectedCurrency) {
            //         currencyController.text = selectedCurrency.name;
            //       },
            //     );
            //   },
            //   child: CustomText(
            //     text: 'Pick Currency',
            //     tColor: AppColors.whiteColor,
            //     fSize: 14,
            //     lspacing: 0.2,
            //   ),
            // ),
            SizedBox(height: 10),
            CustomTextField(
              suffixIcon: IconButton(
                color: AppColors.whiteColor,
                onPressed: () {
                  showCurrencyPicker(
                    context: context,
                    onSelect: (selectedCurrency) {
                      currencyController.text = selectedCurrency.name;
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
              onPressed: () {},
              fSize: 16,
              fWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
