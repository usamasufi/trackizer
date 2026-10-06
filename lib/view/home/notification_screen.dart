import 'package:flutter/material.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/widgets/custom_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.bgColor,
        backgroundColor: AppColors.bgColor,
        title: CustomText(
          text: 'Notifications',
          tColor: AppColors.whiteColor,
          fSize: 16,
          fWeight: FontWeight.w600,
          lspacing: 0.2,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildNotificationItem(
              icon: Icons.payment,
              title: "Payment Successful",
              subtitle: "Your subscription payment was successful!",
              time: "2 hours ago",
            ),
            const SizedBox(height: 12),
            _buildNotificationItem(
              icon: Icons.warning_amber_rounded,
              title: "Subscription Expiring Soon",
              subtitle: "Your Netflix subscription is expiring in 3 days.",
              time: "1 day ago",
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildNotificationItem({
  required IconData icon,
  required String title,
  required String subtitle,
  required String time,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.bodyColor,
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 30),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                tColor: AppColors.whiteColor,
                fSize: 14,
                fWeight: FontWeight.w600,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: subtitle,
                tColor: AppColors.white50Color,
                fSize: 12,
              ),
              const SizedBox(height: 6),
              CustomText(text: time, tColor: AppColors.white50Color, fSize: 10),
            ],
          ),
        ),
      ],
    ),
  );
}
