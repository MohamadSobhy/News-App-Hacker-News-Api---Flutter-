import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_container.dart';
import '../models/item_model.dart';
import 'dart:async';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        String commentTitle = snapshot.data.text.replaceAll('&#x27;', "'");
        commentTitle = commentTitle.replaceAll('&#x2F;', "/");
        commentTitle = commentTitle.replaceAll('<p>', '\n\n');
        commentTitle.replaceAll('</p>', '');

        List<Widget> children = [
          ListTile(
            title: Text(
              commentTitle,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Color.fromRGBO(1, 30, 76, 1),
                  size: 18.0,
                ),
                Text(
                  snapshot.data.by,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
            contentPadding: EdgeInsets.only(left: (depth * 16.0), right: 16.0),
          ),
          Divider(height: 1.0,
          color: Colors.black,)
        ];

        children.addAll(snapshot.data.kids.map((itemId) {
          return Comment(
            itemId: itemId,
            itemMap: itemMap,
            depth: depth + 1,
          );
        }).toList());

        children.add(Divider(
          height: 1.0,
        ));

        return Column(
          children: children,
        );
      },
    );
  }
}
