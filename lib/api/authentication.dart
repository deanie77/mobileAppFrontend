import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_trial_1/models/user_registration_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/users/';

  Future<User> createUser(
      String first_name,
      String last_name,
      String date_of_birth,
      String username,
      String email,
      String phonenumber,
      String password) async {
    final posted = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'first_name': first_name,
        'last_name': last_name,
        'date_of_birth': date_of_birth,
        'username': username,
        'email': email,
        'phonenumber': phonenumber,
        'password': password
      }),
    );

    if (posted.statusCode == 302 || posted.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(posted.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('user_id', responseJson['user_id']);
      print('Check email for verification');
    } else {
      throw Exception('email adress or username already exists');
    }
  }
}
