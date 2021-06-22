import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/get_user_transactions.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class TransactionHistory extends StatefulWidget {
  static const routeName = '/transactionsPage';

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  var userTransactions;

  getTransactionsList() async{
    userTransactions = await Provider.of<GetUserTransactions>(context, listen: false).getUserTransactions();
    return userTransactions;
  }

  @override
  Widget build(BuildContext context) {
    userTransactions = Provider.of<GetUserTransactions>(context, listen: false)
        .getUserTransactions();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Home.routeName);
          },
        ),
        title: Text('My Transactions'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(16.0)),
              FutureBuilder(
                future: getTransactionsList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: new ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.purple.shade200,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(snapshot.data[index].transaction_type),
                                  Text('transaction state: ' +
                                      snapshot.data[index].status),
                                  Text('recipient: ' +
                                      snapshot.data[index].payee),
                                  Text('sender: ' + snapshot.data[index].payer),
                                  Text('amount: \$' +
                                      snapshot.data[index].amount.toString()),
                                  Text('time: ' + snapshot.data[index].time),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Text('failed to load card');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
