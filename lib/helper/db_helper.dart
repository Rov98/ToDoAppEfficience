import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class DBhelper {
  static const tableName = 'todo_table';
  static const dbName = 'todo_app.db';

  static Future<sqlite.Database> getDB() async {
    const sqlCmd =
        'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, title TEXT, note TEXT)';
    final dbPath = await sqlite.getDatabasesPath();

    //create db, if exist overwrite
    return sqlite.openDatabase(
      path.join(dbPath, dbName),
      onCreate: (db, version) => db.execute(sqlCmd),
      version: 1,
    );
  }

  static Future<void> insert(int id, String title, note) async {
    //initialize the db first
    final db = await DBhelper.getDB();
    db.insert(tableName, {
      'id': id,
      'title': title,
      'note': note,
    });
  }

  static Future<void> update(int id, String title, note) async {
    final db = await DBhelper.getDB();
    // final sqlCmd =
    //     'UPDATE $tableName SET title = $title, note = $note WHERE id = $id';
    // db.rawUpdate(sqlCmd);
    db.update(
        tableName,
        {
          'title': title,
          'note': note,
        },
        where: 'id = $id');
  }

  static Future<void> delete(int id) async {
    final db = await DBhelper.getDB();
    // final sqlCmd = 'DELETE FROM $tableName WHERE id = $id';
    // db.rawDelete(sqlCmd);
    db.delete(tableName, where: 'id = $id');
  }

  static Future<Future<List<Map<String, Object?>>>> fetchData() async {
    final db = await DBhelper.getDB();
    final sqlCmd = 'SELECT * FROM $tableName';
    return db.rawQuery(sqlCmd);
  }
}
