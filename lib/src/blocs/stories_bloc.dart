import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/item_model.dart';
import 'dart:async';

class StoriesBloc{
  Repository _repository = Repository();
  PublishSubject<List<int>> _topIds = PublishSubject<List<int>>();
  BehaviorSubject<Map<int, Future<ItemModel>>> _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  PublishSubject<int> _itemsFetcher = PublishSubject<int>(); 

  //getters
  Observable<List<int>> get topIdsStream => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get itemsStream => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc(){
    _itemsFetcher.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCaches(){
    return _repository.clearCaches();
  }

  _itemsTransformer(){
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index){
        print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>> {},
    );
  }


  dispose(){
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}