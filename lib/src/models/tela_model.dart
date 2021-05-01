class Tela {
  int id;
  String nombre;
  int tipo;

  Tela({this.id, this.nombre, this.tipo});

  @override
  String toString() {
    return '$nombre $id';
  }
}
