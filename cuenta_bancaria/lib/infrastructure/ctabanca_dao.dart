import 'package:cuenta_bancaria/infrastructure/dao.dart';
import 'package:cuenta_bancaria/model/ctabanca.dart';

class CtaBancaDao implements Dao<CtaBanca> {
  final tableName = 'ctabanca';
  final columnId = 'id';
  final _columnName = 'nombre';
  final _columnLastname = 'apellido';
  final _columnNroCta = 'nrocta';
  final _columnSaldo = 'saldo';

  @override
  String get createTableQuery =>
    "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
    " $_columnName TEXT,"
    " $_columnLastname TEXT,"
    " $_columnNroCta TEXT,"
    " $_columnSaldo REAL)";

  @override
  CtaBanca fromMap(Map<String, dynamic> query) {
    CtaBanca ctaBanca = CtaBanca(query[_columnName], query[_columnLastname], query[_columnNroCta], query[_columnSaldo]);
    return ctaBanca;
  }

  @override
  Map<String, dynamic> toMap(CtaBanca ctaBanca) {
    return <String, dynamic>{
      _columnName: ctaBanca.nombre,
      _columnLastname: ctaBanca.apellido,
      _columnNroCta: ctaBanca.nrocta,
      _columnSaldo: ctaBanca.saldo
    };
  }

  CtaBanca fromDbRow(dynamic row) {
    return CtaBanca.withId(row[columnId], row[_columnName], row[_columnLastname], row[_columnNroCta], row[_columnSaldo]);
  }

  @override
  List<CtaBanca> fromList(result) {
    List<CtaBanca> ctas = List<CtaBanca>();
    var count = result.length;
    for (int i = 0; i < count; i++) {
      ctas.add(fromDbRow(result[i]));
    }
    return ctas;
  }
}
