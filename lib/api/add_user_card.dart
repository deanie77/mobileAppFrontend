import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddUserCard with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/cards/add/card';

  Future addUserCard(
      String card_number,
      String card_type,
      String card_provider,
      bool user_agreement,
      String bank_name,
      String cvv_code,
      String expiry_date,
      String card_holder_name,
      String user_id_type,
      String user_id,
      String phonenumber,
      String address_1,
      String address_2,
      String zip_code,
      String city,
      String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final posted = await http.post(
      Uri.parse(url + '/${prefs.getInt('user_id')}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.get('access_token')}',
      },
      body: jsonEncode(<String, Object>{
        'card_number': card_number,
        'card_type': card_type,
        'card_provider': card_provider,
        'user_agreement': user_agreement,
        'bank_name': bank_name,
        'cvv_code': cvv_code,
        'expiry_date': expiry_date,
        'card_holder_name': card_holder_name,
        'user_id_type': user_id_type,
        'user_id': user_id,
        'phonenumber': phonenumber,
        'address_1': address_1,
        'address_2': address_2,
        'zip_code': zip_code,
        'city': city,
        'country': country,
        'status': 'waiting'
      }),
    );

    if (posted.statusCode == 302) {
      var newUrl = posted.headers['location'];
      final response = await http.get(Uri.parse(newUrl));
      notifyListeners();
      return response;
    } else {
      throw Exception('Failed to add card.');
    }
  }
}
