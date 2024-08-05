import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Category (
        id TEXT PRIMARY KEY,
        name TEXT,
        icon INTEGER,
        colorCompleted INTEGER,
        colorUnCompleted INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE Todo (
        id TEXT PRIMARY KEY,
        taskTitle TEXT,
        taskDescription TEXT,
        categoryId TEXT,
        date INTEGER,
        time INTEGER,
        isCompleted INTEGER,
        createdAt INTEGER,
        updatedAt INTEGER,
        FOREIGN KEY (categoryId) REFERENCES Category (id)
      )
    ''');
  }
}
