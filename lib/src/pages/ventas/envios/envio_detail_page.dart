import 'package:flutter/material.dart';
import 'package:moovle/src/models/pedido_model.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

class EnvioDetailPage extends StatelessWidget {
  static final String route = 'envioDetailPage';
  Pedido pedido;

  @override
  Widget build(BuildContext context) {
    pedido = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appBarMoovle(context: context, texto: pedido.direccion),
      body: Container(),
    );
  }
}
