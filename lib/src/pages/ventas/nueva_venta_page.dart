import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final List<DropdownMenuItem> items = [];
  String selectedValue;
  TextStyle styleLabels = TextStyle(fontSize: 15);
  TextStyle styleTituloCard =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  List<Widget> opcionesSillon;
  final _cantDivisionesController = TextEditingController();
  final _comentarioController = TextEditingController();
  bool esEstiradoReespaldo = false;
  bool esEstiradoAlmohadones = false;
  bool cambiarPatas = false;
  @override
  void initState() {
    items.add(DropdownMenuItem(
      child: Text('Sillon 1.6'),
      value: 1,
    ));
    items.add(DropdownMenuItem(
      child: Text('Sillon 1.8'),
      value: 2,
    ));

    items.add(DropdownMenuItem(
      child: Text('Mesa 1.6'),
      value: 3,
    ));
    items.add(DropdownMenuItem(
      child: Text('Mesa 1.8'),
      value: 4,
    ));
    items.add(DropdownMenuItem(
      child: Text('Puff'),
      value: 5,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    opcionesSillon = [_reesplado(), _almohadones(), _patas(), _comentario()];
    return Scaffold(
      appBar: appBarMoovle(texto: 'Nueva venta', context: context),
      body: ListView(
          // padding: EdgeInsets.all(4),
          children: <Widget>[
            _buscadorProducto(),
            _opcionesSegunCategoria(),
            _botones()
          ]),
    );
  }

  Widget _buscadorProducto() {
    return SearchableDropdown.single(
      items: items,
      value: selectedValue,
      hint: "Selecciona un producto",
      searchHint: "Busca un producto",
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      isExpanded: true,
      iconSize: 40,
      displayClearIcon: true,
    );
  }

  Widget _opcionesSegunCategoria() {
    final categoria = 1; //sillones

    Widget opciones;
    switch (categoria) {
      case 1:
        opciones = _opcionesSillon();
        break;
      default:
    }
    return opciones;
  }

  Widget _opcionesSillon() {
    return Column(
      children: opcionesSillon,
    );
  }

  Widget _reesplado() {
    return _cardField('Reespaldo', null, [
      _cantidadDivisiones(),
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
    return _cardField(
        'Almohadones', null, [_cantidadDivisiones(), _esAlmohadonesEstirado()]);
  }

  Widget _patas() {
    return _cardField('Patas', null, [
      _tiposDePatas(),
      SizedBox(
        height: 20,
      )
    ]);
  }

  Widget _comentario() {
    return _cardField('Comentario', null, [
      _textComentario(),
      SizedBox(
        height: 20,
      )
    ]);
  }

  Widget _cantidadDivisiones() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _cantDivisionesController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Divisiones',
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
    return _buscadorProducto();
  }

  Widget _textComentario() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _comentarioController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Comentario',
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

  Widget _botones() {
    return Row(
      children: [
        SizedBox(
          width: 40,
        ),
        _botonCancelar(),
        Expanded(child: SizedBox()),
        _botonAceptar(),
        SizedBox(
          width: 40,
        ),
      ],
    );
  }

  Widget _botonCancelar() {
    return ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.cancel_sharp),
        label: Text('Cancelar'));
  }

  Widget _botonAceptar() {
    return ElevatedButton.icon(
        onPressed: () {}, icon: Icon(Icons.send), label: Text('Aceptar'));
  }
}
