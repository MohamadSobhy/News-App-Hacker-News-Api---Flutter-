import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_list.dart';
import 'screens/news_details.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: generateRoutes,
        ),
      ),
    );
  }

  Route generateRoutes(RouteSettings settings) {
    final routeName = settings.name;

    if (routeName == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        },
      );
    } else {
      final itemId = int.parse(routeName.replaceFirst('/', ''));
      return MaterialPageRoute(builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        commentsBloc.fetchCommentsOfItem(itemId);
        return NewsDetails(
          itemId: itemId,
        );
      });
    }
  }
}
