import 'package:flutter/material.dart';
import 'package:cuenta_bancaria/infrastructure/ctabanca_sqflite_repository.dart';
import 'package:cuenta_bancaria/infrastructure/database_provider.dart';
import 'package:cuenta_bancaria/model/ctabanca.dart';
import 'package:cuenta_bancaria/screens/ctabanca_detail.dart';
import 'package:cuenta_bancaria/app_constants.dart';

class CtaBancaList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CtaBancaListState();
}

class CtaBancaListState extends State<CtaBancaList> {
  CtaBancaSqfliteRepository ctaBancaRepository = CtaBancaSqfliteRepository(DatabaseProvider.get);
  List<CtaBanca> cuentas;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (cuentas == null) {
      cuentas = List<CtaBanca>();
      getData();
    }
    return Scaffold(
      body: ctaBancaListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          navigateToDetail(CtaBanca('', '', '', 0));
        }
        ,
        tooltip: "Agregar nueva cuenta",
        child: new Icon(Icons.add),
      ),
    );
  }
  
  ListView ctaBancaListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.cuentas[position].saldo),
              child:Text("S/"),
            ),
          title: Text(this.cuentas[position].nrocta),
          subtitle: Text(this.cuentas[position].nombre+" "+this.cuentas[position].apellido),
          onTap: () {
            debugPrint("Tapped on " + this.cuentas[position].id.toString());
            navigateToDetail(this.cuentas[position]);
          },
          ),
        );
      },
    );
  }
  
  void getData() {    
      final ctaFuture = ctaBancaRepository.getList();
      ctaFuture.then((cuentaList) {
        setState(() {
          cuentas = cuentaList;
          count = cuentaList.length;
        });
        debugPrint("Items " + count.toString());
      });
  }

  Color getColor(double saldo) {
    if(saldo < 100) {
      return Colors.red;
    }else if (saldo >= 101 && saldo < 5000){
      return Colors.orange;
    }else{
      return Colors.green;
    }
  }

  void navigateToDetail(CtaBanca ctaBanca) async {
    bool result = await Navigator.push(context, 
        MaterialPageRoute(builder: (context) => CtaBancaDetail(ctaBanca)),
    );
    if (result == true) {
      getData();
    }
  }
}
