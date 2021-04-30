import 'package:flutter/material.dart';

// Este boton se puede utilizar para cualquier situacion  //
//                                                        //
Widget appBarMoovle(
    {String texto = 'Moovle',
    Color color = Colors.yellow,
    List<Widget> acciones,
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

Widget botonOpciones(BuildContext context,
    {String title,
    Icon icon,
    var color,
    double factor_alto = 0.07,
    double factor_ancho = 0.35,
    void onPressed()}) {
  final size = MediaQuery.of(context).size;
  return Container(
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(title),
      style: ElevatedButton.styleFrom(primary: color, elevation: 7),
    ),
    height: size.height * factor_alto,
    width: size.width * factor_ancho,
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

Widget cardField(String tituloCard, Widget switchHabilitado,
    List<Widget> listaFields, BuildContext context) {
  final styleTituloCard = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final titulo = Padding(
    padding: EdgeInsets.only(left: 20, top: 20),
    child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              tituloCard,
              style: styleTituloCard,
            ),
            Expanded(
              child: SizedBox(),
            ),
            switchHabilitado != null ? switchHabilitado : Container(),
          ],
        )),
  );

  final size = MediaQuery.of(context).size;
  return Card(
    color: Colors.white60,
    margin: EdgeInsets.all(20),
    child: Column(
      children: [
        titulo,
        SizedBox(
          height: size.height * 0.01,
        ),
        Column(
          children: listaFields,
        ),
      ],
    ),
  );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
