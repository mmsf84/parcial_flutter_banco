import 'package:flutter/material.dart';
import 'package:cuenta_bancaria/infrastructure/opebanca_sqflite_repository.dart';
import 'package:cuenta_bancaria/infrastructure/database_provider.dart';
import 'package:cuenta_bancaria/model/opebanca.dart';

OpeBancaSqfliteRepository opeBancaRepository = OpeBancaSqfliteRepository(DatabaseProvider.get);
final List<String> choices = const <String> [
  'Guardar Operación & Volver',
  'Volver a la lista de operaciones'
];

const mnuSave = 'Guardar Cuenta & Volver';
const mnuBack = 'Volver a la lista';

class OpeBancaInsert extends StatefulWidget {
  final OpeBanca opeBanca;
  OpeBancaInsert(this.opeBanca);

  @override
  State<StatefulWidget> createState() => OpeBancaInsertState(opeBanca);
}

class OpeBancaInsertState extends State<OpeBancaInsert> {
  OpeBanca opeBanca;
  OpeBancaInsertState(this.opeBanca);
  final _tipoList = ["Deposito","Retiro"];  
  
  TextEditingController nroctaController = TextEditingController();
  TextEditingController montoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nroctaController.text = opeBanca.nrocta.toString();
    montoController.text = opeBanca.monto.toString();

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(opeBanca.nrocta.toString()),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding( 
        padding: EdgeInsets.only(top:35.0, left: 10.0, right: 10.0),
        child: ListView(children: <Widget>[Column(
        children: <Widget>[
          TextField(
            controller: nroctaController,
            style: textStyle,
            onChanged: (value) => this.updateNroCta(),
            decoration: InputDecoration(
              labelText: "Nro. Cuenta",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),
          ListTile(title:DropdownButton<String>(
            items: _tipoList.map((int value) {
              return DropdownMenuItem<String> (
                value: value.toString(),
                child: Text(value.toString()),
              );
            }).toList(),
            style: textStyle,
            value: retrieveTipo(opeBanca.tipo).toString(),
            onChanged: (value) => updateTipo(value),
          )),
          Padding(
            padding: EdgeInsets.only(top:15.0, bottom: 15.0),
            child: TextField(
            controller: saldoController,
            style: textStyle,
            onChanged: (value) => this.updateSaldo(),
            decoration: InputDecoration(
              labelText: "Saldo",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ))
        ],
      )],)
      )
    );
  }

  void select (String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (ctaBanca.id == null) {
          return;
        }
        result = await ctaBancaRepository.delete(ctaBanca);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Borrar Cuenta"),
            content: Text("La cuenta fue borrada"),
          );
          showDialog(
            context: context,
            builder: (_) => alertDialog);
          
        }
        break;
        case mnuBack:
          Navigator.pop(context, true);
          break;
      default:
    }
  }

  void save() {
    if (ctaBanca.id != null) {
      debugPrint('update');
      ctaBancaRepository.update(ctaBanca);
    }
    else {
      debugPrint('insert');
      ctaBancaRepository.insert(ctaBanca);
    }
    Navigator.pop(context, true);
  }

  void updateName(){
    ctaBanca.nombre = nombreController.text;
  }

  void updateLastname() {
    ctaBanca.apellido = apellidoController.text;
  }

  void updateNroCta() {
    ctaBanca.nrocta = nroctaController.text;
  }

  void updateSaldo() {
    ctaBanca.saldo =  double.parse(saldoController.text);
  }
}
