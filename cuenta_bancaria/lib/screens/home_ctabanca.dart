import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cuenta_bancaria/app_constants.dart';
import 'package:cuenta_bancaria/screens/ctabanca_list.dart';

class HomeCtaBanca extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeCtaBancaState();
}

class HomeCtaBancaState extends State<HomeCtaBanca> {
  var _currentIndex = 0;
  Widget content = CtaBancaList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text(
            AppConstants.appBarTitle,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          )
        ),
      ),
      body: content,
      bottomNavigationBar: _indexBottom(),
    );
  }

  Widget _indexBottom() => BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.moneyBill),
            title: Text('Cuentas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.handshake),
            title: Text('Operaciones'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userCheck),
            title: Text('Resumen'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (_currentIndex) {
              case 0:
                content = CtaBancaList();
                break;
              case 1:
                content = Container(
                  alignment: Alignment.center,
                  child: Text("Operaciones"),
                );
                break;
              case 2:
                content = Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text("Número total de cuentas bancarias = "),
                    Text("Número total de depósitos de todas las cuentas bancarias = "),
                    Text("Monto total de depósitos de todas las cuentas bancarias = "),
                    Text("Número total de retiros de todas las cuentas bancarias = "),
                    Text("Monto total de retiros de todas las cuentas bancarias = "),
                    Text("Saldo general de todas las cuentas bancarias = "),
                  ];
                //content = Container(
                  //alignment: Alignment.centerLeft,
                  //child: Text("Metricas:"),
                  
                //);
                break;
            }
          });
        },
      );
}
