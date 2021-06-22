import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_trial_1/models/user_wallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignUserWallet with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/users/register/wallet/';

  Future<UserWallet> createUserWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final posted =
        await http.get(Uri.parse(url + '${prefs.getInt('user_id')}'));

    if (posted.statusCode == 201 || posted.statusCode == 200) {
      UserWallet responseJson = UserWallet.fromJson(json.decode(posted.body));
      return responseJson;
    } else {
      throw Exception('Failed to create User.');
    }
  }
}
