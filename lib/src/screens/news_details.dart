import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget{
  final itemId;
  
  NewsDetails({this.itemId});

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Text('$itemId'),
    );
  }
}