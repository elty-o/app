import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
// import 'package:path/path.dart';

class FavoriteHelper {
  static Future<sql.Database> db() async {
    debugPrint("THIS IS IN THE HELPER CLASS db()");
    // final databasesPath = await sql.getDatabasesPath();
    // final path = join(databasesPath, 'eservices.db');
    // await sql.deleteDatabase(path);
    return sql.openDatabase('eservices.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      debugPrint("THIS IS IN THE HELPER CLASS createTables()");
      await createTables(database);
    });
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE favorite(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      url TEXT,
      indicator TEXT,
      createdDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  // static Future<void> deleteTable() async {
  //   final database = await FavoriteHelper.db();
  //   database.execute('DROP TABLE favorite');
  // }

  static Future<int> createItem(
      String name, String url, String indicator) async {
    final database = await FavoriteHelper.db();
    final data = {'name': name, 'url': url, 'indicator': indicator};

    final id = await database.insert('favorite', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItemsWithTrueIndicator() async {
    final db = await FavoriteHelper.db();
    return db.query('favorite', where: "indicator = ?", whereArgs: ['true']);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await FavoriteHelper.db();
    return db.query('favorite', orderBy: "name");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await FavoriteHelper.db();
    return db.query('favorite', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String name, String url, String indicator) async {
    final db = await FavoriteHelper.db();
    final data = {
      'name': name,
      'url': url,
      'indicator': indicator,
      'createdDate': DateTime.now().toString()
    };
    final result =
        await db.update('favorite', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await FavoriteHelper.db();
    try {
      await db.delete('favorite', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Cannot delete item: $err");
    }
  }

  static Future<void> deleteItemByName(String name) async {
    final db = await FavoriteHelper.db();
    try {
      await db.delete('favorite', where: "name = ?", whereArgs: [name]);
    } catch (err) {
      debugPrint("Cannot delete item: $err");
    }
  }
}
