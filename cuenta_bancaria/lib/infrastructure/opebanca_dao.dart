import 'package:cuenta_bancaria/infrastructure/dao.dart';
import 'package:cuenta_bancaria/model/opebanca.dart';

class OpeBancaDao implements Dao<OpeBanca> {
  final tableName = 'opebanca';
  final columnId = 'id';  
  final _columnNroCta = 'nrocta_id';
  final _columnTipo = 'tipo';
  final _columnMonto = 'monto';

  @override
  String get createTableQuery =>
    "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
    " $_columnNroCta INTEGER,"
    " $_columnTipo INTEGER,"
    " $_columnMonto DECIMAL)";

  @override
  OpeBanca fromMap(Map<String, dynamic> query) {
    OpeBanca opeBanca = OpeBanca(query[_columnNroCta], query[_columnTipo], query[_columnMonto]);
    return opeBanca;
  }

  @override
  Map<String, dynamic> toMap(OpeBanca opeBanca) {
    return <String, dynamic>{
      _columnNroCta: opeBanca.nrocta,
      _columnTipo: opeBanca.tipo,
      _columnMonto: opeBanca.monto
    };
  }

  OpeBanca fromDbRow(dynamic row) {
    return OpeBanca.withId(row[columnId], row[_columnNroCta], row[_columnTipo], row[_columnMonto]);
  }

  @override
  List<OpeBanca> fromList(result) {
    List<OpeBanca> operaciones = List<OpeBanca>();
    var count = result.length;
    for (int i = 0; i < count; i++) {
      operaciones.add(fromDbRow(result[i]));
    }
    return operaciones;
  }
}
