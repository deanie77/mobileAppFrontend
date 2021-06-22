import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_trial_1/models/user_login_model.dart';
import 'package:mobile_app_trial_1/models/user_token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAuthentication with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/users/login';

  Future<UserLogin> loginUser(String email, String password) async {
    final posted = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (posted.statusCode == 201 || posted.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(posted.body);
      createToken(responseJson['access_token'], responseJson['refresh_token']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('user_id', responseJson['user_id']);
      print('Welcome to Waiketa Pay, ${responseJson}');
    } else {
      throw Exception('Failed to Login Wrong email or password.');
    }
  }

  Future<Token> createToken(String access_token, String refresh_token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', access_token);
    prefs.setString('refresh_token', refresh_token);
  }
}
