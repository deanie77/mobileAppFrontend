import 'package:flutter/material.dart';

class UserCardsModel {
  String card_status;
  String card_token;
  String card_number;
  int card_id;

  UserCardsModel({this.card_status, this.card_token, this.card_number, this.card_id});

  factory UserCardsModel.fromJson(Map<String, dynamic> responseData) {
    return UserCardsModel(
        card_status: responseData['status'],
        card_token: responseData['token'],
        card_number: responseData['cardnumber'],
        card_id: responseData['id'].toInt()
    );
  }
}