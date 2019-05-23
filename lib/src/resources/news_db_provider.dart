import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
          CREATE TABLE Items(
            id INTEGER PRIMARY KEY,
            deleted INTEGER,
            type TEXT,
            by TEXT,
            time INT,
            text TEXT,
            dead INTEGER,
            parent INTEGER,
            kids BLOB,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
          """);
    });
  }

  //TODO update this function in future..
  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<ItemModel> fetchItem(int id) async {
    final itemMap = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (itemMap.length > 0) {
      return ItemModel.fromDatabase(itemMap.first);
    }

    return null;
  }

  Future<int> clearData(){
    return db.delete('Items');
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      "Items",
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

final newsDbProvider = NewsDbProvider();
