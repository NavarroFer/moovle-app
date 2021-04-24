import 'package:flutter/material.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

class ProductosHomePage extends StatelessWidget {
  static final String route = 'productosHomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMoovle(texto: 'Productos', context: context),
      body: Container(),
    );
  }
}
