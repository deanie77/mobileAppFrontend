class UserSpendingModel{
  double expenses;
  double income;

  UserSpendingModel({
    this.expenses,
    this.income,

  });

  factory UserSpendingModel.fromJson(Map<String, dynamic> responseData) {
    return UserSpendingModel(
        expenses: responseData['expenses'].toDouble(),
        income: responseData['income'].toDouble()
    );
  }
}