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
        'description': favorite.getDescription(),
        'type': favorite.getType(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String description) async {
    Database db = await DbHelper().getDb();

    await db.delete('sys_favorites',
        where: 'description = ?', whereArgs: [description]);
  }

  Future<bool> verifyFavorite(String description) async {
    List<Favorite> favorites = await getFavorites();

    return favorites.indexWhere(
              (element) => element.description == description,
            ) >
            0
        ? true
        : false;
  }
}
