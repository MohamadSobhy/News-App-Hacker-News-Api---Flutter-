import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../models/item_model.dart';
import '../widgets/loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.itemsStream,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildListTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildListTile(BuildContext context, ItemModel item) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/${item.id}');
            },
            title: Text(
              '${item.title}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(1, 30, 76, 1),
              ),
            ),
            subtitle: Text('${item.score} votes'),
            trailing: Column(
              children: <Widget>[
                Icon(
                  Icons.comment,
                  size: 35.0,
                  color: Color.fromRGBO(1, 30, 76, 0.3),
                ),
                Text(
                  '${item.descendants}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(1, 30, 76, 1),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1.0,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
