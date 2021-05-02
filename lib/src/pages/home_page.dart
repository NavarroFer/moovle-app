import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovle/src/pages/productos/productos_home_page.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

import 'ventas/venta/ventas_home_page.dart';

class HomePage extends StatelessWidget {
  static final String route = 'homePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMoovle(context: context),
      body: Center(
        child: _botonesMenu(context),
      ),
    );
  }

  List<Widget> _botonesHome(BuildContext context) {
    return [
      botonMenu(
          c: context,
          s: 'Ventas',
          icon: Icons.attach_money_sharp,
          color1: Colors.orange[200],
          color2: Colors.orange,
          expanded: true,
          onPress: onPressVentas),
      Container(),
      botonMenu(
          c: context,
          s: 'Productos',
          icon: CupertinoIcons.list_bullet_below_rectangle,
          color1: Colors.green[200],
          color2: Colors.green,
          expanded: true,
          onPress: onPressProductos),
      Container(),
    ];
  }

  void onPressVentas(BuildContext c) {
    Navigator.pushNamed(c, VentasHomePage.route);
  }

  void onPressProductos(BuildContext c) {
    Navigator.pushNamed(c, ProductosHomePage.route);
  }

  Widget _botonesMenu(BuildContext context) {
    final botonesVentas = _botonesHome(context);
    return botones(context, botonesVentas);
  }
}
