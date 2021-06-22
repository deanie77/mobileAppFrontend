import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_trial_1/models/user_transactions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserTransactions with ChangeNotifier {
  final url =
      'http://192.168.100.46:5000/api/transactions/get/transaction/history/';

  Future getUserTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final posted = await http.get(
      Uri.parse(url + '${prefs.getInt('user_id')}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.get('access_token')}',
      },
    );

    if (posted.statusCode == 200) {
      var data = json.decode(posted.body);
      print(data);
      var parsed = data['transaction'];
      print(parsed);
      var transactions = UserTransactionsModelResponse.fromJson(parsed).list;
      notifyListeners();
      print(transactions);
      return transactions;
    }
  }
}
