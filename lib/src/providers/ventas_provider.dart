import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moovle/src/models/item_pedido_model.dart';
import 'package:moovle/src/models/pedido_model.dart';

class VentasProvider {
  String _url = 'localhost:5000';
  String path = 'moovle/pedidos/envia';

  Future<bool> enviarPedido(Pedido pedido) async {
    try {
      final url = Uri.http(_url, path);

      final body = pedido.toJson();
      final resp = await http
          .post(url,
              headers: {"Content-Type": "application/json"},
              body: json.encode(body))
          .timeout(Duration(seconds: 5));
      // ignore: unused_local_variable
      final decodeData = json.decode(resp.body);
      print(decodeData);
      return true;
    } on TimeoutException catch (e) {
      print(e.message);
      return false;
    } on Exception {
      return false;
    }
  }

  Future<List<Pedido>> getPedidos() async {
    var path = '/moovle/pedidos';

    final url = Uri.http(_url, path);

    try {
      final resp = await http.get(url).timeout(Duration(seconds: 30));
      final decodedData = jsonDecode(resp.body);
      print(decodedData);
      new Pedidos.fromJsonList(decodedData['PEDIDOS']);
      return Pedidos.items;
    } on TimeoutException {
      return null;
    } on Exception {
      return null;
    }
  }

  Future<List<Pedido>> getPedidosAEnviar() async {
    var path = '/moovle/pedidosAEnviar';

    final url = Uri.http(_url, path);

    try {
      final resp = await http.get(url).timeout(Duration(seconds: 30));
      final decodedData = jsonDecode(resp.body);
      print(decodedData);
      new Pedidos.fromJsonList(decodedData['PEDIDOS']);

      return Pedidos.items;
    } on TimeoutException {
      List<Pedido> result = [
        Pedido(
            apellidoCliente: 'Navarro',
            nombreCliente: 'Fernando',
            direccion: 'Gascon 2525 6a',
            total: 20000,
            totalPagado: 10000,
            senia: 10000,
            itemsPedido: [
              ItemPedido(
                  cantidad: 1, descuento: 0, idProducto: 1, precio: 20000)
            ]),
        // Pedido(),
        // Pedido(),
      ];

      return result;
      return null;
    } on Exception {
      List<Pedido> result = [
        Pedido(
            apellidoCliente: 'Navarro',
            nombreCliente: 'Fernando',
            direccion: 'Gascon 2525 6a',
            total: 20000,
            totalPagado: 10000,
            senia: 10000,
            itemsPedido: [
              ItemPedido(
                  cantidad: 1, descuento: 0, idProducto: 1, precio: 20000)
            ]),
      ];

      return result;
      return null;
    }
  }
}
