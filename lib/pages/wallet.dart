import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/get_user_wallet.dart';
import 'package:mobile_app_trial_1/widgets/wallet_balance_widget.dart';
import 'package:provider/provider.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  Future userWallet;

  @override
  Widget build(BuildContext context) {
    userWallet = Provider.of<GetUserWallet>(context, listen: false).getUserWallet();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20.0)),
            WalletBalanceWidget(),
          ],
        ),
      ),
    );
  }
}
