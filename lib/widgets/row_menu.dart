import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/pages/qr_code_page.dart';
import 'package:mobile_app_trial_1/pages/qr_scanner_page.dart';
import 'package:mobile_app_trial_1/pages/transaction_history.dart';
import 'package:mobile_app_trial_1/screens/user_cards_screen.dart';

class HorizontalRowWidget extends StatefulWidget {
  @override
  _HorizontalRowWidgetState createState() => _HorizontalRowWidgetState();
}

class _HorizontalRowWidgetState extends State<HorizontalRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.qr_code),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(QRCodePage.routeName);
                  },
                ),
                Text('My QR'),
              ],
            ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.qr_code_scanner),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(QRScannerPage.routeName);
                },
              ),
              Text('Scan'),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.monetization_on),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(TransactionHistory.routeName);
                },
              ),
              Text('Transactions'),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.credit_card),
                 onPressed: () {
                    Navigator.of(context).pushReplacementNamed(UserCardsScreen.routeName);
                    },
              ),
              Text('Cards'),
            ],
          ),
        ),
      ],
    );
  }
}
