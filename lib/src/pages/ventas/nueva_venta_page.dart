import 'package:dropdown_search/dropdown_search.dart';
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
    return Scaffold(
        appBar: appBarMoovle(texto: 'Nueva venta', context: context),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(padding: EdgeInsets.all(4), children: <Widget>[
            SearchableDropdown.single(
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
            ),
          ]),
        ));
  }
}
