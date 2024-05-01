import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yumprint/data_layer/model/user_profile_model.dart';

class SqliteDb extends Sqflite {
  SqliteDb._();

  static final SqliteDb sqliteDb = SqliteDb._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await getDatabaseInstance();
    return _database!;
  }

  Future<Database> getDatabaseInstance() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      join(path, 'profile_db.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE profile_db (id INTEGER PRIMARY KEY, user_image TEXT, user_name TEXT)');
      },
    );
  }

  insertUserItem(UserProfileModel userProfileModel) async {
    Database db = await database;
    db.insert('profile_db', userProfileModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<UserProfileModel>> getListItem() async {
    Database db = await database;
    final list = await db.query('profile_db');
    return List.from(list).map((e) => UserProfileModel.fromJson(e)).toList();
  }

  deleteDb() async {
    Database db = await database;
    db.delete('profile_db');
  }
}
