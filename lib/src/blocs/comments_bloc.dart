import 'dart:async';
import '../resources/repository.dart';
import '../models/item_model.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Streams..
  Observable<Map<int, Future<ItemModel>>> get commmentsStream =>
      _commentsOutput.stream;

  //Sinks..
  Function(int) get fetchCommentsOfItem => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, int index) {
        cache[id] = _repository.fetchItem(id);
        cache[id].then((item) {
          item.kids.forEach((itemId) {
            fetchCommentsOfItem(itemId);
          });
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
