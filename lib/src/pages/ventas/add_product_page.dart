import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovle/src/models/color_tela_model.dart';
import 'package:moovle/src/models/patas_model.dart';
import 'package:moovle/src/models/producto_model.dart';
import 'package:moovle/src/models/tela_model.dart';
import 'package:moovle/src/widgets/base_widgets.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class AddProductPage extends StatefulWidget {
  static final String route = 'addProduct';

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // final _formKey = GlobalKey<FormState>();
  // final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();
  final List<DropdownMenuItem<Producto>> productos = [];
  final List<DropdownMenuItem<Patas>> patas = [];
  final List<DropdownMenuItem<Tela>> telas = [];
  final List<DropdownMenuItem<ColorTela>> coloresTela = [];
  List<DropdownMenuItem<ColorTela>> coloresSegunTela = [];
  int selectedValueProducto;
  int selectedValuePatas;
  int selectedValueTela;
  int selectedValueColor;
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
    super.initState();
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

    telas.add(DropdownMenuItem(
      child: Text('Mica'),
      value: Tela(id: 1, nombre: 'Mica'),
    ));

    coloresTela.add(DropdownMenuItem(
      child: Text('Gris'),
      value: ColorTela(id: 1, nombre: 'Gris', tipo: 1),
    ));

    coloresTela.add(DropdownMenuItem(
      child: Text('Negro'),
      value: ColorTela(id: 2, nombre: 'Negro', tipo: 1),
    ));

    coloresTela.add(DropdownMenuItem(
      child: Text('Blanco'),
      value: ColorTela(id: 3, nombre: 'Blanco', tipo: 1),
    ));

    coloresTela.add(DropdownMenuItem(
      child: Text('Rojo'),
      value: ColorTela(id: 4, nombre: 'Rojo', tipo: 1),
    ));

    telas.add(DropdownMenuItem(
      child: Text('Tela 1'),
      value: Tela(id: 2, nombre: 'Tela 1'),
    ));

    coloresTela.add(DropdownMenuItem(
      child: Text('Gris'),
      value: ColorTela(id: 5, nombre: 'Gris', tipo: 2),
    ));

    coloresTela.add(DropdownMenuItem(
      child: Text('Azul'),
      value: ColorTela(id: 6, nombre: 'Azul', tipo: 2),
    ));

    telas.add(DropdownMenuItem(
      child: Text('Tela 2'),
      value: Tela(id: 3, nombre: 'Tela 2'),
    ));

    // coloresTela.add(DropdownMenuItem(
    //   child: Text('Naranja'),
    //   value: ColorTela(id: 7, nombre: 'Naranja', tipo: 3),
    // ));

    // coloresTela.add(DropdownMenuItem(
    //   child: Text('Celeste'),
    //   value: ColorTela(id: 8, nombre: 'Celeste', tipo: 3),
    // ));
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
          if (value == null)
            _clearTextEdit = false;
          else
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
    // List<DropdownMenuItem<Tela>> telas;
    switch (categoria) {
      case 0:
        opciones = _opcionesOtro(context);
        break;
      case 1:
        opciones = _opcionesSillon(context, telas);
        break;
      case 2:
        opciones = _opcionesSilla(context, telas);
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

  Widget _opcionesSillon(
      BuildContext context, List<DropdownMenuItem<Tela>> telas) {
    return Column(children: [
      _reesplado(context),
      _almohadones(context),
      _tela(context, telas),
      _patas(context),
      _comentario(context)
    ]);
  }

  Widget _reesplado(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return cardField(
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

  Widget _almohadones(BuildContext context) {
    return cardField(
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
    return cardField(
        'Patas',
        _cambiarPatasSwitch(c),
        [
          Container(
            height: _sizePatas,
            child: _tiposDePatas(),
          ),
          SizedBox(
            height: size.height * 0.01,
          )
        ],
        context);
  }

  Widget _comentario(BuildContext c) {
    final size = MediaQuery.of(c).size;
    return cardField(
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

  Widget _cambiarPatasSwitch(BuildContext c) {
    // return Icon(Icons.account_circle_sharp);
    final size = MediaQuery.of(context).size;
    return Switch(
      value: cambiarPatas,
      onChanged: (value) {
        setState(() {
          cambiarPatas = value;
          _sizePatas = _sizePatas == 0 ? size.height * 0.12 : 0;
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
      onPressed: () {
        final producto = productos
            .firstWhere((element) => element.value.id == selectedValueProducto)
            .value;
        var cantidad = 1;

        if (_cantSillasController.text != '')
          cantidad = int.parse(_cantSillasController.text);
        Navigator.pop(context, [producto, cantidad]);
      },
      icon: Icon(Icons.send),
      title: 'Aceptar',
      color: Colors.green,
    );
  }

  Widget _opcionesSilla(
      BuildContext context, List<DropdownMenuItem<Tela>> telas) {
    return Column(children: [
      _cantidadCard(context),
      _tela(context, telas),
      _patas(context),
      _comentario(context)
    ]);
  }

  Widget _cantidadCard(BuildContext context) {
    return cardField(
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

  Widget _tela(BuildContext c, List<DropdownMenuItem<Tela>> telas) {
    final size = MediaQuery.of(c).size;
    return cardField(
        'Tela',
        null,
        [
          Container(
            child: _buscadorTela(telas),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
            child: _buscadorColorTela(),
          ),
        ],
        context);
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

  Widget _buscadorPatas(List<DropdownMenuItem<Patas>> patas) {
    return SearchableDropdown.single(
      items: patas,
      readOnly: _sizePatas == 0,
      value: selectedValuePatas,
      hint: "Selecciona un producto",
      searchHint: "Busca un producto",
      onChanged: (value) {
        var a = 2;
        setState(() {
          selectedValuePatas = value.id;
        });
      },
      isExpanded: true,
      iconSize: 40,
      displayClearIcon: true,
    );
  }

  Widget _buscadorTela(List<DropdownMenuItem<Tela>> telas) {
    return SearchableDropdown.single(
      items: telas,
      value: selectedValueTela,
      hint: "Selecciona una tela",
      searchHint: "Busca una tela",
      onChanged: (value) {
        setState(() {
          if (value != null) {
            // if (selectedValueTela != value.id) {
            //   selectedValueColor = 1s;
            // }
            selectedValueTela = value.id;

            coloresSegunTela.clear();
            coloresTela.forEach((element) {
              if (element.value.tipo == selectedValueTela)
                coloresSegunTela.add(element);
            });
          }
        });
      },
      isExpanded: true,
      iconSize: 40,
      displayClearIcon: true,
    );
  }

  Widget _buscadorColorTela() {
    return SearchableDropdown.single(
      items: coloresSegunTela,
      value: selectedValueColor,
      hint: "Selecciona un color",
      searchHint: "Busca un color",
      onChanged: (value) {
        setState(() {
          selectedValueColor = value?.id;
        });
      },
      isExpanded: true,
      iconSize: 40,
      displayClearIcon: true,
    );
  }
}
