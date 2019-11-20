import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './models/user.dart';

Future<int> insertUser(User user) async {
  final Database db = await _getDatabase();

  return await db.insert(
    'users',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> deleteUser(int id) async {
  final db = await _getDatabase();

  await db.delete(
    'users',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<List<User>> getUserList() async {
  final Database db = await _getDatabase();

  final List<Map<String, dynamic>> maps = await db.query('users');

  return List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'],
      name: maps[i]['name'],
      age: maps[i]['age'],
      sex: maps[i]['sex'] == 0 ? false : true,
    );
  });
}

Future<Database> _getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'mydb.db'),
    onOpen: (db) {
      return db.execute(
        'CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, sex BOOLEAN)',
      );
    },
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, sex BOOLEAN)',
      );
    },
    version: 1,
  );
} 