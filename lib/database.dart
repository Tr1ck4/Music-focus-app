import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Song.dart';

class DBProvider {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  Future initDB() async {
    String path = join(await getDatabasesPath(), 'helper.db');
    var db = await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      singleInstance: true,
    );
    return db;
  }

  Future _onCreate(Database db, int version) async {
    const createUser =
        'CREATE TABLE User(name TEXT,file TEXT,isLiked INTEGER,playlist TEXT);';
    const populateHistory = '''INSERT INTO User(name, file, isLiked,playlist)
VALUES
	('Forest sounds',             'audio/Meditation/forest_sounds.mp3',                0,"Meditation"),
	('Waterfall sounds',          'audio/Meditation/waterfall_sounds.mp3',             0,"Meditation"),
	('Sleeping City',             'audio/Sleep/SleepingCity_JayLounge.mp3',            0,"Sleep"),
	('WYS',                       'audio/Sleep/WYS_LoneftEase.mp3',                    0,"Sleep"),
	('WokHard',                   'audio/Workout/WokHard.mp3',                         0,"Workout"),
	('IDidThatDiamond_Ortiz',     'audio/Workout/IDidThatDiamond_Ortiz.mp3',           0,"Workout"),
	('Causes_geek',               'audio/Study/Causes_geek.mp3',                       0,"Study"),
	('SoItBegins',                'audio/Study/SoItBeginsLofi.mp3',                    0,"Study");''';

    try {
      await db.execute(createUser);
      await db.execute(populateHistory);
    } catch (e) {
      rethrow;
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  Future<List<Song>> readPlaylist(String playlist) async {
    var dbClient = await db;
    final List<Map<String, dynamic>> rows = await dbClient.rawQuery(
        'SELECT u.name AS name, u.file as asset, u.isLiked as liked FROM User u WHERE u.playlist = ?;',
        [playlist]);
    return rows
        .map((row) => Song(
            name: row['name'].toString(),
            asset: row['asset'].toString(),
            liked: row['liked'] == 1 ? true : false))
        .toList();
  }

  Future<List<Song>> readAll() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> rows = await dbClient.rawQuery(
        'SELECT u.name AS name, u.file as asset, u.isLiked as liked FROM User u ;');
    return rows
        .map((row) => Song(
            name: row['name'].toString(),
            asset: row['asset'].toString(),
            liked: row['liked'] == 1 ? true : false))
        .toList();
  }

  updateSong(Song song) async {
    var dbClient = await db;
    dbClient.rawQuery('UPDATE User SET isLiked =  ? WHERE file = ?',
        [song.liked, song.asset]);
  }

  addSong(String name, bool isLiked, String asset, String playlist) async {
    var dbClient = await db;
    dbClient.rawInsert(
        'INSERT INTO User (name,file,isLiked,playlist) VALUES(?,?,?,?)',
        [name, asset, isLiked ? 1 : 0, playlist]);
  }

  Future<List<Song>> readLiked() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> rows = await dbClient.rawQuery(
        'SELECT u.name AS name, u.file as asset, u.isLiked as liked FROM User u WHERE u.isLiked = 1;');
    return rows
        .map((row) => Song(
            name: row['name'].toString(),
            asset: row['asset'].toString(),
            liked: row['liked'] == 1 ? true : false))
        .toList();
  }
}
