class UserTransactionsModel {
  String payer;
  String payee;
  double amount;
  String transaction_type;
  String status;
  String time;

  UserTransactionsModel({this.payer, this.payee, this.status, this.amount, this.transaction_type, this.time});

  factory UserTransactionsModel.fromJson(Map<String, dynamic> responseData) {
    return UserTransactionsModel(
        payer: responseData['payer'],
        payee: responseData['payee'],
        status: responseData['status'],
        amount: responseData['amount'],
        transaction_type: responseData['transaction_type'],
        time: responseData['created']
    );
  }
}

class UserTransactionsModelResponse {
  final List<UserTransactionsModel> list;

  UserTransactionsModelResponse({this.list});

  factory UserTransactionsModelResponse.fromJson(List<dynamic> parsedJson) {
    List<UserTransactionsModel> list = new List<UserTransactionsModel>();
    list = parsedJson.map((e) => UserTransactionsModel.fromJson(e)).toList();

    return new UserTransactionsModelResponse(list: list);
  }
}