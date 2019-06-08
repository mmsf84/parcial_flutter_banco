import 'package:cuenta_bancaria/infrastructure/ctabanca_dao.dart';
import 'package:cuenta_bancaria/infrastructure/ctabanca_repository.dart';
import 'package:cuenta_bancaria/infrastructure/database_provider.dart';
import 'package:cuenta_bancaria/model/ctabanca.dart';

class CtaBancaSqfliteRepository implements CtaBancaRepository {
  final dao = CtaBancaDao();

  @override
  DatabaseProvider databaseProvider;

  CtaBancaSqfliteRepository(this.databaseProvider);

  @override
  Future<int> insert(CtaBanca ctaBanca) async {
    final db = await databaseProvider.db();
    var id = await db.insert(dao.tableName, dao.toMap(ctaBanca));
    return id;
  }

  @override
  Future<int> delete(CtaBanca ctaBanca) async {
    final db = await databaseProvider.db();
    int result = await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [ctaBanca.id]);
    return result;
  }

  @override
  Future<int> update(CtaBanca ctaBanca) async {
    final db = await databaseProvider.db();
    int result = await db.update(dao.tableName, dao.toMap(ctaBanca),
        where: dao.columnId + " = ?", whereArgs: [ctaBanca.id]);
    return result;
  }

  @override
  Future<List<CtaBanca>> getList() async {
    final db = await databaseProvider.db();
    var result = await db.rawQuery("SELECT * FROM ctabanca order by id ASC");
    return dao.fromList(result);
  }
}