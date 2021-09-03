import 'package:escribo_teste_03/models/favorite.dart';
import 'package:escribo_teste_03/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteController {
  FavoriteController();

  Future<List<Favorite>> getFavorites() async {
    Database db = await DbHelper().getDb();

    List<Favorite> favorites = [];

    List<Map<String, dynamic>> result = await db.query('sys_favorites');

    if (result.isNotEmpty) {
      for (Map<String, dynamic> rs in result) {
        Favorite favorite = Favorite.fromMap(rs);
        favorites.add(favorite);
      }
    }

    return favorites;
  }

  Future<void> insertFavorite(Favorite favorite) async {
    Database db = await DbHelper().getDb();

    await db.insert(
      'sys_favorites',
      {
        'description': favorite.description,
        'type': favorite.type,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String description, String type) async {
    Database db = await DbHelper().getDb();

    await db.delete(
      'sys_favorites',
      where: 'description = ? AND type = ?',
      whereArgs: [description, type],
    );
  }

  Future<bool> verifyFavorite(String description, String type) async {
    Database db = await DbHelper().getDb();

    List<Map<String, dynamic>> result = await db.query(
      'sys_favorites',
      where: 'description = ? AND type = ?',
      whereArgs: [description, type],
      limit: 1,
    );

    return result.isNotEmpty;
  }
}
