import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final instance = DBHelper._privateConstructor();
  static Database? _database;
  static Future<Database> get db async => await instance.database;
  DBHelper._privateConstructor();
  Future<Database> get database async {
    if (_database != null) return _database!;
    return await openDatabase(
      join(await getDatabasesPath(), 'data.db'),
      version: 1,
      onCreate: (db, v) async => await db.execute(
        "CREATE TABLE Scans (id INTEGER PRIMARY KEY, data TEXT, timestamp INTEGER)",
      ),
    );
  }
}

class Scanned {
  static Future<List<Scanned>> get getAll async =>
      (await (await DBHelper.db).rawQuery("SELECT * FROM Scans"))
          .map((e) => Scanned(
              id: e['id'] as int,
              timestamp: e['timestamp'] as int,
              data: e['data'] as String))
          .toList();
  bool selected = false;
  final int id, _timestamp;
  final String data;
  Scanned({required this.id, required int timestamp, required this.data})
      : _timestamp = timestamp;
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(_timestamp);
  Future<int> delete() async => await (await DBHelper.db)
      .delete("Scans", where: "id = ?", whereArgs: [id]);
  static Future<int> insert(String d) async => await (await DBHelper.db).insert(
      'Scans', {'timestamp': DateTime.now().millisecondsSinceEpoch, 'data': d});
}
