import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SendFriendRequest with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/friendships/send/friend/request';

  Future sendFriendRequest(int sender_id, int receiver_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final posted = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.get('access_token')}',
      },
      body: jsonEncode(
          <String, dynamic>{'user_one': sender_id, 'user_two': receiver_id}),
    );

    if (posted.statusCode == 201) {
      var data = json.decode(posted.body);
      print(data);
      return data;
    }
  }
}
