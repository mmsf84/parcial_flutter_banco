class OpeBanca {
  int _id;
  int _nrocta;
  int _tipo;
  double _monto;
  
  OpeBanca(this._nrocta, this._tipo, this._monto);
  OpeBanca.withId(this._id, this._nrocta, this._tipo, this._monto);

  int get id => _id;
  int get nrocta => _nrocta;
  int get tipo => _tipo;
  double get monto => _monto;

  set nrocta (int nrocta) {
      _nrocta = nrocta;
  }

  set tipo (int tipo) {
      _tipo = tipo;
  }

  set monto (double monto) {    
      _monto = monto;
  }
}
