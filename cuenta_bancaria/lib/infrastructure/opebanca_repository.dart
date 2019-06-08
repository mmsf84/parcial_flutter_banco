import 'package:cuenta_bancaria/infrastructure/database_provider.dart';
import 'package:cuenta_bancaria/model/opebanca.dart';

abstract class OpeBancaRepository {
  DatabaseProvider databaseProvider;
  Future<int> insert(OpeBanca opeBanca);
  Future<List<OpeBanca>> getList();
}