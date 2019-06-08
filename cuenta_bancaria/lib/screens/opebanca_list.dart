import 'package:flutter/material.dart';
import 'package:cuenta_bancaria/infrastructure/opebanca_sqflite_repository.dart';
import 'package:cuenta_bancaria/infrastructure/database_provider.dart';
import 'package:cuenta_bancaria/model/opebanca.dart';
import 'package:cuenta_bancaria/screens/opebanca_insert.dart';
import 'package:cuenta_bancaria/app_constants.dart';

class OpeBancaList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OpeBancaListState();
}

class OpeBancaListState extends State<OpeBancaList> {
  OpeBancaSqfliteRepository opeBancaRepository = OpeBancaSqfliteRepository(DatabaseProvider.get);
  List<OpeBanca> operaciones;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (operaciones == null) {
      operaciones = List<OpeBanca>();
      getData();
    }
    return Scaffold(
      body: opeBancaListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          navigateToInsert(OpeBanca(0, 0, 0));
        }
        ,
        tooltip: "Agregar nueva operación",
        child: new Icon(Icons.arrow_forward),
      ),
    );
  }
  
  ListView opeBancaListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.operaciones[position].monto),
              child:getTipo(this.operaciones[position].tipo, true),
            ),
          title: Text(this.operaciones[position].nrocta.toString()),
          subtitle: Text(getTipo(this.operaciones[position].tipo, false).toString()+" "+this.operaciones[position].monto.toString())
          ),
        );
      },
    );
  }
  
  void getData() {    
      final ctaFuture = opeBancaRepository.getList();
      ctaFuture.then((opeList) {
        setState(() {
          operaciones = opeList;
          count = opeList.length;
        });
        debugPrint("Items " + count.toString());
      });
  }

  Color getColor(double monto) {
    if(monto < 100) {
      return Colors.red;
    }else if (monto >= 101 && monto < 5000){
      return Colors.orange;
    }else{
      return Colors.green;
    }
  }

  Text getTipo(int tipo, bool bformat) {
    String tipoDesc = "NNN";
    if(tipo == 1) {
      tipoDesc =AppConstants.deposito;
    }else if (tipo == 2){
      tipoDesc =AppConstants.retiro;      
    }
    if(bformat){
      return Text(tipoDesc.toString().substring(0,1));
    }else{
      return Text(tipoDesc.toString());
    }
  }

  void navigateToInsert(OpeBanca opeBanca) async {
    bool result = await Navigator.push(context, 
        MaterialPageRoute(builder: (context) => OpeBancaInsert(opeBanca)),
    );
    if (result == true) {
      getData();
    }
  }
}
