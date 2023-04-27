import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? _myDatabase;

  checkDatabase() async {
    if(_myDatabase == null){
      _myDatabase = await initDabase();
    }
    return _myDatabase;
  }

  Future<Database> initDabase() async{
    Directory myDirectory = await getApplicationDocumentsDirectory();
    String pathDatabase = join(myDirectory.path, "QrDB.db");
    Database db = await openDatabase(
      pathDatabase,
      version: 1,
      onCreate: (Database db, int version){
        db.execute("CREATE TABLE QR(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, observation TEXT, url TEXT, datetime TEXT)");
      }
    );
    return db;
  }
}