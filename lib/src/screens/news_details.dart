import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_container.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class NewsDetails extends StatelessWidget {
  final itemId;

  NewsDetails({this.itemId});

  Widget build(BuildContext context) {
    final commentsBloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 30, 76, 1),
        title: Text('Details'),
      ),
      body: StreamBuilder(
        stream: commentsBloc.commmentsStream,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }

          return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingContainer();
              }

              return buildList(itemSnapshot.data, snapshot.data);
            },
          );
        },
      ),
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    List<Widget> children = [
      buildTitle(item),
      Divider(
        height: 2.0,
      )
    ];

    children.addAll(item.kids
        .map((itemId) => Comment(
              itemId: itemId,
              itemMap: itemMap,
              depth: 1,
            ))
        .toList());

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(1, 30, 76, 1)
        ),
      ),
    );
  }
}
