import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DB {
  static Future<Database> database() async {
    final dbpath = await getDatabasesPath();
    return openDatabase(
      path.join(dbpath, 'places.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DB.database();
    await db.insert('places', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DB.database();
    return db.query(table);
  }
}
