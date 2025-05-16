import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/portfolio_model.dart';

class DBHelper {
static Database? _db;

Future<Database> get database async {
if (_db != null) return _db!;
_db = await _initDB();
return _db!;
}

Future<Database> _initDB() async {
final path = join(await getDatabasesPath(), 'portfolio.db');
return await openDatabase(
path,
version: 1,
onCreate: (db, version) {
return db.execute('''
CREATE TABLE portfolio (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
college TEXT,
skills TEXT,
projectTitle TEXT,
projectDescription TEXT
)
''');
},
);
}

Future<int> insertPortfolio(Portfolio portfolio) async {
final db = await database;
return await db.insert('portfolio', portfolio.toMap());
}

Future<List<Portfolio>> getAllPortfolios() async {
final db = await database;
final maps = await db.query('portfolio');
return maps.map((e) => Portfolio.fromMap(e)).toList();
}
}