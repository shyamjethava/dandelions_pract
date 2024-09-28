import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";
import '../models/entry_model.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('entries.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    await db.execute('''
      CREATE TABLE entries (
        id $idType,
        name $textType,
        description $textType
      )
    ''');
  }

  Future<int> createEntry(EntryModel entry) async {
    final db = await instance.database;
    return await db.insert('entries', entry.toMap());
  }

  Future<List<EntryModel>> readAllEntries() async {
    final db = await instance.database;
    final result = await db.query('entries');
    return result.map((json) => EntryModel.fromMap(json)).toList();
  }

  Future<int> updateEntry(EntryModel entry) async {
    final db = await instance.database;
    return await db.update('entries', entry.toMap(),
        where: 'id = ?', whereArgs: [entry.id]);
  }

  Future<int> deleteEntry(int id) async {
    final db = await instance.database;
    return await db.delete('entries', where: 'id = ?', whereArgs: [id]);
  }
}
