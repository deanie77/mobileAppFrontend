import 'package:flutter/material.dart';

class User{
  String first_name;
  String last_name;
  String date_of_birth;
  String username;
  String password;
  String email;
  String phonenumber;
  String token;

  User({
    @required this.first_name,
    @required this.last_name,
    @required this.date_of_birth,
    @required this.username,
    @required this.password,
    @required this.email,
    @required this.phonenumber,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        first_name: responseData['first_name'],
        last_name: responseData['last_name'],
        email: responseData['email'],
        phonenumber: responseData['phonenumber'],
        date_of_birth: responseData['date_of_birth'],
        username: responseData['username'],
        password: responseData['password']
    );
  }
}