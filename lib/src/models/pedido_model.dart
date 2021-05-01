import 'package:moovle/src/models/item_pedido_model.dart';
import 'package:moovle/src/providers/ventas_provider.dart';

class Pedidos {
  static List<Pedido> items = List<Pedido>.filled(0, null, growable: true);

  Pedidos() {
    if (items != null) {
      if (items.isEmpty) {
        _getPedidos().then((value) {
          items = value;
        });
      }
    } else {
      items = [];
      _getPedidos().then((value) {
        items = value;
      });
    }
  }

  Pedidos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((jsonItem) {
      final producto = new Pedido.fromJsonMap(jsonItem);
      items?.add(producto);
    });
  }

  Future<List<Pedido>> _getPedidos() async {
    final resp = await VentasProvider().getPedidos();
    return resp;
  }
}

class Pedido {
  List<ItemPedido> itemsPedido;
  String nombreCliente;
  String apellidoCliente;
  String direccion;
  double total;
  double totalPagado;
  double senia;

  Pedido(
      {this.itemsPedido,
      this.nombreCliente,
      this.apellidoCliente,
      this.direccion,
      this.total,
      this.totalPagado,
      this.senia});

  Pedido.fromJsonMap(Map<String, dynamic> json) {
    // this.itemsPedido = ItemPedido.;
    this.nombreCliente = json['nombreCliente'];
    this.apellidoCliente = json['apellidoCliente'];
    this.direccion = json['direccion'];
    this.total = json['total'];
    this.totalPagado = json['totalPagado'];
    this.senia = json['senia'];
  }

  Map toJson() => {
        'nombreCliente': nombreCliente,
        'apellidoCliente': apellidoCliente,
        'direccion': direccion,
        'total': total.toString() ?? '0',
        'totalPagado': totalPagado.toString() ?? '0',
        'senia': senia.toString() ?? '0',
        'items': itemsPedido.map((e) => e.toJson()).toList(),
      };
}
