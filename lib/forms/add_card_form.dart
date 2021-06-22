import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_trial_1/api/add_user_card.dart';
import 'package:mobile_app_trial_1/api/get_user_cards.dart';
import 'package:mobile_app_trial_1/classes/to_boolean.dart';
import 'package:mobile_app_trial_1/classes/check_box_form_field.dart';
import 'package:mobile_app_trial_1/screens/user_cards_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCardForm extends StatefulWidget {
  static const routeName = '/add/card/form';

  @override
  _AddCardFormState createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _submit () async {
    try {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();

      await Provider.of<AddUserCard>(context, listen: false).addUserCard(
          _authData['card_number'],
          _authData['card_type'],
          _authData['card_provider'],
          _authData['user_agreement'],
          _authData['bank_name'],
          _authData['cvv_code'],
          _authData['expiry_date'],
          _authData['card_holder_name'],
          _authData['user_id_type'],
          _authData['user_id'],
          _authData['phonenumber'],
          _authData['address_1'],
          _authData['address_2'],
          _authData['zip_code'],
          _authData['city'],
          _authData['country']
      );
      Navigator.of(context).pushReplacementNamed(UserCardsScreen.routeName);
    }catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to add card",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Map<String, dynamic> _authData = {
    'card_number': '',
    'card_type': '',
    'card_provider': '',
    'user_agreement': 0,
    'bank_name': '',
    'cvv_code': '',
    'expriry_date': '',
    'card_holder_name': '',
    'user_id_type': '',
    'user_id': '',
    'phonenumber': '',
    'address_1': '',
    'address_2': '',
    'zip_code': '',
    'city': '',
    'country': '',
    'wallet_id': 0,
    'status': 'waiting'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pushReplacementNamed(UserCardsScreen.routeName);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
        title: Text('My Cards'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Container(
                height: 560,
                width: 300,
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.account_balance),labelText: 'Bank Name'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['bank_name'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.credit_card),labelText: 'Card Number'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['card_number'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.credit_card),labelText: 'Card Type'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid card type';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['card_type'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.credit_card),labelText: 'Card Provider'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['card_provider'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.credit_card),labelText: 'CVV-Code'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['cvv_code'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.calendar_today),labelText: 'Expiry Date'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['expiry_date'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.person),labelText: 'Card Holder Name'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['card_holder_name'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.perm_identity),labelText: 'Type Of ID'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid ID';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['user_id_type'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.perm_identity),labelText: 'User ID'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid ID';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['user_id'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.phone),labelText: 'Phone Number'),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['phonenumber'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Address'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['address_1'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Address'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['address_2'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Zip Code'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid zip code';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['zip_code'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'City'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['city'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Country'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid country name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['country'] = value;
                          },
                        ),
                        CheckboxFormField(
                          title: Text('User Agreement'),
                          onSaved: (value) {
                              _authData['user_agreement'] = value.toString().toLowerCase() == true.toString().toLowerCase();
                          },
                          validator: (value) {
                            if (value == false) {
                              return 'Please agree terms';
                            }
                            return null;
                          },
                        ),
                        RaisedButton(
                          color: Colors.purple.shade200,
                          child: Text(
                              'Sign Up'
                          ),
                          onPressed: (){
                            _submit();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
