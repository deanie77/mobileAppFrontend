import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/create_wallet_qrcode.dart';
import 'package:mobile_app_trial_1/pages/home.dart';
import 'package:provider/provider.dart';

class QRCodePage extends StatefulWidget {
  static const routeName = '/myQRCode';

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  Future userWallet;

  @override
  Widget build(BuildContext context) {
    userWallet = Provider.of<CreateWalletQRCode>(context, listen: false).createWalletQR();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacementNamed(Home.routeName);
          },
        ),
        title: Text('My QR Code'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                      future: userWallet,
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: <Widget>[
                              BarcodeWidget(
                                barcode: Barcode.qrCode(),
                                color: Colors.purple.shade300,
                                data: snapshot.data,
                              ),
                            ],
                          );
                        } else {
                          return Text('something is wrong');
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
