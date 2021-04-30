import 'package:flutter/material.dart';
import 'package:moovle/src/pages/home_page.dart';
import 'package:moovle/src/pages/productos/productos_home_page.dart';
import 'package:moovle/src/pages/ventas/add_product_page.dart';
import 'package:moovle/src/pages/ventas/envios_page.dart';
import 'package:moovle/src/pages/ventas/nueva_venta.dart';
import 'package:moovle/src/pages/ventas/ventas_home_page.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      title: 'Moovle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.indigo,
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomePage.route: (context) => HomePage(),
        VentasHomePage.route: (context) => VentasHomePage(),
        ProductosHomePage.route: (context) => ProductosHomePage(),
        AddProductPage.route: (context) => AddProductPage(),
        EnviosPage.route: (context) => EnviosPage(),
        NuevaVentaPage.route: (context) => NuevaVentaPage(),
      },
      home: HomePage(),
    );
  }
}
