// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovle/src/models/patas_model.dart';
import 'package:moovle/src/models/producto_model.dart';
import 'package:moovle/src/widgets/base_widgets.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class NuevaVentaPage extends StatefulWidget {
  static final String route = 'nuevaVenta';

  @override
  _NuevaVentaPageState createState() => _NuevaVentaPageState();
}

class _NuevaVentaPageState extends State<NuevaVentaPage> {
  // final _formKey = GlobalKey<FormState>();
  // final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();
  final List<DropdownMenuItem<Producto>> productos = [];
  final List<DropdownMenuItem> patas = [];
  int selectedValueProducto;
  int selectedValuePatas;
  TextStyle styleLabels = TextStyle(fontSize: 15);
  TextStyle styleTituloCard =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  List<Widget> opcionesSillon;
  final _cantDivisionesReespladoController = TextEditingController();
  final _cantDivisionesAlmohadonesController = TextEditingController();
  final _comentarioController = TextEditingController();
  final _cantSillasController = TextEditingController(text: '0');
  bool esEstiradoReespaldo = false;
  bool esEstiradoAlmohadones = false;
  bool cambiarPatas = false;
  bool botonesBottom;
  bool _clearTextEdit = false;
  int categoria;
  int tipo;
  double _sizePatas = 0;
  var currentFocus;
  @override
  void initState() {
    productos.add(DropdownMenuItem(
      child: Text('Sillon 1.6'),
      value:
          Producto(id: 1, nombre: 'Sillon 1.6m', precio: 45000, categoria: 1),
    ));
    productos.add(DropdownMenuItem(
      child: Text('Sillon 1.8'),
      value:
          Producto(id: 2, nombre: 'Sillon 1.8m', precio: 53000, categoria: 1),
    ));

    productos.add(DropdownMenuItem(
      child: Text('Silla'),
      value: Producto(id: 3, nombre: 'Silla', precio: 5600, categoria: 2),
    ));

    productos.add(DropdownMenuItem(
      child: Text('Mesa 1.6'),
      value: Producto(
          id: 4, nombre: 'Mesa 1.6m', precio: 55000, categoria: 3, tipo: 1),
    ));
    productos.add(DropdownMenuItem(
      child: Text('Mesa 1.8'),
      value: Producto(
          id: 5, nombre: 'Mesa 1.8m', precio: 63000, categoria: 3, tipo: 1),
    ));
    productos.add(DropdownMenuItem(
      child: Text('Puff'),
      value: Producto(id: 6, nombre: 'Puff', precio: 8000, categoria: 3),
    ));

    patas.add(DropdownMenuItem(
      child: Text('Wengue'),
      value: Patas(id: 1, nombre: 'Wengue'),
    ));

    patas.add(DropdownMenuItem(
      child: Text('Paraiso'),
      value: Patas(id: 2, nombre: 'Paraiso'),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMoovle(texto: 'Nueva venta', context: context),
      body: ListView(
          // padding: EdgeInsets.all(4),
          children: <Widget>[
            _buscadorProducto(productos),
            _opcionesSegunCategoria(context),
            _botones(context),
            SizedBox(
              height: 20,
            ),
          ]),
    );
  }

  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget _buscadorProducto(List<DropdownMenuItem<Producto>> items) {
    return SearchableDropdown.single(
      items: items,
      value: selectedValueProducto,
      hint: "Selecciona un producto",
      searchHint: "Busca un producto",
      onChanged: (value) {
        setState(() {
          _clearTextEdit = selectedValueProducto != value.id;

          if (_clearTextEdit) {
            clearControllers();
            unfocus();
          }

          selectedValueProducto = value.id;
          categoria = value.categoria;
          tipo = value.tipo;
        });
      },
      isExpanded: true,
      iconSize: 40,
      displayClearIcon: true,
    );
  }

  Widget _opcionesSegunCategoria(BuildContext context) {
    Widget opciones;
    botonesBottom = true;

    switch (categoria) {
      case 0:
        opciones = _opcionesOtro(context);
        break;
      case 1:
        opciones = _opcionesSillon(context);
        break;
      case 2:
        opciones = _opcionesSilla(context);
        break;
      case 3:
        opciones = _opcionesMesa(tipo, context);
        break;
      default:
        {
          opciones = Container();
          botonesBottom = false;
        }
    }
    return opciones;
  }

  void clearControllers() {
    this._cantDivisionesAlmohadonesController.text = '';
    this._cantDivisionesReespladoController.text = '';
    this._cantSillasController.text = '';
    this._comentarioController.text = '';
  }

  Widget _opcionesSillon(BuildContext context) {
    return Column(children: [
      _reesplado(context),
      _almohadones(context),
      _patas(context),
      _comentario(context)
    ]);
  }

  Widget _reesplado(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _cardField(
        'Reespaldo',
        null,
        [
          _cantidad(_cantDivisionesReespladoController, 'Reespaldo'),
          SizedBox(
            height: size.height * 0.01,
          ),
          _esReespaldoEstirado(context),
        ],
        context);
  }

  Widget _cardField(String tituloCard, Widget switchHabilitado,
      List<Widget> listaFields, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      color: Colors.white60,
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          _tituloCard(tituloCard, switchHabilitado),
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

  Widget _almohadones(BuildContext context) {
    return _cardField(
        'Almohadones',
        null,
        [
          _cantidad(_cantDivisionesAlmohadonesController, 'Almohadones'),
          _esAlmohadonesEstirado(context)
        ],
        context);
  }

  Widget _patas(BuildContext c) {
    final size = MediaQuery.of(c).size;
    return _cardField(
        'Patas',
        _cambiarPatasSwitch(c),
        [
          AnimatedContainer(
            height: _sizePatas,
            duration: Duration(milliseconds: 200),
            child: FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 195)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return _tiposDePatas();
                  else
                    return Container(); // Return empty container to avoid build errors
                }),
          ),
          SizedBox(
            height: size.height * 0.01,
          )
        ],
        context);
  }

  Widget _comentario(BuildContext c) {
    final size = MediaQuery.of(c).size;
    return _cardField(
        'Comentario',
        null,
        [
          _textComentario(c),
          SizedBox(
            height: size.height * 0.02,
          ),
        ],
        context);
  }

  Widget _cantidad(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  Widget _tituloCard(String tituloCard, Widget switchHabilitado) {
    return Padding(
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
  }

  Widget _cambiarPatasSwitch(BuildContext c) {
    // return Icon(Icons.account_circle_sharp);
    final size = MediaQuery.of(context).size;
    return Switch(
      value: cambiarPatas,
      onChanged: (value) {
        setState(() {
          cambiarPatas = value;
          _sizePatas = _sizePatas == 0 ? size.height * 0.09 : 0;
        });
      },
      activeTrackColor: Colors.yellow[600],
      activeColor: Colors.yellow[100],
    );
  }

  Widget _tiposDePatas() {
    // return Container();
    return _buscadorPatas(patas);
  }

  Widget _textComentario(BuildContext c) {
    final size = MediaQuery.of(c).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: TextField(
        controller: _comentarioController,
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _esReespaldoEstirado(BuildContext c) {
    final size = MediaQuery.of(c).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.04,
        ),
        Text(
          'Estirado',
          style: styleLabels,
        ),
        Expanded(child: SizedBox()),
        Switch(
          value: esEstiradoReespaldo,
          onChanged: (value) {
            setState(() {
              esEstiradoReespaldo = value;
            });
          },
          activeTrackColor: Colors.yellow[600],
          activeColor: Colors.yellow[100],
        ),
        SizedBox(
          width: size.width * 0.04,
        ),
      ],
    );
  }

  Widget _esAlmohadonesEstirado(BuildContext c) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.04,
        ),
        Text(
          'Estirado',
          style: styleLabels,
        ),
        Expanded(child: SizedBox()),
        Switch(
          value: esEstiradoAlmohadones,
          onChanged: (value) {
            setState(() {
              esEstiradoAlmohadones = value;
            });
          },
          activeTrackColor: Colors.yellow[600],
          activeColor: Colors.yellow[100],
        ),
        SizedBox(
          width: size.width * 0.04,
        ),
      ],
    );
  }

  Widget _botones(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return botonesBottom == true
        ? Row(
            children: [
              SizedBox(
                width: size.width * 0.1,
              ),
              _botonCancelar(context),
              Expanded(child: SizedBox()),
              _botonAceptar(context),
              SizedBox(
                width: size.width * 0.1,
              ),
            ],
          )
        : Container();
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

  Widget _botonCancelar(BuildContext context) {
    return botonOpciones(
      context,
      onPressed: () {
        Navigator.pop(context);
        clearControllers();
      },
      icon: Icon(Icons.cancel_sharp),
      title: 'Cancelar',
      color: Colors.red,
    );
  }

  Widget _botonAceptar(BuildContext context) {
    return botonOpciones(
      context,
      onPressed: () {},
      icon: Icon(Icons.send),
      title: 'Aceptar',
      color: Colors.green,
    );
  }

  Widget _opcionesSilla(BuildContext context) {
    return Column(children: [
      _cantidadCard(context),
      _tela(),
      _patas(context),
      _comentario(context)
    ]);
  }

  Widget _cantidadCard(BuildContext context) {
    return _cardField(
        'Cantidad',
        null,
        [
          _cantidad(_cantSillasController, 'Cantidad'),
          SizedBox(
            height: 10,
          ),
        ],
        context);
  }

  Widget _tela() {
    return Container();
  }

  Widget _opcionesMesa(int tipo, BuildContext context) {
    switch (tipo) {
      case 1:
        return Column(children: [
          _tapaMesa(),
          _patasMesa(),
        ]);
        break;
      default:
    }
    return Column(children: [
      _cantidadCard(context),
      _tela(),
      _patas(context),
      _comentario(context)
    ]);
  }

  Widget _cantidadSillas(TextEditingController controller) {
    return TextFormField();
  }

  Widget _tapaMesa() {
    return Container();
  }

  Widget _patasMesa() {
    return Container();
  }

  Widget _opcionesOtro(BuildContext context) {
    return Column(children: [_cantidadCard(context)]);
  }

  Widget _buscadorPatas(List<DropdownMenuItem> patas) {
    return SearchableDropdown.single(
      items: patas,
      value: selectedValuePatas,
      hint: "Selecciona un producto",
      searchHint: "Busca un producto",
      onChanged: (value) {
        setState(() {
          selectedValuePatas = value.id;
        });
      },
      isExpanded: true,
      iconSize: 40,
      displayClearIcon: true,
    );
  }
}
