import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_credentials.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE credentials(id INTEGER PRIMARY KEY, username TEXT, password TEXT)",
        );
      },
    );
  }

  Future<void> saveCredentials(String username, String password) async {
    final db = await database;
    await db.insert(
      'credentials',
      {'username': username, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, String>> getCredentials() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('credentials');
    if (maps.isNotEmpty) {
      return {
        'username': maps.first['username'],
        'password': maps.first['password'],
      };
    }
    return {'username': '', 'password': ''};
  }

  Future<void> clearCredentials() async {
    final db = await database;
    await db.delete('credentials');
  }
}
