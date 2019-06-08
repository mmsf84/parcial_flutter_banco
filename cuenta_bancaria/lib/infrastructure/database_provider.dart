import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cuenta_bancaria/infrastructure/ctabanca_dao.dart';
import 'package:cuenta_bancaria/infrastructure/opebanca_dao.dart';

class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  static Database _db;

  DatabaseProvider._internal();

  Future<Database> db() async {
    if (_db == null) {
      _db = await _init();
    }
    return _db;
  }

  Future<Database> _init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ctabanca_db2.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(CtaBancaDao().createTableQuery);
    await db.execute(OpeBancaDao().createTableQuery);
  }
}
