import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/controllers/besoins_controller.dart';
import 'package:vetcam/models/besoinItem_model.dart';
import 'package:vetcam/models/besoin_model.dart';
import 'package:vetcam/models/produit_model.dart';

import '../../const.dart';

class CreateBesoin extends StatefulWidget {
  const CreateBesoin({Key? key}) : super(key: key);

  @override
  State<CreateBesoin> createState() => _CreateBesoinState();
}

class _CreateBesoinState extends State<CreateBesoin> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _dateController;
  late TextEditingController _serviceController;
  late TextEditingController _quantiteController;
  late TextEditingController _dateLivController;
  String _besoinId = "";
  bool _urgent = false;

  List<BesoinItem> _besoinsItems = [];

  late List<ProduitModel> _produits;
  ProduitModel? _produitSelected;

  List<String> _types = [];
  String? _typeSelected;

  @override
  void initState() {
    _produits = Boxes.getProduits().values.toList().cast<ProduitModel>();
    if (_produits.length != 0) _produitSelected = _produits[0];

    _dateController = TextEditingController(text: DateTime.now().toString());
    _dateLivController = TextEditingController(text: DateTime.now().toString());
    _serviceController = TextEditingController(text: "");
    _quantiteController = TextEditingController(text: "");
    _besoinId = getLastBesoinId().toString();

    Set types = {};
    _produits.forEach((produit) {
      types.add(produit.type.toLowerCase());
    });
    _types = types.toList().cast<String>();
    if (_types.length != 0) _typeSelected = _types[0];

    super.initState();
  }

  bool checkBoxValid() {
    return true;
  }

  Future<void> ajouteBesoin() async {
    final besoin = BesoinModel()
      ..id = _besoinId
      ..service = _serviceController.text
      ..urgent = _urgent
      ..date = convertToDateTime(_dateController.text)
      ..besoins = _besoinsItems;
    await addBesoin(besoin);
    await updateLastBesoinId(int.parse(_besoinId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //Header of the screen
                Table(
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        Image.asset(
                          "assets/images/vetcam.png",
                          height: 100,
                        ),
                        const Center(
                          child: Text(
                            "FICHE BESOIN",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Date, time, demandeur, n ordre
                Table(
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        CellTitle(text: 'Date'),
                        CellTitle(text: 'Service'),
                        CellTitle(text: 'URGENT'),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: DateTimePicker(
                            type: DateTimePickerType.dateTime,
                            dateMask: 'd/MM/yyyy HH:mm',
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(Icons.event),
                            dateLabelText: 'Date',
                            timeLabelText: "Hour",
                            controller: _dateController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Service',
                            ),
                            controller: _serviceController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Checkbox(
                          value: _urgent,
                          onChanged: (bool? value) {
                            setState(() {
                              _urgent = value as bool;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //add to LISTE DES INTERVENANTS
                Table(
                  columnWidths: {
                    0: FixedColumnWidth(80),
                    1: FixedColumnWidth(80),
                    3: FixedColumnWidth(150),
                  },
                  border: TableBorder.all(
                    color: Colors.black,
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        CellTitle(text: ''),
                        CellTitle(text: 'N°'),
                        CellTitle(text: 'Désignation'),
                        CellTitle(text: 'Quantité'),
                        CellTitle(text: 'Date de livraison'),
                      ],
                    ),
                    for (var besoin in _besoinsItems)
                      TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GFIconButton(
                                tooltip: "Supprimer",
                                color: GFColors.DANGER,
                                size: GFSize.SMALL,
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  setState(() {
                                    _besoinsItems.remove(besoin);
                                  });
                                },
                              ),
                            ),
                          ),
                          CellTitle(
                            text: besoin.numero,
                            title: false,
                          ),
                          CellTitle(
                            text: besoin.designation,
                            title: false,
                          ),
                          CellTitle(
                            text: besoin.quantite,
                            title: false,
                          ),
                          CellTitle(
                            text: besoin.observation,
                            title: false,
                          ),
                        ],
                      ),
                    TableRow(
                      children: [
                        Center(
                          child: GFIconButton(
                            tooltip: "Ajouter",
                            color: GFColors.PRIMARY,
                            size: GFSize.SMALL,
                            icon: Icon(Icons.add),
                            onPressed: () async {
                              if (_quantiteController.text == "") {
                                showMessage(
                                    context, "Quantité est obligatoire !.");
                              } else if (_produitSelected == null) {
                                showMessage(
                                    context, "Produit est obligatoire !.");
                              } else {
                                var besoin = BesoinItem()
                                  ..numero =
                                      (_besoinsItems.length + 1).toString()
                                  ..designation = _produitSelected!.nom
                                  ..quantite = _quantiteController.text
                                  ..observation = convertToDateTime(
                                      _dateLivController.text);
                                setState(() {
                                  _besoinsItems.add(besoin);
                                  _quantiteController.text = "";
                                });
                              }
                            },
                          ),
                        ),
                        CellTitle(
                          text: (_besoinsItems.length + 1).toString(),
                          title: false,
                        ),
                        if (_produitSelected != null)
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  items: _types
                                      .map((type) {
                                        return DropdownMenuItem<String>(
                                          child: Text(type),
                                          value: type,
                                        );
                                      })
                                      .toList()
                                      .cast<DropdownMenuItem<String>>(),
                                  value: _typeSelected,
                                  onChanged: (dynamic val) {
                                    var produits = _produits
                                        .where((produit) =>
                                            produit.type.toLowerCase() == val)
                                        .toList();
                                    setState(() {
                                      if (produits.length != 0) {
                                        _produitSelected = produits[0];
                                        _typeSelected = val;
                                      }
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton<ProduitModel>(
                                    isExpanded: true,
                                    items: _produits
                                        .where((produit) =>
                                            produit.type.toLowerCase() ==
                                            _typeSelected)
                                        .map((produit) {
                                          return DropdownMenuItem<ProduitModel>(
                                            child: Text(produit.nom),
                                            value: produit,
                                          );
                                        })
                                        .toList()
                                        .cast<DropdownMenuItem<ProduitModel>>(),
                                    value: _produitSelected,
                                    onChanged: (dynamic val) {
                                      setState(() {
                                        _produitSelected = val;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (_produitSelected == null)
                          Center(
                            child: GFButton(
                              color: GFColors.PRIMARY,
                              size: GFSize.SMALL,
                              text: 'Ajouter des désignations',
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/Designations');
                              },
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Quantité',
                            ),
                            controller: _quantiteController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: DateTimePicker(
                            type: DateTimePickerType.dateTime,
                            dateMask: 'd/MM/yyyy HH:mm',
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(Icons.event),
                            dateLabelText: 'Date',
                            timeLabelText: "Hour",
                            controller: _dateLivController,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                // Actions
                FractionallySizedBox(
                  widthFactor: 1 / 6,
                  child: GFButton(
                    color: GFColors.SECONDARY,
                    text: "Sauvegarder",
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                      } else if (_besoinsItems.length == 0) {
                        showMessage(context, "Ajouter au moins un besoin");
                      } else {
                        await ajouteBesoin();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CellTitle extends StatelessWidget {
  const CellTitle({
    Key? key,
    required this.text,
    this.title = true,
  }) : super(key: key);

  final String text;
  final bool title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: title ? Colors.grey[200] : null,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: title ? FontWeight.bold : null,
          ),
        ),
      ),
    );
  }
}
