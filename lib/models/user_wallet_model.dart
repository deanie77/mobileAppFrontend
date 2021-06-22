import 'dart:convert';

import 'package:flutter/material.dart';

class UserWallet{
  double wallet_id;
  double balance;
  int user_id;

  UserWallet({
    @required this.wallet_id,
    @required this.balance,
    @required this.user_id
  });

  factory UserWallet.fromJson(Map<String, dynamic> responseData) {
    return UserWallet(
        wallet_id: responseData['id'],
        balance: responseData['balance'],
        user_id: responseData['user_id']
    );
  }
}