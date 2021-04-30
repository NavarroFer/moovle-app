import 'package:flutter/material.dart';
import 'package:moovle/src/pages/ventas/add_product_page.dart';
import 'package:moovle/src/pages/ventas/envios_page.dart';
import 'package:moovle/src/pages/ventas/nueva_venta.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

class VentasHomePage extends StatelessWidget {
  static final String route = 'ventasHomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMoovle(texto: 'Ventas', context: context),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _botonesVentas(context),
        )));
  }

  List<Widget> _botonesVentas(BuildContext context) {
    return [
      botonPush(
          text: "Nueva venta", route: NuevaVentaPage.route, context: context),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
      botonPush(text: "Envios", route: EnviosPage.route, context: context),
    ];
  }
}
