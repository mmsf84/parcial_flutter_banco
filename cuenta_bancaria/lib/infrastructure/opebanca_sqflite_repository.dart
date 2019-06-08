import 'package:cuenta_bancaria/infrastructure/opebanca_dao.dart';
import 'package:cuenta_bancaria/infrastructure/opebanca_repository.dart';
import 'package:cuenta_bancaria/infrastructure/database_provider.dart';
import 'package:cuenta_bancaria/model/opebanca.dart';

class OpeBancaSqfliteRepository implements OpeBancaRepository {
  final dao = OpeBancaDao();

  @override
  DatabaseProvider databaseProvider;

  OpeBancaSqfliteRepository(this.databaseProvider);

  @override
  Future<int> insert(OpeBanca opeBanca) async {
    final db = await databaseProvider.db();
    var id = await db.insert(dao.tableName, dao.toMap(opeBanca));
    return id;
  }

  @override
  Future<List<OpeBanca>> getList() async {
    final db = await databaseProvider.db();
    var result = await db.rawQuery("SELECT * FROM opebanca order by id ASC");
    return dao.fromList(result);
  }
}