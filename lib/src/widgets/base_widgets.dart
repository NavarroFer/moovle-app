import 'package:flutter/material.dart';

// Este boton se puede utilizar para cualquier situacion  //
//                                                        //
Widget appBarMoovle(
    {String texto = 'Moovle',
    Color color = Colors.yellow,
    List acciones,
    BuildContext context}) {
  final size = MediaQuery.of(context).size;
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    title: Text(texto,
        style: TextStyle(color: Colors.black, fontSize: size.width * 0.08)),
    backgroundColor: color,
    actions: acciones,
  );
}

Widget botonPush(
    {String text,
    String route,
    BuildContext context,
    MaterialColor color = Colors.orange}) {
  final size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color,
            padding: EdgeInsets.symmetric(
                horizontal: 0, vertical: size.height * 0.05),
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        onPressed: () => Navigator.pushNamed(context, route),
        child: Container(
          child: Center(
            child: Text(
              text,
            ),
          ),
        )),
  );
}
