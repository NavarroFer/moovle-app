import 'package:flutter/material.dart';
import 'package:moovle/src/models/producto_model.dart';
import 'package:moovle/src/pages/ventas/add_product_page.dart';
import 'package:moovle/src/widgets/base_widgets.dart';

class NuevaVentaPage extends StatefulWidget {
  static final String route = 'nuevaVenta';
  @override
  _NuevaVentaPageState createState() => _NuevaVentaPageState();
}

class _NuevaVentaPageState extends State<NuevaVentaPage> {
  List<Producto> productos = List.empty(growable: true);
  List cantidad = List.filled(0, 0, growable: true);
  int cantidadActual;
  double totalPedido = 0;
  List result;

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarMoovle(
          texto: 'Nueva venta',
          context: context,
          acciones: _grabaPedido(context)),
      body: Column(
        children: [
          _cardDatosCliente(context),
          _listaProductos(context),
          Expanded(
            child: SizedBox(),
          ),
          _bottom(context),
        ],
      ),
    );
  }

  Widget _cardDatosCliente(BuildContext c) {
    final size = MediaQuery.of(c).size;
    return cardField(
        'Venta',
        null,
        [
          _nombreCliente(_nombreController, 'Nombre'),
          SizedBox(
            height: size.height * 0.01,
          ),
          _apellidoCliente(_apellidoController, 'Apellido'),
          SizedBox(
            height: size.height * 0.01,
          ),
          _direccionCliente(_direccionController, 'Direccion'),
          SizedBox(
            height: size.height * 0.01,
          ),
        ],
        context);
  }

  Widget _listaProductos(BuildContext c) {
    final size = MediaQuery.of(c).size;
    return Container(
      height: size.height * 0.34,
      child: ListView.builder(
        itemCount: productos.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: ListTile(
              title:
                  Text(productos[index].nombre, style: TextStyle(fontSize: 20)),
              trailing: Text(
                "x ${cantidad[index]?.toString()}",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.panorama_wide_angle_sharp,
                color: Colors.grey[400],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bottom(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[200],
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.04,
          ),
          _totalPedido(context),
          Expanded(
            child: SizedBox(),
          ),
          _botonAddProduct(context),
          SizedBox(
            width: size.width * 0.08,
          ),
        ],
      ),
    );
  }

  Widget _totalPedido(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: Text(
        '\$ ${(totalPedido ?? 0).toStringAsFixed(2)}',
        style: TextStyle(fontSize: size.height * 0.05),
      ),
    );
  }

  Widget _botonAddProduct(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return botonOpciones(context,
        title: '',
        color: Colors.green,
        // factor_alto: 0.07,
        factor_ancho: 0.30,
        icon: Icon(
          Icons.add_box_outlined,
          size: size.height * 0.07,
        ), onPressed: () {
      _pushAddProdGetInfo(context);
    });
  }

  void _pushAddProdGetInfo(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => AddProductPage()),
    );

    if (result != null) {
      Producto producto = result[0];
      productos.add(producto);
      cantidadActual = result[1];
      cantidad.add(cantidadActual);
      totalPedido += producto.precio * cantidadActual;
      setState(() {});
    }
  }

  Widget _textEdit(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  _nombreCliente(nombreController, String s) {
    return _textEdit(nombreController, s);
  }

  _apellidoCliente(apellidoController, String s) {
    return _textEdit(apellidoController, s);
  }

  _direccionCliente(direccionController, String s) {
    return _textEdit(direccionController, s);
  }

  List<Widget> _grabaPedido(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return [
      Container(
          height: 10,
          width: size.width * 0.2,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.yellow[700]),
              onPressed: () {
                onPressGrabaPedido(context);
              },
              child: Icon(Icons.send_outlined)))
    ];
  }

  void onPressGrabaPedido(BuildContext context) {
    _enviaPedido().then((value) {
      if (value == true) {
        mostrarSnackbar('Pedido enviado correctamente', context);
        Navigator.pop(context);
      } else {
        mostrarSnackbar('No se ha podido enviar el pedido', context);
        Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      mostrarSnackbar('No se ha podido enviar el pedido', context);
      Navigator.pop(context);
    });
  }

  Future<bool> _enviaPedido() async {
    bool resultado = false;
    await Future.delayed(Duration(milliseconds: 2000))
        .then((value) => resultado = true);
    return resultado;
  }
}
