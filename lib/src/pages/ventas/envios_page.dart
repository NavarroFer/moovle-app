import 'package:flutter/material.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

class EnviosPage extends StatelessWidget {
  static final String route = 'enviosPage';
  final envios = [
    'Gascon 1234',
    'Colon 1245 6a',
    'Rivadavia 2912',
    'Buenos Aires 2139 1c',
    'Moreno y Rivadavia',
    'Jujuy 4031',
    'Edison 2312'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMoovle(texto: 'Envios', context: context),
      body: _listaEnvios(),
    );
  }

  Widget _listaEnvios() {
    return ListView.builder(
      itemCount: envios.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(1),
          child: ListTile(
            title: Text(envios[index]),
            leading: Icon(
              Icons.accessible_forward_sharp,
              color: Colors.black,
            ),
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),
        );
      },
    );
  }
}
