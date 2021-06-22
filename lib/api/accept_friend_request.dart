import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_trial_1/models/friend_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceptFriendRequest with ChangeNotifier {
  final url =
      'http://192.168.100.46:5000/api/friendships/accept/friend/request/';

  Future acceptFriendRequest(int other_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final posted = await http.post(
      Uri.parse(url + '${prefs.getInt('user_id')}' + '/$other_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.get('access_token')}',
      },
    );
  }
}
