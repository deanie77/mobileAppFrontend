import 'package:flutter/material.dart';

class GridIcons {
  List<IconData> iconList = [];
  List<Text> textList = [];

  List<IconData> getIconList() {
    iconList
      ..add(Icons.lightbulb_outline)
      ..add(Icons.clean_hands_outlined)
      ..add(Icons.local_parking)
      ..add(Icons.directions_bus)
      ..add(Icons.send_to_mobile)
      ..add(Icons.monetization_on)
      ..add(Icons.money)
      ..add(Icons.wifi_sharp)
      ..add(Icons.work)
      ..add(Icons.local_taxi)
      ..add(Icons.restaurant);
    return iconList;
  }

  List<Text> getTextList() {
    textList
      ..add(Text('electric  bill'))
      ..add(Text('water bill'))
      ..add(Text('parking ticket'))
      ..add(Text('bus fare'))
      ..add(Text('mobile topup'))
      ..add(Text('crypto'))
      ..add(Text('insurance'))
      ..add(Text('wifi topup'))
      ..add(Text('hire services'))
      ..add(Text('waiketa ride'))
      ..add(Text('waiketa food'));
    return textList;
  }
}