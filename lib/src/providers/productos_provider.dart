import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moovle/src/models/producto_model.dart';

class ProductosProvider {
  String _url = '';

  Future<List<Producto>> getProductos() async {
    var path = '/moovle/productos';

    final url = Uri.http(_url, path);

    try {
      final resp = await http.get(url).timeout(Duration(seconds: 30));
      final decodedData = jsonDecode(resp.body);
      print(decodedData);
      new Productos.fromJsonList(decodedData['PRODUCTOS']);
      return Productos.items;
    } on TimeoutException {
      return null;
    } on Exception {
      return null;
    }
  }
}
