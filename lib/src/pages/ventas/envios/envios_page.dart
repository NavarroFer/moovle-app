import 'package:flutter/material.dart';
import 'package:moovle/src/models/pedido_model.dart';
import 'package:moovle/src/pages/ventas/envios/envio_detail_page.dart';
import 'package:moovle/src/providers/ventas_provider.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

class EnviosPage extends StatefulWidget {
  static final String route = 'enviosPage';
  @override
  _EnviosPageState createState() => _EnviosPageState();
}

class _EnviosPageState extends State<EnviosPage> {
  static final String route = 'enviosPage';
  List<Pedido> envios = List<Pedido>.filled(0, null, growable: true);
  @override
  Widget build(BuildContext context) {
    envios = Pedidos.items;

    return Scaffold(
      appBar: appBarMoovle(texto: 'Envios', context: context),
      body: _listaEnvios(context),
    );
  }

  Widget _listaEnvios(BuildContext context) {
    return FutureBuilder(
      future: VentasProvider().getPedidosAEnviar(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            final listaEnvios = snapshot.data;
            return ListView.builder(
              itemCount: listaEnvios.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(1),
                  child: ListTile(
                    title: Text(listaEnvios[index].direccion),
                    leading: Icon(
                      Icons.accessible_forward_sharp,
                      color: Colors.black,
                    ),
                    onTap: () => Navigator.pushNamed(
                        context, EnvioDetailPage.route,
                        arguments: listaEnvios[index]),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  void onPedidoPress(BuildContext context) {}
}
