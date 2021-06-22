import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetUserThatRequested with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/users/requester/';

  Future getUserThatRequested(int user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final posted = await http.get(
      Uri.parse(url + '${user_id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.get('access_token')}',
      },
    );

    if (posted.statusCode == 200) {
      var responseData = json.decode(posted.body);
      var data = responseData['user'];
      print(data);
      notifyListeners();
      return data;
    }
  }
}
