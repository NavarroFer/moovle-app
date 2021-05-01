class OpcionItem {
  bool reespaldoEstirado;
  int reespaldoDivisiones;
  bool almohadonesEstirados;
  int almohadonesDivisiones;
  int idTela;
  int idColorTela;
  int idPatas;

  OpcionItem(
      {this.reespaldoEstirado = false,
      this.reespaldoDivisiones = 0,
      this.almohadonesEstirados = false,
      this.almohadonesDivisiones = 0,
      this.idColorTela,
      this.idTela,
      this.idPatas});

  Map toJson() => {
        'reespaldoEstirado': reespaldoEstirado.toString(),
        'reespaldoDivisiones': reespaldoDivisiones.toString() ?? '0',
        'almohadonesEstirados': almohadonesEstirados.toString(),
        'almohadonesDivisiones': almohadonesDivisiones.toString() ?? '0',
        'idTela': idTela.toString(),
        'idColorTela': idColorTela.toString(),
        'idPatas': idPatas.toString()
      };
}
