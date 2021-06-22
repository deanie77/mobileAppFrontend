import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TopUpWallet with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/users/user/wallet/topup/';

  Future topUpWallet(double amount, String card_number, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final posted = await http.post(
      Uri.parse(url + '${prefs.getInt('user_id')}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.get('access_token')}',
      },
      body: jsonEncode(<String, dynamic>{
        'amount': amount,
        'card_number': card_number,
        'password': password
      }),
    );
    if (posted.statusCode == 302 || posted.statusCode == 200) {
      var newUrl = posted.headers['location'];
      final response = await http.get(Uri.parse(newUrl));
      notifyListeners();
    } else {
      throw Exception('Failed to top up wallet');
    }
  }
}
