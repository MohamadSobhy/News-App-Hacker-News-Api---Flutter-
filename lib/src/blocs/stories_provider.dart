import 'stories_bloc.dart';
import 'package:flutter/material.dart';
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final bloc;

  StoriesProvider({Key key, Widget child}) 
  : bloc = StoriesBloc(),
    super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static StoriesBloc of(BuildContext context){
    return ((context.inheritFromWidgetOfExactType(StoriesProvider)) as StoriesProvider).bloc;
  }
}