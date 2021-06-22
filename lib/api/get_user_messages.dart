import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_trial_1/models/messaging_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserMessages with ChangeNotifier {
  final url = 'http://192.168.100.46:5000/api/messages/get/chat/room/';

  Future getUserMessages(int other_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(url + '${prefs.getInt('user_id')}/' + '$other_id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get('access_token')}',
        });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var messages = jsonResponse['messages'];
      print(messages);
      List tempList = new MessagingModelResponse.fromJson(messages).list;
      notifyListeners();
      return tempList;
    } else {
      throw Exception('here is the problem');
    }
  }
}
