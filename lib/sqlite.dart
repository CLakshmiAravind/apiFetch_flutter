import 'package:sample/sqlite.dart' ;
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
// class DBHelper {
//   static Future<void> createTables(sql.Database database) async {
//     await database.execute('''
//         CREATE TABLE Contact(
//           ContactID : INTEGER PRIMARY KEY, 
//           ContactName : TEXT,
//           AccountName : TEXT
//         )
//       ''');
//   }
//   static Future<sql.Database> db() async{
//     return sql.openDatabase();
//   }
// }

class DBManager{
  static Future<void> createTables(Database database) async {
    await database.execute('''
        CREATE TABLE Contact(
          ContactID  INTEGER PRIMARY KEY, 
          ContactName  TEXT,
          AccountName  TEXT
        )
      ''');
  }

  static Future<Database> db() async{
    return openDatabase(
      'aravind.db',
      version: 1,
      onCreate: (Database database,int version) async{
        await createTables(database);
      }
    );
  }
   static Future<int> createItem(int num,String name, String accountName) async {
    final db = await DBManager.db();

    final data = {'ContactID': num,'ContactName': name, 'AccountName': accountName};
    final id = await db.insert('Contact', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    // print("I am here to create an item");
    return id;
  }
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DBManager.db();
    // print("I show all items in Contact Table");
    return db.query('Contact', orderBy: "ContactID");
  }
}
