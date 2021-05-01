class ColorTela {
  int id;
  String nombre;
  var color;
  int tipo;

  ColorTela({this.id, this.nombre, this.color, this.tipo});

  @override
  String toString() {
    return '$nombre $id';
  }
}
