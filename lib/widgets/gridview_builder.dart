import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/classes/grid_icons.dart';

class GridViewBuilderWidget extends StatelessWidget {
  const GridViewBuilderWidget ({
    Key key
}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    List<IconData> _iconList = GridIcons().getIconList();
    List<Text> _textList = GridIcons().getTextList();
    
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 11,
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150.0),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.purple.shade50,
          margin: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                _iconList[index],
                size: 48.0,
                color: Colors.purple,
              ),
              _textList[index],
            ],
          ),
        );
      },
    );
  }
}
