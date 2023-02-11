import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SQLManage {

  static final dbName = "sample.db";
  static final tableName = "Contact";
  static final colId = "ContactID";
  static final colName = 'ContactName';
  static final colName2 = 'AccountName';

  // static final SQLManage sqlInstance = SQLManage();


  // Database? _db;

  // Future<Database> get db async{
  //   _db ??= await initDB();
  //   return _db!;
  // }

Future<Database> get database async {
  if (_database != null) return _database!;

  _database = await _initDB('notes.db');
  return _database!;
}

Future<Database> _initDB(String filePath) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, filePath);

  return await openDatabase(path, version: 1, onCreate: _createDB);
}


Future _createDB(Database db, int version) async {
    // final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // final textType = 'TEXT NOT NULL';
    // final boolType = 'BOOLEAN NOT NULL';
    // final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableName ( 
  CREATE TABLE $tableName(
          $colId INTEGER PRIMARY KEY,
          $colName TEXT,
          $colName2 TEXT
  )
''');
  }
  initDB()async{
    return sql.openDatabase(dbName,version: 1,onCreate:onCreate );
  }

//   Future onCreate(Database _db,int versoin) async{
//     _db.execute(
//       '''
//         CREATE TABLE $tableName(
//           $colId INTEGER PRIMARY KEY,
//           $colName TEXT,
//           $colName2 TEXT
//         )
//       ''');
//   }

//   inserted(Map<String,dynamic> row)async{
//       Database _db = await sqlInstance.db;
//       _db.insert(tableName, row);
//   }

//   Future<List<Map<String,dynamic>>> readDB()async{
//     Database db = await sqlInstance.db;
//     return await db.query(tableName);
//   }
// }