import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogOutUser with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/users/logout';

  Future logOutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final posted = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.get('access_token')}',
      },
    );
  }
}