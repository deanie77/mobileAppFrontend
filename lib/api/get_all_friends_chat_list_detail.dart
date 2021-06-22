import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_trial_1/models/friend_chat_list_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllFriendsChatListDetail with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/users/chat/list/user/info/';

  Future getAllFriendsChatListDetail(int user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final posted = await http.get(
      Uri.parse(url + '$user_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.get('access_token')}',
      },
    );

    if (posted.statusCode == 200) {
      var data = json.decode(posted.body);
      print(data);
      var parsed = data['user'];
      print(parsed);
      var user = FriendChatListDetail.fromJson(parsed);
      notifyListeners();
      print(user);
      return user;
    }
  }
}
