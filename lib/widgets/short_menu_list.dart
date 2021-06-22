import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/log_out_user.dart';
import 'package:mobile_app_trial_1/classes/short_menu.dart';
import 'package:mobile_app_trial_1/pages/qr_code_page.dart';
import 'package:mobile_app_trial_1/pages/qr_scanner_page.dart';
import 'package:mobile_app_trial_1/screens/user_login_screen.dart';
import 'package:provider/provider.dart';

class ShortMenuListWidget extends StatelessWidget{
  const ShortMenuListWidget({Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: PopupMenuButton<ShortMenuItem>(
          icon: Icon(Icons.add_circle_outline_rounded),
          onSelected: ((valueSelected){
            print('valueSelected: ${valueSelected.title}');
            if (valueSelected.title == 'New Message'){

            }
            if (valueSelected.title == 'Scan'){
              Navigator.of(context).pushReplacementNamed(QRScannerPage.routeName);
            }
            if (valueSelected.title == 'Receive Money'){
              Navigator.of(context).pushReplacementNamed(QRCodePage.routeName);
            }
            if (valueSelected.title == 'Logout'){
              Provider.of<LogOutUser>(context, listen: false).logOutUser();
              Navigator.of(context).pushReplacementNamed(UserLoginScreen.routeName);
            }
          }),
          itemBuilder: (BuildContext context){
            return shortMenuList.map((ShortMenuItem shortMenuItem){
              return PopupMenuItem<ShortMenuItem>(
                value: shortMenuItem,
                child: Row(
                  children: <Widget>[
                    FlatButton(child: Icon(shortMenuItem.icon.icon, color: Colors.black,)
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Text(shortMenuItem.title),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
