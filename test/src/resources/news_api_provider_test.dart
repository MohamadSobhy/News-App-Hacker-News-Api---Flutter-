import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news/src/resources/news_api_provider.dart';

void main(){
  test('Fetching data using fetchTopIds() method', () async {
    final newsApi = new NewsApiProvider();
    newsApi.client = MockClient(
      (request) async{
        return Response(json.encode([1, 2, 3, 4]), 200);
      }
    );

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem method returns an ItemModel', () async {
    final newsApi = new NewsApiProvider();
    newsApi.client = MockClient((request) async{
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(900);
    expect(item.id, 123);
  });
}