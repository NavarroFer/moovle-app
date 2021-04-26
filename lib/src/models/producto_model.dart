class Producto {
  int id;
  double precio;
  String nombre;
  int categoria;
  int tipo;

  Producto({this.id, this.precio, this.nombre, this.categoria, this.tipo});

  @override
  String toString() {
    return '${nombre} ${id}';
  }
}
