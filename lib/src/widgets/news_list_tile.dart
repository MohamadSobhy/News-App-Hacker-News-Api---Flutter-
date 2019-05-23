import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../models/item_model.dart';
import '../widgets/loading_container.dart';

class NewsListTile extends StatelessWidget{
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.itemsStream,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot){
        if(!snapshot.hasData){
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot){
            if(!itemSnapshot.hasData){
              return LoadingContainer();
            }

            return buildListTile(itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildListTile(ItemModel item){
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('${item.title}'),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}')
            ],
          ),
        ),
        Divider(
          height: 8.0,
        )
      ],
    );
  }
}