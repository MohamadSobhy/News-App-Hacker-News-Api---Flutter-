import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildLoadingContainer(),
          subtitle: buildLoadingContainer(),
        ),
        Divider(
          height: 8.0,
        )
      ],
    );
  }

  Widget buildLoadingContainer(){
    return Container(
      width: 150.0,
      height: 24.0,
      color: Colors.grey[200],
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}