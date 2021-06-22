import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/get_user_spending.dart';
import 'package:mobile_app_trial_1/widgets/gridview_builder.dart';
import 'package:mobile_app_trial_1/widgets/home_body.dart';
import 'package:mobile_app_trial_1/widgets/income_expenses_widget.dart';
import 'package:mobile_app_trial_1/widgets/news_widget.dart';
import 'package:provider/provider.dart';

class Homie extends StatefulWidget {
  @override
  _HomieState createState() => _HomieState();
}

class _HomieState extends State<Homie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(16.0)),
            HomeBody(),
            Divider(),
            Padding(padding: EdgeInsets.all(30.0)),
            Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(40.0),
              ),

              child: IncomeExpensesWidget(),
            ),
            Padding(padding: EdgeInsets.all(30.0)),
            NewsWidget(),
            Padding(padding: EdgeInsets.all(16.0)),
            const GridViewBuilderWidget(),
          ],
        ),
      ),
    );
  }
}
