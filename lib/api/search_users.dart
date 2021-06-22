import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_trial_1/models/searched_users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchUsers with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/users/find/user/';

  Future searchUsers<SearchedUsersModel>(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(url + username), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.get('access_token')}',
    });

    if (response.statusCode == 200) {
      var users = json.decode(response.body);
      List parsed = users['users'];
      print(users);
      List tempList = new SearchedUserModelResponse.fromJson(parsed).list;
      notifyListeners();
      print(tempList.toString());
      return tempList;
    } else if (response.statusCode != 404) {
      print('something is wrong');
      return null;
    }
  }
}
