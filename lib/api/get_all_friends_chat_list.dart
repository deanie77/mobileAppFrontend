import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_trial_1/models/friend_chat_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllFriendsChatList with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/friendships/friends/chat/list/';

  Future getAllFriendsChatList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final posted = await http.get(
      Uri.parse(url + '${prefs.getInt('user_id')}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.get('access_token')}',
      },
    );

    if (posted.statusCode == 200) {
      var data = json.decode(posted.body);
      print(data);
      List parsed = data['friends'];
      for (int i = 0; i < parsed.length; i++) {
        if (parsed[i]['user_one'] == prefs.getInt('user_id')) {
          parsed[i]['user_one'] = parsed[i]['user_two'];
        } else if (parsed[i]['user_two'] == prefs.getInt('user_id')) {
          parsed[i]['user_two'] = parsed[i]['user_one'];
        }
      }
      print(parsed);
      List tempList = new FriendChatListResponse.fromJson(parsed).list;
      notifyListeners();
      print(tempList.toString());
      return tempList;
    }
  }
}
