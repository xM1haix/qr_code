import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

class DBHelper {
  DBHelper._privateConstructor();
  static final instance = DBHelper._privateConstructor();
  static Database? _database;
  static Future<Database> get db async => instance.database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    return openDatabase(
      join(await getDatabasesPath(), "data.db"),
      version: 1,
      onCreate: (db, v) async => db.execute(
        """CREATE TABLE Scans (id INTEGER PRIMARY KEY, data TEXT, timestamp INTEGER)""",
      ),
    );
  }
}

class Scanned {
  Scanned({required this.id, required int timestamp, required this.data})
      : _timestamp = timestamp;
  static Future<List<Scanned>> get getAll async =>
      (await (await DBHelper.db).rawQuery("SELECT * FROM Scans"))
          .map(
            (e) => Scanned(
              id: e["id"]! as int,
              timestamp: e["timestamp"]! as int,
              data: e["data"]! as String,
            ),
          )
          .toList();
  var selected = false;
  final int id;
  final int _timestamp;
  final String data;
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(_timestamp);
  Future<int> delete() async =>
      (await DBHelper.db).delete("Scans", where: "id = ?", whereArgs: [id]);
  static Future<int> insert(String d) async => (await DBHelper.db).insert(
        "Scans",
        {"timestamp": DateTime.now().millisecondsSinceEpoch, "data": d},
      );
}
