import 'package:cuenta_bancaria/infrastructure/database_provider.dart';
import 'package:cuenta_bancaria/model/ctabanca.dart';

abstract class CtaBancaRepository {
  DatabaseProvider databaseProvider;
  Future<int> insert(CtaBanca ctaBanca);
  Future<int> update(CtaBanca ctaBanca);
  Future<int> delete(CtaBanca ctaBanca);
  Future<List<CtaBanca>> getList();
}