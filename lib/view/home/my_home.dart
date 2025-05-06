// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:sleek_circular_slider/sleek_circular_slider.dart';
// import 'package:trackizer/utils/app_colors.dart';
// import 'package:trackizer/view/home/circular_dots.dart';
// import 'package:trackizer/widgets/bill_container.dart';
// import 'package:trackizer/widgets/container_custom.dart';
// import 'package:trackizer/widgets/custom_clipper.dart';
// import 'package:trackizer/widgets/custom_container.dart';
// import 'package:trackizer/widgets/custom_text.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     var controller = TabController(length: 2, vsync: this);
//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       appBar: AppBar(
//         leading: Align(
//           alignment: Alignment.centerRight,
//           child: Image(
//             image: AssetImage('assets/images/profile.png'),
//             height: 30,
//           ),
//         ),
//         backgroundColor: AppColors.bgColor,
//         centerTitle: true,
//         title: Image(
//           image: AssetImage('assets/images/logo.png'),
//           height: 20.93,
//         ),
//         actions: [
//           Container(
//             height: 35,
//             width: 35,
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.textFieldBorderColor),
//               shape: BoxShape.circle,
//               color: AppColors.textFieldColor,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Image(
//                 height: 18,
//                 image: AssetImage('assets/images/notification-bing.png'),
//               ),
//             ),
//           ),
//           SizedBox(width: 25),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               // SizedBox(height: 15),
//               // Stack(
//               //   alignment: Alignment.center,
//               //   children: [
//               //     CircularDots(
//               //       numberOfDots: 90,
//               //       radius: 145,
//               //       dotSize: 2,
//               //       dotColor: AppColors.textFieldBorderColor,
//               //     ),
//               //     CircularDots(
//               //       numberOfDots: 90,
//               //       radius: 120,
//               //       dotSize: 2,
//               //       dotColor: AppColors.textFieldBorderColor,
//               //     ),
//               //     CircularDots(
//               //       numberOfDots: 70,
//               //       radius: 103,
//               //       dotSize: 2,
//               //       dotColor: AppColors.textFieldBorderColor,
//               //     ),

//               //     /// Circular Progress Painter
//               //     AnimatedBuilder(
//               //       animation: _animation,
//               //       builder: (context, child) {
//               //         return SizedBox(
//               //           height: 225,
//               //           width: 225,
//               //           child: CustomPaint(
//               //             willChange: true,
//               //             painter: CircularProgressPainter(progress: progress),
//               //           ),
//               //         );
//               //       },
//               //     ),
//               Center(
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height * .33,
//                   child: SleekCircularSlider(
//                     min: 0,
//                     max: 2000,
//                     initialValue: 50,
//                     appearance: CircularSliderAppearance(
//                       startAngle: 120,
//                       angleRange: 240,
//                       size: 220,
//                       customColors: CustomSliderColors(
//                         progressBarColor: AppColors.primaryColor,
//                         trackColor: const Color(0xff3A3B46),
//                         dotColor: Colors.transparent,
//                       ),
//                       customWidths: CustomSliderWidths(
//                         shadowWidth: 20,
//                         progressBarWidth: 15,
//                         trackWidth: 15,
//                       ),
//                     ),
//                     innerWidget: (double value) {
//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(height: 10),
//                           const Image(
//                             image: AssetImage('assets/images/logo.png'),
//                             height: 20,
//                             width: 80,
//                           ),
//                           SizedBox(height: 1),
//                           Text(
//                             '\$${value.toInt()}',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 40,
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           const Text(
//                             'This month bills',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Color(0xFF83839C),
//                               fontSize: 14,
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(height: 3),
//                           SizedBox(
//                             width: 90,
//                             height: 30,
//                             child: ElevatedButton(
//                               style: const ButtonStyle(
//                                 backgroundColor: WidgetStatePropertyAll(
//                                   Color(0xff3C3C3C),
//                                 ),
//                               ),
//                               onPressed: () {},
//                               child: const Center(
//                                 child: Text(
//                                   textAlign: TextAlign.center,
//                                   'Budget',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontFamily: 'Manrope',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               TabBar(
//                 // padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
//                 controller: controller,
//                 unselectedLabelColor: AppColors.white50Color,
//                 indicatorColor: AppColors.homeRowColor,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(7),
//                   color: const Color(0xff30303C),
//                 ),
//                 tabs: [
//                   Tab(
//                     child: Container(
//                       width: 155,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(7),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           'Your Subscriptions',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'Manrope',
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Tab(
//                     child: Container(
//                       width: 155,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(7),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           'Upcomming Bills',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Manrope',
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               // ClipPath(
//               //   clipper: BottomClipper(),
//               //   child: CircularDots(
//               //     numberOfDots: 50,
//               //     radius: 85,
//               //     dotSize: 2,
//               //     dotColor: AppColors.textFieldBorderColor,
//               //   ),
//               // ),

//               //     Positioned(
//               //       top: 80,
//               //       right: 88,
//               //       left: 88,
//               //       child: Column(
//               //         children: [
//               //           SizedBox(height: 8),
//               //           Image(image: AssetImage('assets/images/logo1.png')),
//               //           SizedBox(height: 17.19),
//               //           CustomText(
//               //             text: "\$${totalSubscriptionCost.toStringAsFixed(2)}",
//               //             tColor: AppColors.whiteColor,
//               //             fWeight: FontWeight.w700,
//               //             fSize: 31.366,
//               //           ),
//               //           SizedBox(height: 8),
//               //           CustomText(
//               //             text: 'This month bills',
//               //             tColor: AppColors.homeTextColor,
//               //           ),
//               //           SizedBox(height: 15),

//               //           SizedBox(
//               //             height: 25,
//               //             width: 80,
//               //             child: ElevatedButton(
//               //               style: ButtonStyle(
//               //                 shadowColor: WidgetStateProperty.all(
//               //                   AppColors.textFieldBorderColor,
//               //                 ),
//               //                 elevation: WidgetStateProperty.all(2),
//               //                 padding: WidgetStateProperty.all(EdgeInsets.zero),
//               //                 side: WidgetStateProperty.all(
//               //                   BorderSide(
//               //                     color: AppColors.textFieldColor,
//               //                     width: 0.75,
//               //                   ),
//               //                 ),
//               //                 backgroundColor: WidgetStateProperty.all(
//               //                   AppColors.homeBtnColor,
//               //                 ),
//               //               ),
//               //               onPressed: () {},
//               //               child: Text(
//               //                 'See budget',
//               //                 style: TextStyle(
//               //                   color: AppColors.whiteColor,
//               //                   fontFamily: 'Manrope',
//               //                   fontWeight: FontWeight.w600,
//               //                   fontSize: 10,
//               //                 ),
//               //               ),
//               //             ),
//               //           ),
//               //         ],
//               //       ),
//               //     ),

//               //   ],
//               // ),
//               // SizedBox(height: 20),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //   children: [
//               //     CustomContainer(
//               //       height: 68,
//               //       width: 104,
//               //       lineColor: AppColors.firstLineColor,
//               //       text: 'Active Subs',
//               //       secondtext: '4',
//               //       borderRadius: BorderRadius.circular(16),
//               //     ),
//               //     CustomContainer(
//               //       height: 68,
//               //       width: 104,
//               //       lineColor: AppColors.secondLineColor,
//               //       text: 'Highest subs',
//               //       secondtext: '\$37.99',
//               //       borderRadius: BorderRadius.circular(16),
//               //     ),
//               //     CustomContainer(
//               //       height: 68,
//               //       width: 104,
//               //       lineColor: AppColors.thirdLineColor,
//               //       text: 'Lowest subs',
//               //       secondtext: '\$5.99',
//               //       borderRadius: BorderRadius.circular(16),
//               //     ),
//               //   ],
//               // ),

//               // Container(
//               //   height: 50,
//               //   width: 327,
//               //   decoration: BoxDecoration(
//               //     color: AppColors.bodyColor,
//               //     borderRadius: BorderRadius.circular(7),
//               //   ),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //     children: [
//               //       SizedBox(
//               //         width: 145,
//               //         child: Align(
//               //           alignment: Alignment.center,
//               //           child: GestureDetector(
//               //             onTap: () {
//               //               isSub = true;
//               //               setState(() {});
//               //             },
//               //             child:
//               //                 isSub == true
//               //                     ? CustomContainer(
//               //                       height: 36,
//               //                       width: 155,
//               //                       text: 'Your subscriptions',
//               //                       borderRadius: BorderRadius.circular(7),
//               //                       textColor: AppColors.whiteColor,
//               //                       fontWeight: FontWeight.w600,
//               //                     )
//               //                     : Text(
//               //                       'Your subscriptions',
//               //                       style: TextStyle(
//               //                         fontFamily: 'Manrope',
//               //                         fontSize: 12,
//               //                         fontWeight: FontWeight.w600,
//               //                         letterSpacing: 0,
//               //                         color: Color(0xffA2A2B5),
//               //                       ),
//               //                     ),
//               //           ),
//               //         ),
//               //       ),

//               // SizedBox(
//               //   width: 145,
//               //   child: Align(
//               //     alignment: Alignment.center,
//               //     child: GestureDetector(
//               //       onTap: () {
//               //         isSub = false;
//               //         setState(() {});
//               //       },
//               //       child:
//               //           !isSub
//               //               ? CustomContainer(
//               //                 height: 36,
//               //                 width: 155,
//               //                 text: 'Upcoming bills',
//               //                 borderRadius: BorderRadius.circular(7),
//               //                 textColor: AppColors.whiteColor,
//               //                 fontWeight: FontWeight.w600,
//               //               )
//               //               : Text(
//               //                 'Upcoming bills',
//               //                 style: TextStyle(
//               //                   fontFamily: 'Manrope',
//               //                   fontSize: 12,
//               //                   fontWeight: FontWeight.w600,
//               //                   letterSpacing: 0,
//               //                   color: Color(0xffA2A2B5),
//               //                 ),
//               //               ),
//               //     ),
//               //   ),
//               // ),
//               //     ],
//               //   ),
//               // ),

//               // isSub
//               //     ? ContainerCustom(
//               //       text: 'Spotify',
//               //       price: '\$5.99',
//               //       imageProvider: AssetImage('assets/images/spotify_logo.png'),
//               //     )
//               //     : BillContainer(text: 'Spotify', price: '\$5.99'),
//               // SizedBox(height: 8),
//               // isSub
//               //     ? ContainerCustom(
//               //       text: 'YouTube Premium',
//               //       price: '\$18.99',
//               //       imageProvider: AssetImage(
//               //         'assets/images/yt_premium_logo.png',
//               //       ),
//               //     )
//               //     : BillContainer(text: 'YouTube Premium', price: '\$18.99'),
//               // SizedBox(height: 8),
//               // isSub
//               //     ? ContainerCustom(
//               //       text: 'Microsoft OneDrive',
//               //       price: '\$29.99',
//               //       imageProvider: AssetImage(
//               //         'assets/images/one_drive_logo.png',
//               //       ),
//               //     )
//               //     : BillContainer(text: 'Microsoft OneDrive', price: '\$29.99'),
//               // SizedBox(height: 8),
//               // isSub
//               //     ? ContainerCustom(
//               //       text: 'Netflix',
//               //       price: '\$37.99',
//               //       imageProvider: AssetImage('assets/images/netflix_logo.png'),
//               //     )
//               //     : BillContainer(text: 'Netflix', price: '\$37.99'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// 🎨 Custom Painter for Circular Progress Bar
// class CircularProgressPainter extends CustomPainter {
//   final double progress;

//   CircularProgressPainter({required this.progress});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint backgroundPaint =
//         Paint()
//           ..color = Colors.grey[800]!
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 15
//           ..strokeCap = StrokeCap.round;

//     Paint progressPaint =
//         Paint()
//           ..color = AppColors.primaryColor
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 15
//           ..strokeCap = StrokeCap.round;

//     Offset center = Offset(size.width / 2, size.height / 2);
//     double radius = size.width / 2 - 10;

//     /// Draw Background Circle
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       pi / 1.25,
//       (2.798 * pi) / 2,
//       false,
//       backgroundPaint,
//     );

//     /// Draw Progress Arc
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       pi / 1.25, // Start
//       (2.798 * pi) / 2 * progress,
//       false,
//       progressPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(CircularProgressPainter oldDelegate) {
//     return oldDelegate.progress != progress;
//   }
// }
