import 'package:android_tutorial/models/models.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  String _dbName = 'mobile_app_db.db';
  Database _database;

  Future initDatabase() async {
    _database = await openDatabase(
      _dbName,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE friend (id INTEGER UNIQUE, last_name TEXT, first_name TEXT, mobile_phone TEXT)',
        );
      },
    );
  }

  Future insertToFriendDatabase(FriendModel friend) async {
    if (_database == null) {
      await initDatabase();
    }
    var result = await _database.rawQuery(
        'INSERT INTO friend (id, last_name, first_name, mobile_phone) VALUES (${friend.id}, "${friend.lastName}", "${friend.firstName}", "${friend.mobilePhone}")');
    print(result);
  }

  Future<List<FriendModel>> getFriendsFromDatabase() async {
    if (_database == null) {
      await initDatabase();
    }
    var result = await _database
        .rawQuery('SELECT id, last_name, first_name, mobile_phone FROM friend');
    var friendsFromDb = result.map((e) => FriendModel.fromJson(e)).toList();
    return friendsFromDb;
  }
}
