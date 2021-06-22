import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/get_user_spending.dart';
import 'package:provider/provider.dart';

class IncomeExpensesWidget extends StatefulWidget {
  @override
  _IncomeExpensesWidgetState createState() => _IncomeExpensesWidgetState();
}

class _IncomeExpensesWidgetState extends State<IncomeExpensesWidget> {
  var userSpending;

  @override
  Widget build(BuildContext context) {
    userSpending = Provider.of<GetUserSpending>(context, listen: false).getUserSpending();
    return FutureBuilder(
        future: userSpending,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Income',
                      textAlign: TextAlign.center,
                    ),
                    Chip(
                      backgroundColor: Colors.purple.shade100,
                      label: Text('${snapshot.data.income}'),
                      avatar: Icon(Icons.attach_money),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(40.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Expenses',
                      textAlign: TextAlign.center,
                    ),
                    Chip(
                      backgroundColor: Colors.purple.shade100,
                      label: Text('${snapshot.data.expenses}'),
                      avatar: Icon(Icons.attach_money),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Text('${snapshot.error}');
          }
        });
  }
}
