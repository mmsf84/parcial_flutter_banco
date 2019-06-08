import 'package:flutter/material.dart';
import 'package:cuenta_bancaria/infrastructure/ctabanca_sqflite_repository.dart';
import 'package:cuenta_bancaria/infrastructure/database_provider.dart';
import 'package:cuenta_bancaria/model/ctabanca.dart';

CtaBancaSqfliteRepository ctaBancaRepository = CtaBancaSqfliteRepository(DatabaseProvider.get);
final List<String> choices = const <String> [
  'Guardar Cuenta & Volver',
  'Borrar Cuenta',
  'Volver a la lista'
];

const mnuSave = 'Guardar Cuenta & Volver';
const mnuDelete = 'Borrar Cuenta';
const mnuBack = 'Volver a la lista';

class CtaBancaDetail extends StatefulWidget {
  final CtaBanca ctaBanca;
  CtaBancaDetail(this.ctaBanca);

  @override
  State<StatefulWidget> createState() => CtaBancaDetailState(ctaBanca);
}

class CtaBancaDetailState extends State<CtaBancaDetail> {
  CtaBanca ctaBanca;
  CtaBancaDetailState(this.ctaBanca);
  
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController nroctaController = TextEditingController();
  TextEditingController saldoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nombreController.text = ctaBanca.nombre;
    apellidoController.text = ctaBanca.apellido;
    nroctaController.text = ctaBanca.nrocta;
    saldoController.text = ctaBanca.saldo.toString();

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(ctaBanca.nombre+" "+ctaBanca.apellido),
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
            controller: nombreController,
            style: textStyle,
            onChanged: (value) => this.updateName(),
            decoration: InputDecoration(
              labelText: "Nombre",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:15.0, bottom: 15.0),
            child: TextField(
            controller: apellidoController,
            style: textStyle,
            onChanged: (value) => this.updateLastname(),
            decoration: InputDecoration(
              labelText: "Apellidos",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          )),
          Padding(
            padding: EdgeInsets.only(top:15.0, bottom: 15.0),
            child: TextField(
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
