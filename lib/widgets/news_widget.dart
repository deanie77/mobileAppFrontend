import 'package:flutter/material.dart';

class NewsWidget extends StatefulWidget {
  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
                children: <Widget>[
                  Text('Today\'s financial new',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('The new mobile wallet saving lives, WaiketaPay.')
                ],
              ),
          ),
        ],
      ),
    );
  }
}
