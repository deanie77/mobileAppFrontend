import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/screens/chat_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationList extends StatefulWidget {
  String username;
  String message;
  String avatar;
  bool isMessageRead;
  int id;

  ConversationList({@required this.username, @required this.message, @required this.avatar, @required this.isMessageRead, @required this.id});

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(userName: widget.username, id: widget.id,);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/dawn.jpg'),
                      maxRadius: 30,
                    ),
                    SizedBox(width: 16.0,),
                    Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.username, style: TextStyle(fontSize: 16.0),),
                              SizedBox(height: 6.0,),
                              Text(widget.message, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                            ],
                          ),
                        ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
