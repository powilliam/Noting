import 'dart:async';
import 'package:sqflite/sqflite.dart';

abstract class NotesProviderContract {
  Future<List<Map<String, dynamic>>> getAll();
  Future<Map<String, dynamic>> create(Map<String, dynamic> values);
  Future<String> update(String id, Map<String, dynamic> values);
  Future<String> delete(String id);
}

class NotesProvider implements NotesProviderContract {
  static const String _databaseName = 'notes.db';
  static const int _databaseVersion = 1;

  FutureOr<void> _onCreate(Database database, int version) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS Notes (
        id TEXT PRIMARY KEY NOT NULL,
        headline TEXT NOT NULL,
        content TEXT,
        date INTEGER NOT NULL
      );
    """);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    try {
      final Database db = await openDatabase(_databaseName,
          onCreate: _onCreate, version: _databaseVersion);
      return await db.query('Notes');
    } catch (_) {
      throw Exception('Cannot get data{}');
    }
  }

  @override
  Future<Map<String, dynamic>> create(Map<String, dynamic> values) async {
    try {
      final Database db = await openDatabase(_databaseName,
          onCreate: _onCreate, version: _databaseVersion);
      await db.insert('Notes', values,
          conflictAlgorithm: ConflictAlgorithm.rollback);
      return values;
    } catch (_) {
      throw Exception('Cannot insert data{values: $values}');
    }
  }

  @override
  Future<String> update(String id, Map<String, dynamic> values) async {
    try {
      final Database db = await openDatabase(_databaseName,
          onCreate: _onCreate, version: _databaseVersion);
      await db.update('Notes', values,
          where: "id = ?",
          whereArgs: [id],
          conflictAlgorithm: ConflictAlgorithm.rollback);
      return id;
    } catch (_) {
      throw Exception('Cannot update data{id: $id, values: $values}');
    }
  }

  @override
  Future<String> delete(String id) async {
    try {
      final Database db = await openDatabase(_databaseName,
          onCreate: _onCreate, version: _databaseVersion);
      await db.delete(
        'Notes',
        where: "id = ?",
        whereArgs: [id],
      );
      return id;
    } catch (_) {
      throw Exception('Cannot delete data{id: $id}');
    }
  }
}
