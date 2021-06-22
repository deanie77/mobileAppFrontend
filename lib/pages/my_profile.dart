import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/get_user_profile.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var userProfile;

  getProfile() async {
    userProfile = await Provider.of<GetUserProfile>(context, listen: false).getUserProfile();
    return userProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pushReplacementNamed(Home.routeName);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 120.0,
              color: Colors.purple,
            ),
            Padding(padding: EdgeInsets.all(16.0)),
            FutureBuilder(
              future: getProfile(),
              builder:(context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Text('${snapshot.data.first_name} ' + '${snapshot.data.last_name}'),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Text('${snapshot.data.username}'),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Text('${snapshot.data.email}')
                    ],
                  );
                } else {
                  return Text('something is wrong');
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
