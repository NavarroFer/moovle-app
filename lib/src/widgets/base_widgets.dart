import 'package:auto_size_text/auto_size_text.dart';
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
    double factorAlto = 0.07,
    double factorAncho = 0.35,
    void onPressed()}) {
  final size = MediaQuery.of(context).size;
  return Container(
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(title),
      style: ElevatedButton.styleFrom(primary: color, elevation: 7),
    ),
    height: size.height * factorAlto,
    width: size.width * factorAncho,
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

void mostrarSnackbar(String mensaje, BuildContext c) {
  final snackbar = SnackBar(
    content: Text(mensaje),
    duration: Duration(milliseconds: 1500),
  );

  ScaffoldMessenger.of(c).showSnackBar(snackbar);
}

Widget botones(BuildContext c, List<Widget> lista) {
  return Container(
      height: MediaQuery.of(c).size.height * 0.55,
      padding:
          EdgeInsets.symmetric(horizontal: MediaQuery.of(c).size.width * 0.03),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: lista.length,
        itemBuilder: (context, index) {
          if (index % 2 == 1) {
            if (!(lista[index] is Container) &&
                !(lista[index - 1] is Container)) {
              return Row(children: [lista[index - 1], lista[index]]);
            } else {
              if (!(lista[index] is Container))
                return Row(children: [lista[index]]);
              else
                return Row(children: [lista[index - 1]]);
            }
          } else if (index == lista.length - 1) {
            if (!(lista[index] is Container))
              return Row(children: [lista[index]]);
          }
          return Container();
        },
      ));
}

Widget botonMenu(
    {BuildContext c,
    String s,
    IconData icon,
    var color1,
    var color2,
    void Function(BuildContext c) onPress,
    bool expanded}) {
  final size = MediaQuery.of(c).size;
  return GestureDetector(
    onTap: () => onPress(c),
    child: Column(
      children: [
        Card(
          child: Container(
            child: Stack(
              children: [
                _iconBoton(c, icon, expanded),
                _textBoton(c, s, expanded)
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                color1,
                color2,
              ],
            )),
            height: size.height * 0.2,
            width: expanded ? size.width * 0.9 : size.width * 0.45,
          ),
        ),
        expanded
            ? SizedBox(
                height: 50,
              )
            : Container()
      ],
    ),
  );
}

Widget _textBoton(BuildContext c, String s, bool expanded) {
  final size = MediaQuery.of(c).size;
  return Container(
    child: Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        top: size.height * 0.03,
      ),
      child: AutoSizeText(
        s,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        textScaleFactor: expanded ? size.width * 0.005 : size.width * 0.004,
        maxLines: 2,
        textAlign: TextAlign.start,
        overflow: TextOverflow.fade,
      ),
    ),
  );
}

Widget _iconBoton(BuildContext c, IconData icon, bool expanded) {
  var size = MediaQuery.of(c).size;
  return Padding(
    padding: EdgeInsets.only(
        top: expanded ? size.height * 0.01 : size.height * 0.085,
        left: expanded ? size.width * 0.5 : size.width * 0.25),
    child: Icon(
      icon,
      color: Color.fromRGBO(255, 255, 255, 0.6),
      size: expanded ? size.width * 0.3 : size.width * 0.2,
    ),
  );
}
