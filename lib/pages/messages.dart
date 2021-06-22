import 'package:flappy_search_bar_fork/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/get_all_friends_chat_list.dart';
import 'package:mobile_app_trial_1/api/get_all_friends_chat_list_detail.dart';
import 'package:mobile_app_trial_1/api/search_users.dart';
import 'package:mobile_app_trial_1/api/send_friend_request.dart';
import 'package:mobile_app_trial_1/models/chat_user_model.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:mobile_app_trial_1/models/searched_users_model.dart';
import 'package:mobile_app_trial_1/widgets/conversation_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app_trial_1/models/friend_chat_list_model.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController _filter = new TextEditingController();
  var userList;
  var sharedPrefs;
  Socket socket;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  _getUserList() async {
    userList = await Provider.of<GetAllFriendsChatList>(context, listen: false)
        .getAllFriendsChatList();
    return userList;
  }

  Map<String, dynamic> _authData = {'user_one': 0, 'user_two': 0};

  void _sendRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _authData['user_one'] = prefs.getInt('user_id');
    if (_authData['user_one'] != _authData['user_two']) {
      var requestResponse =
      await Provider.of<SendFriendRequest>(context, listen: false)
          .sendFriendRequest(_authData['user_one'], _authData['user_two']);
      print(requestResponse);
    }
  }

  void connectToServer() async {
    try {
      socket = io('http://192.168.100.46:5000', <String, dynamic> {
        'transports': ['websocket'],
        'autoConnect': false,
      });

      socket.connect();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _authData['user_one'] = prefs.getInt('user_id');

      socket.on('send_request', _handleReequest(_authData));
    } catch (e) {

    }
  }

  _handleReequest(Map<String, dynamic> data) async{
    socket.emit('send_request', data);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchUsers>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Chats',
                      style: TextStyle(
                          fontSize: 32.0, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.purple.shade200,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.purple,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            'Add New',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _filter,
                    onChanged: onSearchTextChanged,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.grey.shade600,
                        size: 20.0,
                      ),
                      suffixIcon: new IconButton(
                          icon: new Icon(Icons.cancel),
                          onPressed: () {
                            _filter.clear();
                            onSearchTextChanged('');
                          }),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey.shade100,
                        ),
                      ),
                    ),
                  ),
                  new Flexible(
                    child: _searchResults.length != 0 || _filter.text.isNotEmpty
                        ? new ListView.builder(
                            shrinkWrap: true,
                            itemCount: _searchResults.length,
                            itemBuilder: (context, i) {
                              return new Card(
                                child: new ListTile(
                                  title: new Text(_searchResults[i].username),
                                  subtitle: new Text(_searchResults[i].email),
                                  trailing: IconButton(
                                    icon: Icon(Icons.person_add),
                                    onPressed: () {
                                      _authData['user_two'] =
                                          _searchResults[i].id;
                                      _sendRequest();
                                      connectToServer();
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        : new ListView.builder(
                            shrinkWrap: true,
                            itemCount: _userDetails.length,
                            itemBuilder: (context, index) {
                              return new Card(
                                child: new ListTile(
                                  title: new Text(_userDetails[index].username),
                                  subtitle: new Text(_userDetails[index].email),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: _getUserList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16.0),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return FutureBuilder(
                          future: _getUserDetails(snapshot.data[index].user_one),
                          builder: (context, snapshot_2) {
                            if (snapshot_2.hasData) {
                              return ConversationList (
                                username:snapshot_2.data.username,
                                message: snapshot.data[index].status == 0
                                    ? 'Request pending'
                                    : 'Start Chatting',
                                avatar: snapshot_2.data.avatar,
                                isMessageRead:
                                (index == 0 || index == 3) ? true : false,
                                id: snapshot_2.data.id,
                              );
                            }else if (snapshot_2.hasError){
                              return Text('something wrong');
                            }
                            return CircularProgressIndicator();
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError){
                    return Text('something wrong');
                  }
                  return CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }

  List<SearchedUsersModel> _searchResults = [];
  List<SearchedUsersModel> _userDetails = [];
  List<FriendChatList> _finalFriendList = [];

  onSearchTextChanged(String text) async {
    _searchResults.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _userDetails = await Provider.of<SearchUsers>(context, listen: false)
        .searchUsers(text);
    _userDetails.forEach((element) {
      if (element.username.contains(text) || element.email.contains(text)) {
        _searchResults.add(element);
      }
    });
    setState(() {});
  }

  _getUserDetails(some) async {
    var data = await Provider.of<GetAllFriendsChatListDetail>(context,listen: false).getAllFriendsChatListDetail(some);
    return data;
  }
}
