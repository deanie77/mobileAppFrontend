import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_trial_1/api/login_authentication.dart';
import 'package:mobile_app_trial_1/pages/home.dart';
import 'package:mobile_app_trial_1/screens/user_registration_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class UserLoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': ''
  };

  void _submit() async{
    try {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      await Provider.of<LoginAuthentication>(context, listen: false).loginUser(
          _authData['email'],
          _authData['password']
      );

      Navigator.of(context).pushReplacementNamed(Home.routeName);
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

  Socket socket;

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() async{
    try {
      socket = io('http://192.168.100.46:5000', <String, dynamic> {
        'transports': ['websocket'],
        'autoConnect': false,
      });

      socket.connect();

      socket.on('connect', (_) => print('connect: ${socket.id}'));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('session_id', socket.id);
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Sign Up'),
                Padding(padding: EdgeInsets.all(8.0)),
                Icon(Icons.person_add),
              ],
            ),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(UserRegistrationScreen.routeName);
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
                height: 360,
                width: 300,
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
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
                              'Login'
                          ),
                          onPressed: (){
                            _submit();
                          },
                        ),
                        Padding(padding: EdgeInsets.all(2.0)),
                        FlatButton(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: (){

                          },
                        ),
                        FlatButton(
                          child: Text(
                            'Sign Up First',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: (){
                            Navigator.of(context).pushReplacementNamed(UserRegistrationScreen.routeName);
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
