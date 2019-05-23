import 'package:flutter/material.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_list.dart';
import 'screens/news_details.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        onGenerateRoute: generateRoutes,
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
        return NewsDetails(
          itemId: itemId,
        );
      });
    }
  }
}
