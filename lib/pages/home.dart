import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/widgets/home_body.dart';
import 'package:mobile_app_trial_1/widgets/income_expenses_widget.dart';
import 'package:mobile_app_trial_1/widgets/left_drawer.dart';
import 'package:mobile_app_trial_1/widgets/short_menu_list.dart';
import 'homie.dart';
import 'messages.dart';
import 'wallet.dart';
import 'friends.dart';
import 'my_profile.dart';
import 'settings.dart';
import 'transaction_history.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  List _listPages = List();
  Widget _currentPage;

  @override
  void initState() {
    super.initState();

    _listPages
      ..add(Messages())
      ..add(Homie())
      ..add(Wallet());
    _currentPage = Homie();
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listPages[selectedIndex];
    });
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WaiketaPay'),
        actions: <Widget>[
          const ShortMenuListWidget(),
        ],
      ),
      drawer: const LeftDrawerWidget(),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.send_outlined),
            title: Text('messages'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined
            ),
            title: Text('Wallet'),
          ),
        ],
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
    );
  }
}
