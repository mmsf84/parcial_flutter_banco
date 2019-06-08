class CtaBanca {
  int _id;
  String _nombre;
  String _apellido;
  String _nrocta;
  double _saldo;
  
  CtaBanca(this._nombre, this._apellido, this._nrocta, this._saldo);
  CtaBanca.withId(this._id, this._nombre, this._apellido, this._nrocta, this._saldo);

  int get id => _id;
  String get nombre => _nombre;
  String get apellido => _apellido;
  String get nrocta => _nrocta;
  double get saldo => _saldo;

  set nombre (String nombre) {    
      _nombre = nombre;
  }

  set apellido (String apellido) {
      _apellido = apellido;
  }

  set nrocta (String nrocta) {
      _nrocta = nrocta;
  }

  set saldo (double saldo) {    
      _saldo = saldo;
  }
}
