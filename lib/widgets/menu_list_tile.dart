import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/pages/friends.dart';
import 'package:mobile_app_trial_1/pages/my_profile.dart';
import 'package:mobile_app_trial_1/pages/settings.dart';
import 'package:mobile_app_trial_1/pages/transaction_history.dart';
import 'package:mobile_app_trial_1/screens/user_cards_screen.dart';

class MenuListTileWidget extends StatefulWidget {
  const MenuListTileWidget ({
    Key key,
  }) : super(key: key);

  @override
  _MenuListTileWidgetState createState() => _MenuListTileWidgetState();
}

class _MenuListTileWidgetState extends State<MenuListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('My Profile'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyProfile(),
                ),
            );
          },
        ),
        Divider(color: Colors.purple,),
        ListTile(
          leading: Icon(Icons.contact_page_rounded),
          title: Text('Friends'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Friends(),
              ),
            );
          },
        ),
        Divider(color: Colors.purple,),
        ListTile(
          leading: Icon(Icons.credit_card_outlined),
          title: Text('Cards'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserCardsScreen(),
              ),
            );
          },
        ),
        Divider(color: Colors.purple,),
        ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text('Transaction History'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionHistory(),
              ),
            );
          },
        ),
        Divider(color: Colors.purple,),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Settings(),
              ),
            );
          },
        ),
      ],
    );
  }
}
