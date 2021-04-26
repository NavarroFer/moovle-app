// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  int selectedValue;
  TextStyle styleLabels = TextStyle(fontSize: 15);
  TextStyle styleTituloCard =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  List<Widget> opcionesSillon;
  final _cantDivisionesReespladoController = TextEditingController();
  final _cantDivisionesAlmohadonesController = TextEditingController();
  final _comentarioController = TextEditingController();
  final _cantSillasController = TextEditingController();
  bool esEstiradoReespaldo = false;
  bool esEstiradoAlmohadones = false;
  bool cambiarPatas = false;
  bool botonesBottom;
  int categoria;
  int tipo;
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
      value: 1,
    ));

    patas.add(DropdownMenuItem(
      child: Text('Paraiso'),
      value: 2,
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
            _opcionesSegunCategoria(),
            _botones(context),
            SizedBox(
              height: 20,
            ),
          ]),
    );
  }

  Widget _buscadorProducto(List<DropdownMenuItem<Producto>> items) {
    return SearchableDropdown.single(
      items: items,
      value: selectedValue,
      hint: "Selecciona un producto",
      searchHint: "Busca un producto",
      onChanged: (value) {
        setState(() {
          selectedValue = value.id;
          categoria = value.categoria;
          tipo = value.tipo;
        });
      },
      isExpanded: true,
      iconSize: 40,
      displayClearIcon: true,
    );
  }

  Widget _opcionesSegunCategoria() {
    Widget opciones;
    botonesBottom = true;
    clearControllers();

    switch (categoria) {
      case 1:
        opciones = _opcionesSillon();
        break;
      case 2:
        opciones = _opcionesSilla();
        break;
      case 3:
        opciones = _opcionesMesa(tipo);
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

  Widget _opcionesSillon() {
    return Column(children: [
      _reesplado(),
      _almohadones(),
      _patas(),
      _comentario(context)
    ]);
  }

  Widget _reesplado() {
    return _cardField('Reespaldo', null, [
      _cantidad(_cantDivisionesReespladoController, 'Reespaldo'),
      SizedBox(
        height: 10,
      ),
      _esReespaldoEstirado(),
    ]);
  }

  Widget _cardField(
      String tituloCard, Widget switchHabilitado, List<Widget> listaFields) {
    return Card(
      color: Colors.white60,
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          _tituloCard(tituloCard, switchHabilitado),
          SizedBox(
            height: 20,
          ),
          Column(
            children: listaFields,
          ),
        ],
      ),
    );
  }

  Widget _almohadones() {
    return _cardField('Almohadones', null, [
      _cantidad(_cantDivisionesAlmohadonesController, 'Almohadones'),
      _esAlmohadonesEstirado()
    ]);
  }

  Widget _patas() {
    return _cardField('Patas', null, [
      _tiposDePatas(),
      SizedBox(
        height: 20,
      )
    ]);
  }

  Widget _comentario(BuildContext c) {
    return _cardField('Comentario', null, [
      _textComentario(c),
      SizedBox(
        height: 20,
      )
    ]);
  }

  Widget _cantidad(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
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
            ],
          )),
    );
  }

  Widget _cambiarPatasSwitch() {
    // return Icon(Icons.account_circle_sharp);
    return Switch(
      value: cambiarPatas,
      onChanged: (value) {
        setState(() {
          cambiarPatas = value;
        });
      },
      activeTrackColor: Colors.yellow[600],
      activeColor: Colors.yellow[100],
    );
  }

  Widget _tiposDePatas() {
    return Container();
    return _buscadorProducto(patas);
  }

  Widget _textComentario(BuildContext c) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04),
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

  Widget _esReespaldoEstirado() {
    return Row(
      children: [
        SizedBox(width: 20),
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
        SizedBox(width: 20),
      ],
    );
  }

  Widget _esAlmohadonesEstirado() {
    return Row(
      children: [
        SizedBox(width: 20),
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
        SizedBox(width: 20),
      ],
    );
  }

  Widget _botones(BuildContext context) {
    return botonesBottom == true
        ? Row(
            children: [
              SizedBox(
                width: 40,
              ),
              _botonCancelar(context),
              Expanded(child: SizedBox()),
              _botonAceptar(),
              SizedBox(
                width: 40,
              ),
            ],
          )
        : Container();
  }

  Widget _botonCancelar(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pop(context);
        clearControllers();
      },
      icon: Icon(Icons.cancel_sharp),
      label: Text('Cancelar'),
    );
  }

  Widget _botonAceptar() {
    return ElevatedButton.icon(
        onPressed: () {}, icon: Icon(Icons.send), label: Text('Aceptar'));
  }

  Widget _opcionesSilla() {
    return Column(
        children: [_cantidadCard(), _tela(), _patas(), _comentario(context)]);
  }

  Widget _cantidadCard() {
    return _cardField('Cantidad', null, [
      _cantidad(_cantSillasController, 'Cantidad'),
      SizedBox(
        height: 10,
      ),
    ]);
  }

  Widget _tela() {
    return Container();
  }

  Widget _opcionesMesa(int tipo) {
    switch (tipo) {
      case 1:
        return Column(children: [
          _tapaMesa(),
          _patasMesa(),
        ]);
        break;
      default:
    }
    return Column(
        children: [_cantidadCard(), _tela(), _patas(), _comentario(context)]);
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
}
