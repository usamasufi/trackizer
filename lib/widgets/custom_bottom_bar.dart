// ignore_for_file: library_private_types_in_public_api
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackizer/database/db_helper.dart';
import 'package:trackizer/models/card_model.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/utils/app_routes/app_routes.dart';
import 'package:trackizer/view/calender/calender_screen.dart';
import 'package:trackizer/view/credit_cards/credit_cards_screen.dart';
import 'package:trackizer/view/home/home_screen.dart';
import 'package:trackizer/view/spending_and_budgets/spending_budeget_screen.dart';
import 'package:trackizer/widgets/custom_text.dart';

class FABModel {
  final IconData icon;
  final String text;

  FABModel({required this.icon, required this.text});
}

class CustomBottomBar extends StatefulWidget {
  final int selectedIndex;
  const CustomBottomBar({super.key, this.selectedIndex = 0});

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final dbHelper = DBHelper();
  List<FABModel> fabList = [
    FABModel(icon: Icons.subscriptions_outlined, text: 'Add new Subscription'),
    FABModel(icon: Icons.credit_card, text: 'Add new Card'),
    FABModel(icon: Icons.money, text: 'Add Budget'),
  ];

  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  List cards = [];
  void addCard(CardModel card) {
    setState(() {
      cards.add(card);
    });
  }

  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  final List<Widget> screens = [
    HomeScreenWrapper(),
    SpendingBudgetScreen(),
    CalenderScreen(),
    CreditCardsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (isMenuOpen) {
          setState(() {
            isMenuOpen = false;
          });
          return false;
        }

        if (selectedIndex != 0) {
          setState(() {
            selectedIndex = 0;
          });
          return false;
        }

        bool? exit = await showDialog(
          context: context,
          builder:
              (BuildContext context) => AlertDialog(
                backgroundColor: AppColors.bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: CustomText(
                  text: 'Exit',
                  tColor: AppColors.whiteColor,
                  fSize: 18,
                  lspacing: 0.0,
                  fWeight: FontWeight.w700,
                ),
                content: CustomText(
                  text: 'Do you really want to close the app?',
                  tColor: AppColors.white50Color,
                  fSize: 14,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: CustomText(
                      text: "No",
                      tColor: AppColors.white50Color,
                      fSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: CustomText(
                      text: "Yes",
                      tColor: AppColors.primaryColor,
                      fSize: 16,
                    ),
                  ),
                ],
              ),
        );

        if (exit == true) {
          SystemNavigator.pop();
        }

        return exit ?? false;
      },
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: selectedIndex, children: screens),
        bottomNavigationBar: Stack(
          children: [
            Positioned(
              bottom: 18,
              left: 15,
              width: 330,
              height: 62,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: ClipPath(
                  clipper: MyCustomClipper(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.textFieldBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(17),
                        color: AppColors.white50Color.withValues(alpha: 0.1),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 23),
                          GestureDetector(
                            onTap: () => _onItemTapped(0),
                            child: Icon(
                              Icons.home_outlined,
                              color:
                                  selectedIndex == 0
                                      ? AppColors.whiteColor
                                      : AppColors.white50Color,
                              size: 25,
                            ),
                          ),
                          SizedBox(width: 36),
                          GestureDetector(
                            onTap: () => _onItemTapped(1),
                            child: Icon(
                              Icons.dashboard_outlined,
                              color:
                                  selectedIndex == 1
                                      ? AppColors.whiteColor
                                      : AppColors.white50Color,
                              size: 25,
                            ),
                          ),
                          SizedBox(width: 97),
                          GestureDetector(
                            onTap: () => _onItemTapped(2),
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color:
                                  selectedIndex == 2
                                      ? AppColors.whiteColor
                                      : AppColors.white50Color,
                              size: 25,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => _onItemTapped(3),
                            child: Icon(
                              Icons.wallet_outlined,
                              color:
                                  selectedIndex == 3
                                      ? AppColors.whiteColor
                                      : AppColors.white50Color,
                              size: 25,
                            ),
                          ),
                          SizedBox(width: 23),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// Floating Action Button
            if (isMenuOpen) ...[
              Positioned.fill(
                child: GestureDetector(
                  onTap: toggleMenu,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: AppColors.transparentColor.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 110,
                left: MediaQuery.of(context).size.width * 0.06,
                right: MediaQuery.of(context).size.width * 0.06,
                child: Column(
                  spacing: 8,
                  children: List.generate(3, (index) {
                    var fab = fabList[index];
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textFieldBorderColor,
                            offset: Offset(-0.8, 0),
                          ),
                        ],
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.newSubscription,
                            );
                          } else if (index == 1) {
                            Navigator.pushNamed(context, AppRoutes.addNewCard);
                          } else {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.addNewCategoryScreen,
                            );
                          }
                        },
                        child: ListTile(
                          leading: Icon(fab.icon, color: Colors.white),
                          title: Text(
                            fab.text,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Manrope',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
            Positioned(
              bottom: 50,
              left: MediaQuery.of(context).size.width / 2 - 28,
              child: FloatingActionButton(
                onPressed: toggleMenu,
                backgroundColor: AppColors.primaryColor,
                shape: const CircleBorder(),
                child: Icon(
                  isMenuOpen ? Icons.close : Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerOffset = Offset(size.width / 2, 0);
    const cutRadius = 35.0;
    path.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    final circlePath =
        Path()
          ..addOval(Rect.fromCircle(center: centerOffset, radius: cutRadius));
    return Path.combine(PathOperation.difference, path, circlePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
