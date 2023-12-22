import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DB {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'contact_buddy.db'),
      onCreate: createTable,
      onOpen: (dbPath) {},
      version: 1,
    );
  }

  static Future<void> createTable(Database db, int version) async {
    await db.execute('CREATE TABLE contacts('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'firstname TEXT,'
        'lastname TEXT,'
        'phone TEXT,'
        'email TEXT,'
        'UNIQUE(phone)'
        ')');
  }

  static Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await DB.database();
    return await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await DB.database();
    // final List<Map<String, Object?>> datas = await db.query(table);
    // return datas.map((e) => TrackingsModel.fromMap(e)).toList();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getByWhere(
      String table, columns, String where, List whereArgs, int limit) async {
    final db = await DB.database();
    return db.query(
      table,
      // columns: columns,
      where: where,
      whereArgs: whereArgs,
      limit: limit,
    );
  }

  static Future<int> update(String table, String? where, List? whereArgs,
      Map<String, dynamic> values) async {
    final db = await DB.database();
    return db.update(table, values, where: where, whereArgs: whereArgs);
  }

  static Future<int> delete(String table, String where, List whereArgs) async {
    final db = await DB.database();
    return db.delete(table, where: where, whereArgs: whereArgs);
  }

  static Future<List<Map<String, dynamic>>> customQuery(
      String sql, List<dynamic>? args) async {
    final db = await DB.database();
    return db.rawQuery(sql, args);
  }

  static Future<int> deleteall(String table) async {
    final db = await DB.database();
    return db.delete(table);
  }
}
