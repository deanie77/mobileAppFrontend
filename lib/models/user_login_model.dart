import 'package:flutter/material.dart';

class UserLogin{
  String password;
  String email;

  UserLogin({
    @required this.password,
    @required this.email,

  });

  factory UserLogin.fromJson(Map<String, dynamic> responseData) {
    return UserLogin(
        email: responseData['email'],
        password: responseData['password']
    );
  }
}