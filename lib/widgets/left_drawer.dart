import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/get_user_profile.dart';
import 'package:mobile_app_trial_1/widgets/menu_list_tile.dart';
import 'package:provider/provider.dart';

class LeftDrawerWidget extends StatelessWidget {
  const LeftDrawerWidget ({Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<GetUserProfile>(context, listen: false).getUserProfile();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder(
            future: userInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: Icon(
                    Icons.face,
                    size: 48.0,
                    color: Colors.white,
                  ),
                  accountName: Text('${snapshot.data.username}'),
                  accountEmail: Text('${snapshot.data.email}'),
                  otherAccountsPictures: <Widget>[
                    Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),
                  ],
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/dawn.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('something is wrong');
              }
              return CircularProgressIndicator();
            }
          ),
          const MenuListTileWidget(),
        ],
      ),
    );
  }
}
