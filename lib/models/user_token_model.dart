import 'package:flutter/material.dart';

class Token{
  String access_token;
  String refresh_token;

  Token({@required this.access_token, @required this.refresh_token});

  factory Token.fromJson(Map<String, dynamic> responseData) {
    return Token(
        access_token: responseData['access_token'],
        refresh_token: responseData['refresh_token']
    );
  }
}