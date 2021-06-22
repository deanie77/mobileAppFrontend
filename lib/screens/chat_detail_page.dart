import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/get_user_messages.dart';
import 'package:mobile_app_trial_1/models/chat_message_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatDetailPage extends StatefulWidget {
  static const routeName ='/chat/page';
  String userName;
  int id;

  ChatDetailPage({@required this.userName, @required this.id});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  var userMessages;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Socket socket;
  final GlobalKey<FormState> _formKey2 = GlobalKey();

  Map<String, dynamic> _authData_2 = {
    'amount': 0.00,
    'user_id': 0,
    'other_id': 0,
    'password': ''
  };

  Map<String, dynamic> _authData = {'user_id': 0, 'other_id': 0, 'message': ''};

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple.shade50,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black,),
                ),
                SizedBox(width: 2.0,),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/lion.jpg'),
                  maxRadius: 20.0,
                ),
                SizedBox(width: 12.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.userName, style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),),
                      SizedBox(height: 6.0,),
                      Text('Online', style: TextStyle(
                          color: Colors.grey.shade600, fontSize: 13.0),),
                    ],
                  ),
                ),
                Icon(Icons.settings, color: Colors.black54,),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: FutureBuilder(
                future: _getUserMessages(widget.id),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10.0, bottom: 55.0,),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 10.0, bottom: 10.0,),
                          child: Align(
                            alignment: (snapshot.data[index].sender_id ==
                                widget.id
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: (snapshot.data[index].sender_id ==
                                    widget.id
                                    ? Colors.grey.shade200
                                    : Colors.purple.shade300),
                              ),
                              padding: EdgeInsets.all(16.0),
                              child: Text(snapshot.data[index].message),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('no data to show');
                  }
                  return CircularProgressIndicator();
                }
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0,),
              height: 60.0,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.purple.shade300,
                    elevation: 0,
                    onPressed: () {
                      createSendMoneyDialog(context);
                    },
                    child: Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.white,
                      size: 32.0,
                     ),
                  ),
                  SizedBox(width: 15.0,),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'invalid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['message'] = value;
                          _authData['other_id'] = widget.id;
                        },
                        decoration: InputDecoration(
                          hintText: 'Write message...',
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0,),
                  FloatingActionButton(
                    onPressed: () {
                      connectToServer();
                      _formKey.currentState.reset();
                      setState(() {
                        
                      });
                    },
                    child: Icon(Icons.send, color: Colors.white, size: 18.0,),
                    backgroundColor: Colors.purple.shade300,
                    elevation: 0,
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getUserMessages(other) async {
    setState(() {

    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _authData['user_id'] = prefs.getInt('user_id');
    userMessages =
    await Provider.of<GetUserMessages>(context, listen: false).getUserMessages(
        other);
    return userMessages;
  }

  void connectToServer() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      socket = io('http://192.168.100.46:5000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      socket.connect();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _authData['user_id'] = prefs.getInt('user_id');
    setState(() {
      socket.on('send_message', _handleMessage(_authData));
    });
    } catch (e) {

    }
    setState(() {

    });
  }

  _handleMessage(Map<String, dynamic> data) async {
    socket.emit('send_message', data);
  }

  void connectToUserWallet() async {
    setState(() {

    });
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    setState(() {

    });
  }

  _handleSendMoney(Map<String, dynamic> data) async {
    socket.emit('send_money', data);
  }

  createSendMoneyDialog(BuildContext context){

    void _submit() async{
      setState(() {

      });
      if(!_formKey2.currentState.validate()){
        return;
      }
      _formKey2.currentState.save();
      try {
        socket = io('http://192.168.100.46:5000', <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });

        socket.connect();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _authData_2['user_id'] = prefs.getInt('user_id');
        _authData_2['other_id'] = widget.id;
        socket.on('send_money', _handleSendMoney(_authData_2));
      } catch (e) {

      }
      Navigator.pop(context);

    }

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Enter Money to be sent'),
        content: Form(
          key: _formKey2,
          child: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(prefixIcon: Icon(Icons.attach_money),labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'enter an amount to send';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _authData_2['amount'] = double.parse(value);
                  },
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
                    _authData_2['password'] = value;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Send Money'),
            color: Colors.purple.shade300,
            onPressed: (){
              _submit();
            },
          ),
        ],
      );
    });
  }
}
