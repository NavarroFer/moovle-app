import 'package:moovle/src/models/opcion_item_model.dart';

class ItemPedido {
  int idProducto;
  int cantidad;
  double precio;
  double descuento;
  List<OpcionItem> opciones;

  ItemPedido(
      {this.idProducto,
      this.cantidad,
      this.precio,
      this.descuento,
      this.opciones});

  Map toJson() => {
        'idProducto': idProducto.toString(),
        'cantidad': cantidad.toString() ?? '0',
        'precio': precio.toString() ?? '0.0',
        'descuento': descuento.toString() ?? '0.0',
        'opciones': opciones.map((e) => e.toJson()).toList(),
      };

  ItemPedido.fromJsonMap(Map<String, dynamic> json) {
    this.idProducto = json['idProducto'];
    this.cantidad = json['cantidad'];
    this.precio = json['precio'];
    this.descuento = json['descuento'];
    // this.opciones = Opciones;
  }
}
