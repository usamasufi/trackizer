import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/view/credit_cards/add_new_card.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/dashed_border_painter.dart';

class NoCard extends StatelessWidget {
  const NoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 140),
          Image(
            image: AssetImage('assets/images/no_credit_card.png'),
            height: 143,
            width: 179,
          ),
          SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewCard()),
              );
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPaint(
                    painter: DashedBorderPainter(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Add new card',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
