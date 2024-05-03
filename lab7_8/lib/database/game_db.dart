import 'package:lab7_8/game.dart';
import 'package:sqflite/sqflite.dart';

class GameDB {
  static String query = """
  CREATE TABLE IF NOT EXISTS GAMES (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "rating" REAL NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT)
  )
  """;

  static Future<void> createTable(Database database) async {
    await database.execute(query);
  }

  static Future<dynamic> create(
      {required Database database,
      required String title,
      required double rating}) async {
    return await database.rawInsert(
        ''' INSERT INTO GAMES(title, rating) VALUES (?, ?)''', [title, rating]);
  }

  static Future<List<Game>> fetchAll(Database database) async {
    final games = await database.rawQuery(''' SELECT * FROM GAMES ''');
    return games.map((game) => Game.fromSqfliteDatabase(game)).toList();
  }

  static Future<Game> getGameById(
      {required Database database, required int id}) async {
    final game = await database.rawQuery(
      ''' SELECT * FROM GAMES WHERE id = ? ''',
      [id],
    );
    return Game.fromSqfliteDatabase(game.first);
  }

  static Future<int> update(
      {required Database database,
      required int id,
      required String title,
      required double rating}) async {
    return await database.update('GAMES', {'title': title, 'rating': rating},
        where: 'id = ?',
        conflictAlgorithm: ConflictAlgorithm.rollback,
        whereArgs: [id]);
  }

  static Future<void> delete(
      {required Database database, required int id}) async {
    await database.delete('GAMES', where: 'id = ?', whereArgs: [id]);
  }
}
