import 'package:mytreeflutter/api/util/Constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../api/models/TreeEntity.dart';

class DatabaseHelper {
  static const _databaseName = 'tree_db.db';
  static const _databaseVersion = 3;

  static const table = 'tree_db';

  static const columnId = 'id';
  static const columnAdresse = 'adresse';
  static const columnCirconfereencm = 'circonferenceencm';
  static const columnEspece = 'espece';
  static const columnHauteurenm = 'hauteurenm';
  static const columnTimestamp = 'timestamp';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnId TEXT PRIMARY KEY,
      $columnAdresse TEXT NOT NULL,
      $columnCirconfereencm INTEGER NOT NULL,
      $columnEspece TEXT NOT NULL,
      $columnHauteurenm INTEGER NOT NULL,
      $columnTimestamp TEXT NOT NULL
    )
  ''');
  }


  Future<List<TreeEntity>> getAllTrees(int start) async {
    int rows = Constants.numOfItems;
    final db = await database;
    final offset = (start - 1) * rows;
    final maps = await db.query(table, limit: rows, offset: offset);
    return List.generate(maps.length, (i) {
      return TreeEntity(
          id: maps[i][columnId].toString(),
          adresse: maps[i][columnAdresse].toString(),
          circonferenceencm: maps[i][columnCirconfereencm] as int,
          espece: maps[i][columnEspece].toString(),
          hauteurenm: maps[i][columnHauteurenm] as int,
          timestamp: maps[i][columnTimestamp].toString());
    });
  }


  Future<int> update(TreeEntity tree) async {
    final db = await database;
    return await db.update(table, tree.toMap(),
        where: '$columnId = ?', whereArgs: [tree.id]);
  }

  Future<void> insertAllTrees(List<TreeEntity> trees) async {
    final db = await database;
    final batch = db.batch();
    for (final tree in trees) {
      batch.insert(table, tree.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }
}
