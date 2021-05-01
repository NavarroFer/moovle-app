import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moovle/src/models/pedido_model.dart';
import 'package:moovle/src/models/producto_model.dart';

class VentasProvider {
  String _url = '';
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
}
