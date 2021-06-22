import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/widgets/row_menu.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HorizontalRowWidget(),
        ],
      ),
    );
  }
}
