class ExpenseManagementModel {
  final int? id;
  final String isFrom;
  final String categoryName;
  final String? description;
  final String? subCategory;
  final String amount;
  final String? startDate;
  final String? expiryDate;
  final String? cardNumber;
  final String? cVV;
  final String? totalBudget;
  final String? imagePath;

  ExpenseManagementModel({
    this.id,
    required this.isFrom,
    required this.categoryName,
    this.description,
    this.subCategory,
    required this.amount,
    this.startDate,
    this.expiryDate,
    this.cardNumber,
    this.cVV,
    this.totalBudget,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isFrom': isFrom,
      'categoryName': categoryName,
      'description': description,
      'subCategory': subCategory,
      'amount': amount,
      'startDate': startDate,
      'expiryDate': expiryDate,
      'cardNumber': cardNumber,
      'cVV': cVV,
      'totalBudget': totalBudget,
      'imagePath': imagePath,
    };
  }

  ExpenseManagementModel.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      isFrom = res['isFrom'],
      categoryName = res['categoryName'],
      description = res['description'],
      subCategory = res['subCategory'],
      amount = res['amount'],
      startDate = res['startDate'],
      expiryDate = res['expiryDate'],
      cardNumber = res['cardNumber'],
      cVV = res['cVV'],
      totalBudget = res['totalBudget'],
      imagePath = res['imagePath'];
}
