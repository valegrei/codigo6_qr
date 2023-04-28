import 'dart:io';

import 'package:codigo6_qr/models/qr_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  static final DBAdmin _instance = DBAdmin._singleton();
  Database? _myDatabase;

  DBAdmin._singleton();

  factory DBAdmin(){
    return _instance;
  }

  Future<Database?> _checkDatabase() async {
    if(_myDatabase == null){
      _myDatabase = await _initDabase();
    }
    return _myDatabase;
  }

  Future<Database> _initDabase() async{
    Directory myDirectory = await getApplicationDocumentsDirectory();
    String pathDatabase = join(myDirectory.path, "QrDB.db");
    return await openDatabase(
      pathDatabase,
      version: 1,
      onCreate: (Database db, int version){
        db.execute("CREATE TABLE QR(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, observation TEXT, url TEXT, datetime TEXT)");
      }
    );
  }

  Future<List<QRModel>> getQRList() async {
    final Database? db = await _checkDatabase();
    List data = await db!.query("QR");
    List<QRModel> qrList = data.map((e) => QRModel.fromJson(e)).toList();
    return qrList;
  }

  Future<int> inserQR(QRModel model) async {
    final Database? db = await _checkDatabase();
    return await db!.insert("QR", model.toJson());
  }
}