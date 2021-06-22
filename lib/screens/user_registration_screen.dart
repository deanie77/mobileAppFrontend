import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_trial_1/api/assign_user_wallet.dart';
import 'package:mobile_app_trial_1/api/authentication.dart';
import 'package:mobile_app_trial_1/api/create_wallet_qrcode.dart';
import 'package:mobile_app_trial_1/models/user_wallet_model.dart';
import 'package:mobile_app_trial_1/screens/user_login_screen.dart';
import 'package:mobile_app_trial_1/utils/date_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegistrationScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'first_name': '',
    'last_name': '',
    'date_of_birth': '',
    'username': '',
    'email': '',
    'phonenumber': '',
    'password': ''
  };

  void _submit() async{
    try {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      await Provider.of<Authentication>(context, listen: false).createUser(
          _authData['first_name'],
          _authData['last_name'],
          _authData['date_of_birth'],
          _authData['username'],
          _authData['email'],
          _authData['phonenumber'],
          _authData['password']
      );
      await Provider.of<AssignUserWallet>(context, listen: false)
          .createUserWallet();
      Navigator.of(context).pushReplacementNamed(UserLoginScreen.routeName);
      Fluttertoast.showToast(
          msg: "Check Your Email for verification link",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } catch (e) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Login'),
                Padding(padding: EdgeInsets.all(8.0)),
                Icon(Icons.input),
              ],
            ),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(UserLoginScreen.routeName);
            },
            textColor: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
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
                          decoration: InputDecoration(prefixIcon: Icon(Icons.perm_identity),labelText: 'First Name'),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['first_name'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.perm_identity),labelText: 'Last Name'),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['last_name'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.calendar_today),labelText: 'Date Of Birth: yyyy-mm-dd'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if(value.isEmpty || !isValidDate(value)) {
                              return 'invalid date of birth';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['date_of_birth'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.perm_identity),labelText: 'Username'),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if(value.isEmpty || value.length < 2) {
                              return 'invalid username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['username'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.email),labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if(value.isEmpty || !value.contains('@')) {
                              return 'invalid email address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.phone),labelText: 'Phonenumber'),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if(value.isEmpty || value.length < 10) {
                              return 'invalid phonenumber';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['phonenumber'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.lock) ,labelText: 'Password'),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) {
                            if(value.isEmpty || value.length < 3) {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                        ),
                        Padding(padding: EdgeInsets.all(16.0)),
                        RaisedButton(
                          color: Colors.purple.shade200,
                          child: Text(
                            'Sign Up'
                          ),
                          onPressed: (){
                            _submit();
                          },
                        ),
                        Padding(padding: EdgeInsets.all(2.0)),
                        FlatButton(
                          child: Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: (){
                            Navigator.of(context).pushReplacementNamed(UserLoginScreen.routeName);
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
