import 'package:moovle/src/providers/productos_provider.dart';

class Productos {
  static List<Producto> items = List<Producto>.filled(0, null, growable: true);

  Productos() {
    if (items != null) {
      if (items.isEmpty) {
        _getProductos().then((value) {
          items = value;
        });
      }
    } else {
      items = [];
      _getProductos().then((value) {
        items = value;
      });
    }
  }

  Productos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((jsonItem) {
      final producto = new Producto.fromJsonMap(jsonItem);
      items?.add(producto);
    });
  }

  Future<List<Producto>> _getProductos() async {
    final resp = await ProductosProvider().getProductos();
    return resp;
  }
}

class Producto {
  int id;
  double precio;
  String nombre;
  int categoria;
  int tipo;

  Producto({this.id, this.precio, this.nombre, this.categoria, this.tipo});

  Producto.fromJsonMap(Map<String, dynamic> json) {
    this.id = json['LEGAJONRO'];
    this.precio = json['PRECIO'];
    this.nombre = json['NOMBRE'].toString();
    this.categoria = json['CATEGORIA'];
    this.tipo = json['TIPO'];
  }

  @override
  String toString() {
    return '$nombre $id';
  }
}
