import 'package:escribo_teste_03/models/avatar.dart';
import 'package:escribo_teste_03/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class AvatarController {
  AvatarController();

  Future<Avatar> getAvatar() async {
    Database db = await DbHelper().getDb();

    List<Map<String, dynamic>> result = await db.query('sys_avatars');

    if (result.isEmpty) {
      return Avatar(-1, '');
    } else {
      return Avatar.fromMap(result.first);
    }
  }

  Future<void> insertAvatar(Avatar avatar) async {
    Database db = await DbHelper().getDb();

    await db.insert(
      'sys_avatars',
      {
        'description': avatar.getAvatar(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateAvatar(Avatar avatar) async {
    Database db = await DbHelper().getDb();

    await db.update(
      'sys_avatars',
      {
        'avatar': avatar.getAvatar(),
      },
      where: 'id = ?',
      whereArgs: [avatar.getId()],
    );
  }
}
