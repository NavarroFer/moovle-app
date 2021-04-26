import 'package:flutter/material.dart';
import 'package:moovle/src/pages/home_page.dart';
import 'package:moovle/src/pages/productos/productos_home_page.dart';
import 'package:moovle/src/pages/ventas/envios_page.dart';
import 'package:moovle/src/pages/ventas/nueva_venta_page.dart';
import 'package:moovle/src/pages/ventas/ventas_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        NuevaVentaPage.route: (context) => NuevaVentaPage(),
        EnviosPage.route: (context) => EnviosPage(),
      },
      home: HomePage(),
    );
  }
}
