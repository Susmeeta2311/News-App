import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'news_history.db');
    return await openDatabase(
      path,
      version: 2, // Increment version number to apply new schema
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            url TEXT UNIQUE, 
            imageUrl TEXT, 
            publishedAt TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE history ADD COLUMN imageUrl TEXT;");
          await db.execute("ALTER TABLE history ADD COLUMN publishedAt TEXT;");
        }
      },
    );
  }

  Future<int> insertNews(Map<String, dynamic> news) async {
    final db = await database;
    try {
      return await db.insert('history', news, conflictAlgorithm: ConflictAlgorithm.ignore);
    } catch (e) {
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getNewsHistory() async {
    final db = await database;
    return await db.query(
      'history',
      columns: ['id', 'title', 'description', 'url', 'imageUrl', 'publishedAt'], // Include all fields
      orderBy: 'id DESC',
    );
  }


  Future<int> deleteNews(int id) async {
    final db = await database;
    return await db.delete('history', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> clearHistory() async {
    final db = await database;
    return await db.delete('history');
  }

  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
