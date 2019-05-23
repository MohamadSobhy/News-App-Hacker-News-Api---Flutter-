import 'dart:async';
import '../resources/news_api_provider.dart';
import '../resources/news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = [newsDbProvider, NewsApiProvider()];
  List<Cache> caches = [newsDbProvider];

  //TODO iterate over sources when thee newsDbProvider get the fetchTopIds implemented.
  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for (source in sources) {
      item = await source.fetchItem(id);

      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source) cache.addItem(item);
    }

    return item;
  }

  clearCaches() async {
    for (var cache in caches){
      await cache.clearData();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clearData();
}
