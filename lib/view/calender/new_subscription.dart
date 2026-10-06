// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:trackizer/database/db_helper.dart';
import 'package:trackizer/database/db_model.dart';
import 'package:trackizer/utils/app_colors.dart';
import 'package:trackizer/view/credit_cards/add_new_card.dart';
import 'package:trackizer/widgets/custom_bottom_bar.dart';
import 'package:trackizer/widgets/custom_button.dart';
import 'package:trackizer/widgets/custom_text.dart';
import 'package:trackizer/widgets/custom_text_Field.dart';

import '../../widgets/dashed_border_painter.dart' show DashedBorderPainter;

class NewSubscription extends StatefulWidget {
  const NewSubscription({super.key});

  @override
  State<NewSubscription> createState() => _NewSubscriptionState();
}

class _NewSubscriptionState extends State<NewSubscription> {
  final dbHelper = DBHelper();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  double monthlyPrice = 0.00;

  int _selectedCard = -1;

  List<ExpenseManagementModel> cardList = [];
  Future<void> initValues() async {
    cardList = await dbHelper.getExpenseDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initValues();
    priceController.text = monthlyPrice.toStringAsFixed(2);
    priceController.addListener(() {
      final value = double.tryParse(priceController.text);
      if (value != null) {
        setState(() {
          monthlyPrice = value;
        });
      }
    });
  }

  void incrementPrice() {
    setState(() {
      monthlyPrice += 1.00;
      priceController.text = monthlyPrice.toStringAsFixed(2);
    });
  }

  void decrementPrice() {
    setState(() {
      if (monthlyPrice > 1.00) {
        monthlyPrice -= 1.00;
        priceController.text = monthlyPrice.toStringAsFixed(2);
      }
    });
  }

  File? _pickedImage;

  Future<void> pickImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo, color: AppColors.primaryColor),
              title: CustomText(
                text: 'Pick from Gallery',
                tColor: AppColors.blackColor,
                lspacing: 0.0,
                fSize: 16,
                fWeight: FontWeight.w500,
              ),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  setState(() {
                    _pickedImage = File(pickedFile.path);
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.primaryColor),
              title: CustomText(
                text: 'Take a Photo',
                tColor: AppColors.blackColor,
                lspacing: 0.0,
                fSize: 16,
                fWeight: FontWeight.w500,
              ),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  setState(() {
                    _pickedImage = File(pickedFile.path);
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    priceController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  String maskCardNumber(String cardNo) {
    if (cardNo.length < 16) return cardNo;

    String lastFour = cardNo.substring(cardNo.length - 4);
    String masked = '**** **** **** $lastFour';
    return masked;
  }

  String cardNomber = '';
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  @override
  Widget build(BuildContext context) {
    final List<ExpenseManagementModel> filteredList =
        cardList.where((element) => element.isFrom == 'Card').toList();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          surfaceTintColor: AppColors.bgColor,
          backgroundColor: AppColors.bgColor,
          title: CustomText(
            text: 'Add new Subscription',
            tColor: AppColors.whiteColor,
            fSize: 16,
            fWeight: FontWeight.w600,
            lspacing: 0.2,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.whiteColor),

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
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              CustomText(
                text: 'Platform Logo',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 12,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: AppColors.textFieldColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.textFieldBorderColor),
                      image:
                          _pickedImage != null
                              ? DecorationImage(
                                image: FileImage(_pickedImage!),
                                fit: BoxFit.cover,
                              )
                              : null,
                    ),
                    child:
                        _pickedImage == null
                            ? Icon(Icons.image, color: AppColors.white50Color)
                            : null,
                  ),

                  SizedBox(
                    width: 150,
                    child: CustomButton(
                      btntext: 'Choose Image',
                      onPressed: pickImage,
                      fSize: 14,
                      fWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              CustomText(
                text: 'Platform Name',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 12,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 12,
                cController: nameController,
                obscureText: false,
                hintText: 'Spotify',
                hintTextSize: 12,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),
              SizedBox(height: 15),
              CustomText(
                text: 'Description',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 12,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 12,
                cController: descriptionController,
                obscureText: false,
                hintText: 'Music App',
                hintTextSize: 12,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),
              SizedBox(height: 15),
              CustomText(
                text: 'Category',
                tColor: AppColors.addCategoryHeadingColor,
                fSize: 12,
                lspacing: 0.2,
              ),
              SizedBox(height: 10),
              CustomTextField(
                textLetterSpacing: 0.2,
                textSize: 12,
                cController: categoryController,
                obscureText: false,
                hintText: 'Entertainment',
                hintTextSize: 12,
                hintTextColor: AppColors.white50Color,
                hintTextLetterSpacing: 0.2,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomText(
                      text: 'Start Date',
                      tColor: AppColors.addCategoryHeadingColor,
                      fSize: 12,
                      lspacing: 0.2,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomText(
                      text: 'End Date',
                      tColor: AppColors.addCategoryHeadingColor,
                      fSize: 12,
                      lspacing: 0.2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      textLetterSpacing: 0.2,
                      textSize: 12,
                      cController: startDateController,
                      obscureText: false,
                      hintText: 'Start Date',
                      readOnly: true,
                      hintTextSize: 12,
                      hintTextColor: AppColors.white50Color,
                      hintTextLetterSpacing: 0.2,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.white50Color,
                        ),
                        onPressed: () async {
                          DateTime initialDate = DateTime.now();

                          if (startDateController.text.isNotEmpty) {
                            try {
                              initialDate = DateFormat(
                                'dd-MM-yyyy',
                              ).parse(startDateController.text);
                            } catch (e) {
                              initialDate = DateTime.now();
                            }
                          }

                          final selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2025),
                            lastDate: DateTime(2030, 12, 31),
                            initialDate: initialDate,
                          );

                          if (selectedDate != null) {
                            final formattedDate = DateFormat(
                              'dd-MM-yyyy',
                            ).format(selectedDate);
                            startDateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      textLetterSpacing: 0.2,
                      textSize: 12,
                      cController: endDateController,
                      obscureText: false,
                      readOnly: true,
                      hintText: 'End Date',
                      hintTextSize: 12,
                      hintTextColor: AppColors.white50Color,
                      hintTextLetterSpacing: 0.2,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.white50Color,
                        ),
                        onPressed: () async {
                          DateTime initialDate = DateTime.now();

                          if (endDateController.text.isNotEmpty) {
                            try {
                              initialDate = DateFormat(
                                'dd-MM-yyyy',
                              ).parse(endDateController.text);
                            } catch (e) {
                              // fallback to current date if parsing fails
                              initialDate = DateTime.now();
                            }
                          }

                          final selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2025),
                            lastDate: DateTime(2030, 12, 31),
                            initialDate: initialDate,
                          );

                          if (selectedDate != null) {
                            final formattedDate = DateFormat(
                              'dd-MM-yyyy',
                            ).format(selectedDate);
                            endDateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cntrBorderSBColor,
                          offset: Offset(-.5, 0),
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: AppColors.cntrSBColor,
                      onPressed: decrementPrice,
                      child: Icon(
                        Icons.remove,
                        color: AppColors.cntrBorderSBColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    child: Column(
                      children: [
                        CustomText(
                          text: 'Monthly Price',
                          tColor: AppColors.homeTextColor,
                          fSize: 12,
                          lspacing: 0,
                          fWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 4),
                        TextField(
                          controller: priceController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}'),
                            ),
                          ],
                          decoration: InputDecoration(
                            hintText: '\$${monthlyPrice.toStringAsFixed(2)}',
                            hintStyle: TextStyle(
                              color: AppColors.white50Color,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 35),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cntrBorderSBColor,
                          offset: Offset(-.5, 0),
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: AppColors.cntrSBColor,
                      onPressed: incrementPrice,
                      child: Icon(
                        Icons.add,
                        color: AppColors.cntrBorderSBColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 26),
              filteredList.isEmpty
                  ? GestureDetector(
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
                                    text: 'Add card first',
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
                  )
                  : Center(
                    child: SizedBox(
                      height: 155,
                      child: PageView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: ((context, index) {
                          var card = filteredList[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCard = index;
                                  cardNomber = card.cardNumber.toString();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff3C3C3C).withValues(alpha: .1),
                                      Color(0xff3C3C3C).withValues(alpha: .3),
                                      Color(0xff3C3C3C).withValues(alpha: .5),
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color:
                                        _selectedCard == index
                                            ? AppColors.primaryColor
                                            : Colors.transparent,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                              'assets/images/MasterCard Logo.png',
                                            ),
                                            height: 25,
                                            width: 30,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Virtual Card',
                                            style: TextStyle(
                                              color: Color(0xff919294),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Image(
                                          image: AssetImage(
                                            'assets/images/Chip.png',
                                          ),
                                          width: 50,
                                          height: 30,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          maskCardNumber(
                                            card.cardNumber.toString(),
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              card.categoryName.toString(),
                                              style: TextStyle(
                                                color: Color(0xFFC1C1CD),
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                right: 5,
                                              ),
                                              child: Text(
                                                card.expiryDate.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

              SizedBox(height: 26),
              CustomButton(
                btntext: 'Add this platform',
                onPressed: () async {
                  String productName = nameController.text.trim();
                  String description = descriptionController.text.trim();
                  String category = categoryController.text.trim();
                  String amount = priceController.text.trim();
                  String startDate = startDateController.text.trim();
                  String endDate = endDateController.text.trim();

                  // 🔒 Basic Field Validations
                  if (productName.isEmpty ||
                      description.isEmpty ||
                      category.isEmpty ||
                      endDate.isEmpty ||
                      startDate.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all the fields.")),
                    );
                    return;
                  }

                  // 💰 Price Check
                  if (monthlyPrice <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please set a valid price.")),
                    );
                    return;
                  }

                  // 📆 Date Parsing
                  DateTime? startDateTime;
                  DateTime? endDateTime;

                  try {
                    startDateTime = DateFormat('dd-MM-yyyy').parse(startDate);
                    endDateTime = DateFormat('dd-MM-yyyy').parse(endDate);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid date format.")),
                    );
                    return;
                  }

                  // 📆 End Date Must Be After Start Date
                  if (endDateTime.isBefore(startDateTime)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Expiry date cannot be before start date.",
                        ),
                      ),
                    );
                    return;
                  }

                  // 🧾 Check If Cards Are Added
                  if (filteredList.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please add a card first.")),
                    );
                    return;
                  }

                  // 💳 Card Must Be Selected
                  if (_selectedCard == -1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select a card.")),
                    );
                    return;
                  }

                  // 🖼️ Image Must Be Picked
                  if (_pickedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select an image.")),
                    );
                    return;
                  }

                  // 💰 Amount Validation Against Card Limit
                  double selectedCardAmount =
                      double.tryParse(
                        filteredList[_selectedCard].amount.toString(),
                      ) ??
                      0;
                  double enteredAmount = double.tryParse(amount) ?? 0;

                  if (enteredAmount > selectedCardAmount) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomText(
                          text:
                              "Entered amount exceeds the selected card's limit.",
                          tColor: AppColors.blackColor,
                          lspacing: 0.2,
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }

                  // ✅ All Good – Save the Subscription
                  await dbHelper.insert(
                    ExpenseManagementModel(
                      isFrom: 'Subscription',
                      imagePath: _pickedImage!.path,
                      categoryName: productName,
                      description: description,
                      subCategory: category,
                      startDate: startDate,
                      expiryDate: endDate,
                      amount: amount,
                      cardNumber: cardNomber.toString(),
                    ),
                  );

                  // 🎉 Success Toast
                  Fluttertoast.showToast(
                    msg: "Subscription added successfully.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: AppColors.primaryColor,
                    textColor: AppColors.whiteColor,
                    fontSize: 16.0,
                  );

                  // 🚀 Navigate Back to Home
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomBottomBar(selectedIndex: 0),
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
