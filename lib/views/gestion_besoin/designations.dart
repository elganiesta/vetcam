import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/controllers/produits_controller.dart';
import 'package:vetcam/models/produit_model.dart';

class Designations extends StatefulWidget {
  const Designations({Key? key}) : super(key: key);

  @override
  _DesignationsState createState() => _DesignationsState();
}

class _DesignationsState extends State<Designations> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _typeController;

  @override
  void initState() {
    _nomController = TextEditingController(text: "");
    _typeController = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: GFColors.DARK,
        title: const Text("Designations"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GFButton(
                    text: "Ajouter un produits",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: FractionallySizedBox(
                                          widthFactor: 0.4,
                                          child: TextFormField(
                                            controller: _nomController,
                                            decoration: InputDecoration(
                                              hintText: 'Nom',
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: FractionallySizedBox(
                                          widthFactor: 0.4,
                                          child: TextFormField(
                                            controller: _typeController,
                                            decoration: InputDecoration(
                                              hintText: 'Type',
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Wrap(
                                        children: [
                                          GFButton(
                                            text: "Enregistrer",
                                            color: GFColors.SUCCESS,
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final id = getLastProduitId();
                                                final produit = ProduitModel()
                                                  ..id = id.toString()
                                                  ..nom = _nomController.text
                                                  ..type = _typeController.text;
                                                await addProduit(produit);
                                                await updateLastProduitId(id);
                                                _formKey.currentState!.reset();
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          GFButton(
                                            text: "Annuler",
                                            color: GFColors.DANGER,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                valueListenable: Boxes.getProduits().listenable(),
                builder: (BuildContext context, Box<ProduitModel> box, _) {
                  final designations =
                      box.values.toList().cast<ProduitModel>().toList();
                  return DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blueGrey[100] as Color),
                    headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    columns: [
                      DataColumn(label: Text('N°')),
                      DataColumn(label: Text('ACTIONS')),
                      DataColumn(label: Text('NOM')),
                      DataColumn(label: Text('TYPE')),
                    ],
                    rows: designations.map(
                      (produit) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Text(produit.id)),
                            DataCell(
                              Container(
                                child: Row(
                                  children: [
                                    GFIconButton(
                                      tooltip: "Supprimer",
                                      color: GFColors.DANGER,
                                      size: GFSize.SMALL,
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        await produit.delete();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DataCell(Text(produit.nom)),
                            DataCell(Text(produit.type)),
                          ],
                        );
                      },
                    ).toList().cast<DataRow>(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
