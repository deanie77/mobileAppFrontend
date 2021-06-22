import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/accept_friend_request.dart';
import 'package:mobile_app_trial_1/api/get_user_that_requested.dart';
import 'package:mobile_app_trial_1/api/list_friend_request.dart';
import 'package:mobile_app_trial_1/api/reject_friend_request.dart';
import 'package:mobile_app_trial_1/models/friend_request_model.dart';
import 'package:mobile_app_trial_1/models/friend_requester_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'home.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  var _listFriends;
  Socket socket;

  _usersRequest() async {
    _listFriends = await Provider.of<ListFriendRequests>(context, listen: false).listFriendRequests();
    return _listFriends;
  }

  Map<String, dynamic> _authData = {'user_id': 0, 'other_id': 0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Home.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('My Friend Requests'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(16.0)),
            FutureBuilder(
              future: _usersRequest(),
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
                            height: 120,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.purple.shade200,
                            ),
                            child: Center(
                              child: FutureBuilder(
                                future: _getUserDetails(snapshot.data[index].id),
                                builder: (context, snapshot_2) {
                                  if (snapshot_2.hasData) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(snapshot_2.data.username),
                                        Text(snapshot_2.data.email),
                                        Text('Has Requested to follow you'),
                                        Row(
                                          children: <Widget>[
                                            IconButton(
                                                icon: Icon(Icons.check),
                                                onPressed: () {
                                                  _authData['other_id'] = snapshot.data[index].id;
                                                    _acceptFriendRequest(snapshot.data[index].id);
                                                  connectToServer();
                                                },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.cancel_outlined),
                                              onPressed: () {
                                                    _rejectFriendRequest(snapshot.data[index].id);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Text('failed to load user');
                                  }
                                },
                              ),
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
    );
  }

  _getUserDetails(some) async {
    var data = await Provider.of<GetUserThatRequested>(context, listen: false).getUserThatRequested(some);
    var theDetails = FriendRequestsModel.fromJson(data);
    return theDetails;
  }

  void _acceptFriendRequest(some) async {
    setState(() {
    });
    await Provider.of<AcceptFriendRequest>(context, listen: false).acceptFriendRequest(some);
  }
  void _rejectFriendRequest(some) async {
    setState(() {
    });
    await Provider.of<RejectFriendRequest>(context, listen: false).rejectFriendRequest(some);
  }

  connectToServer() async {
    try {
      socket = io('http://192.168.100.46:5000', <String, dynamic> {
        'transports': ['websocket'],
        'autoConnect': false,
      });

      socket.connect();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _authData['user_id'] = prefs.getInt('user_id');

      socket.on('accept_request', _acceptRequest(_authData));
    } catch (e) {
      print(e);
    }
  }

  _acceptRequest(Map<String, dynamic> data) async{
    socket.emit('accept_request', data);
  }
}
