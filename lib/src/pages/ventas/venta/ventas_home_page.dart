import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moovle/src/pages/ventas/envios/envios_page.dart';
import 'package:moovle/src/pages/ventas/venta/coordinar_entregas_page.dart';
import 'package:moovle/src/pages/ventas/venta/nueva_venta.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

class VentasHomePage extends StatelessWidget {
  static final String route = 'ventasHomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMoovle(texto: 'Ventas', context: context),
        body: Center(
          child: _botonesMenu(context),
        ));
  }

  List<Widget> _botonesVentas(BuildContext context) {
    return [
      botonMenu(
          c: context,
          s: 'Nueva venta',
          icon: CupertinoIcons.cart_fill_badge_plus,
          color1: Colors.red[200],
          color2: Colors.red,
          expanded: true,
          onPress: onPressNuevaVenta),
      Container(),
      botonMenu(
          c: context,
          s: 'A coordinar',
          icon: CupertinoIcons.text_badge_checkmark,
          color1: Colors.green[200],
          color2: Colors.green,
          expanded: true,
          onPress: onPressACoordinar),
      Container(),
    ];
  }

  void onPressACoordinar(BuildContext c) {
    Navigator.pushNamed(c, CoordinarEntregasPage.route);
  }

  void onPressNuevaVenta(BuildContext c) {
    Navigator.pushNamed(c, NuevaVentaPage.route);
  }

  Widget _botonesMenu(BuildContext context) {
    final botonesVentas = _botonesVentas(context);
    return botones(context, botonesVentas, 0.55);
  }
}
