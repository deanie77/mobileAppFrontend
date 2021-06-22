import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/add_user_card.dart';
import 'package:mobile_app_trial_1/api/get_user_cards.dart';
import 'package:mobile_app_trial_1/forms/add_card_form.dart';
import 'package:mobile_app_trial_1/models/user_cards_model.dart';
import 'package:mobile_app_trial_1/models/user_wallet_model.dart';
import 'package:mobile_app_trial_1/pages/home.dart';
import 'package:provider/provider.dart';

class UserCardsScreen extends StatefulWidget {
  static const routeName = '/user/cards';
  @override
  _UserCardsScreenState createState() => _UserCardsScreenState();
}

class _UserCardsScreenState extends State<UserCardsScreen> {
  Future userCards;
  UserCardsModel theCards;

  @override
  Widget build(BuildContext context) {
    userCards = Provider.of<GetUserCards>(context, listen: false).getUserWalletCards();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pushReplacementNamed(Home.routeName);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
        title: Text('My Cards'),
         ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(16.0)),
            FutureBuilder(
              future: userCards,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Container(
                    child: new ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 80,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.purple.shade200,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      getCardNum(snapshot.data[index])??'waiting'
                                  ),
                                  Text(
                                      getCardStatus(snapshot.data[index])??'waiting'
                                  ),
                                  Text(
                                      '${getCardId(snapshot.data[index])}'??'waiting'
                                  ),
                                ],
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
            Padding(padding: EdgeInsets.all(5.0)),
            Container(
              height: 80,
              width: 360,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.purple.shade200,
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed(AddCardForm.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  getCardNum (some){
    theCards = UserCardsModel.fromJson(some);
    return theCards.card_number;
  }
  getCardStatus (some){
    theCards = UserCardsModel.fromJson(some);
    return theCards.card_status;
  }
  getCardId (some){
    theCards = UserCardsModel.fromJson(some);
    return theCards.card_id;
  }
}
