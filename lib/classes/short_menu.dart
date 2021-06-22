import 'package:flutter/material.dart';

class ShortMenuItem {
  final String title;
  final Icon icon;

  ShortMenuItem({this.title, this.icon});
}

List<ShortMenuItem> shortMenuList = [
  ShortMenuItem(title: 'New Message', icon: Icon(Icons.send)),
  ShortMenuItem(title: 'Scan', icon: Icon(Icons.qr_code_scanner)),
  ShortMenuItem(title: 'Receive Money', icon: Icon(Icons.qr_code)),
  ShortMenuItem(title: 'Logout', icon: Icon(Icons.exit_to_app)),
];