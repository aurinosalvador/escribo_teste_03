import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? _db;
  static const int DB_VERSION = 1;

  static Future<void> deleteTables(Database db) async {
    Batch batch = db.batch();

    batch.execute('DELETE FROM sys_avatar');
    batch.execute('DELETE FROM sys_favorites');

    await batch.commit();
  }

  Future<Database> getDb() async {
    if (_db == null) {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'sw_favorites.db');

      if (!await Directory(dirname(path)).exists()) {
        await Directory(dirname(path)).create(recursive: true);
      }

      _db ??= await openDatabase(
        path,
        version: DB_VERSION,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    }

    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('CREATE TABLE IF NOT EXISTS sys_avatar ('
        '"id" INTEGER PRIMARY KEY NOT NULL,'
        '"avatar" TEXT NOT NULL);');

    batch.execute('CREATE TABLE IF NOT EXISTS sys_favorites ('
        '"id" INTEGER PRIMARY KEY NOT NULL,'
        '"description" TEXT NOT NULL,'
        '"type" TEXT NOT NULL);');

    await batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();

    batch.execute('DROP TABLE IF EXISTS sys_avatar');
    batch.execute('DROP TABLE IF EXISTS sys_favorites');

    await batch.commit();

    await _onCreate(db, newVersion);
  }
}
