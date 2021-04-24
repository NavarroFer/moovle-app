import 'package:flutter/material.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

class EnviosPage extends StatelessWidget {
  static final String route = 'enviosPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMoovle(texto: 'Envios', context: context),
      body: Container(),
    );
  }
}
