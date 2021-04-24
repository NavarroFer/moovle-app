import 'package:flutter/material.dart';
import 'package:moovle/src/pages/productos/productos_home_page.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

import 'ventas/ventas_home_page.dart';

class HomePage extends StatelessWidget {
  static final String route = 'homePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMoovle(context: context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _botonesHome(context),
        ),
      ),
    );
  }

  List<Widget> _botonesHome(BuildContext context) {
    return [
      botonPush(text: "Ventas", route: VentasHomePage.route, context: context),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
      botonPush(
          text: "Productos", route: ProductosHomePage.route, context: context),
    ];
  }
}
