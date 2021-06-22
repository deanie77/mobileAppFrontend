import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_trial_1/api/get_user_cards.dart';
import 'package:mobile_app_trial_1/api/get_user_wallet.dart';
import 'package:mobile_app_trial_1/api/top_up_wallet.dart';
import 'package:mobile_app_trial_1/api/withdraw_wallet.dart';
import 'package:mobile_app_trial_1/models/user_card_selection_model.dart';
import 'package:mobile_app_trial_1/models/user_wallet_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class WalletBalanceWidget extends StatefulWidget {
  @override
  _WalletBalanceWidgetState createState() => _WalletBalanceWidgetState();
}

class _WalletBalanceWidgetState extends State<WalletBalanceWidget> {
  Future userWallet;
  int walletID;
  int userID;
  double balance;
  var _myActivity = null;
  var _myTopup = null;


  @override
  Widget build(BuildContext context) {
    userWallet = Provider.of<GetUserWallet>(context, listen: false).getUserWallet();
    
    createTopUpDialog(BuildContext context){
        final GlobalKey<FormState> _formKey = GlobalKey();

        Map<String, dynamic> _authData = {
          'amount': 0.00,
          'card_number': '',
          'password': ''
        };

        void _submit() async {
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();
          _authData['card_number'] = _myTopup;
          try {
          await Provider.of<TopUpWallet>(context, listen: false).topUpWallet(
              _authData['amount'],
              _authData['card_number'],
              _authData['password']
          );
          } catch(e) {
            Fluttertoast.showToast(
                msg: "$e",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          Provider.of<GetUserWallet>(context, listen: false);
          Navigator.pop(context);
        }

        return showDialog(context: context, builder: (context) {
          final cards = Provider.of<GetUserCards>(context, listen: false)
              .getUserWalletCards();
          return AlertDialog(
            title: Text('Enter Top Up Amount'),
            content: Form(
              key: _formKey,
              child: Container(
                height: 300,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(prefixIcon: Icon(
                          Icons.attach_money), labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'enter a top up amount';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['amount'] = double.parse(value);
                      },
                    ),
                    SizedBox(height: 40.0,),
                    Expanded(child:
                    FutureBuilder(
                        future: cards,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropDownFormField(
                              titleText: 'My Card',
                              hintText: 'Please choose one',
                              dataSource: snapshot.data,
                              textField: 'cardnumber',
                              valueField: 'cardnumber',
                              value: _myTopup,
                              onSaved: (value) {
                                setState(() {
                                  _myTopup = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _myTopup = value;
                                });
                              },
                            );
                          } else {
                            return Text('${snapshot.error}');
                          }
                        }
                    ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(prefixIcon: Icon(Icons.https),
                          labelText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'enter a password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Top Up'),
                color: Colors.purple.shade300,
                onPressed: () {
                  _submit();
                },
              ),
            ],
          );
        });

    }

    createWithdrawWalletDialog(BuildContext context){
      final GlobalKey<FormState> _formKey = GlobalKey();

      Map<String, dynamic> _authData = {
        'amount': 0.00,
        'card_number': '',
        'password': ''
      };

      void _submit() async{
        if(!_formKey.currentState.validate()){
          return;
        }
        _formKey.currentState.save();

          _authData['card_number'] = _myActivity;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await Provider.of<WithdrawWallet>(context, listen: false).withdrawWallet(
            _authData['amount'],
            _authData['card_number'],
            _authData['password']
        );
        Provider.of<GetUserWallet>(context, listen: false);
        _formKey.currentState.reset();
        Navigator.pop(context);
      }

      return showDialog(context: context, builder: (context){
        final cards = Provider.of<GetUserCards>(context, listen: false).getUserWalletCards();
        return AlertDialog(
          title: Text('Enter Withdrawal Amount'),
          content: Form(
            key: _formKey,
            child: Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(prefixIcon: Icon(Icons.attach_money),labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value.isEmpty){
                        return 'enter withdrawal amount';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _authData['amount'] = double.parse(value);
                    },
                  ),
                  SizedBox(height: 40.0,),
                  Expanded(child:
                  FutureBuilder(
                    future: cards,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropDownFormField(
                          titleText: 'My Card',
                          hintText: 'Please choose one',
                          value: _myActivity,
                          onSaved: (value) {
                            setState(() {
                              _myActivity = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _myActivity = value;
                            });
                          },
                          dataSource: snapshot.data,
                          textField: 'cardnumber',
                          valueField: 'cardnumber',
                        );
                      } else {
                        return Text('${snapshot.error}');
                      }
                    }
                  ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(prefixIcon: Icon(Icons.https),labelText: 'Password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value){
                      if(value.isEmpty){
                        return 'enter a password';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _authData['password'] = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text('Withdraw'),
              color: Colors.purple.shade300,
              onPressed: (){
                _submit();
              },
            ),
          ],
        );
      });
    }
    
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
              child: CircleAvatar(
                radius: 80.0,
                backgroundColor: Colors.yellow.shade800,
                child: Icon(
                  Icons.attach_money,
                  color: Colors.white,
                  size: 80.0,
                ),
              ),
          ),
          Padding(padding: EdgeInsets.all(16.0)),
          Text('Wallet Balance', textAlign: TextAlign.center,),
          Padding(padding: EdgeInsets.all(16.0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: userWallet,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return Chip(
                      backgroundColor: Colors.purple.shade100,
                      label: Text('${snapshot.data.balance}'),
                      avatar: Icon(Icons.attach_money),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    );
                  } else {
                    return Text('there is an error');
                  }
                },
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(16.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  createTopUpDialog(context);
                },
                child: Text('Top Up'),
                color: Colors.purple.shade300,
              ),
              Padding(padding: EdgeInsets.all(16.0)),
              RaisedButton(
                onPressed: () {
                  createWithdrawWalletDialog(context);
                },
                child: Text('Withdraw'),
                color: Colors.grey.shade500,
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(16.0)),

        ],
      ),
    );
  }
  getUserCardSelection() async{
        await Provider.of<GetUserCards>(context)
            .getUserWalletCards();

    }

  }
