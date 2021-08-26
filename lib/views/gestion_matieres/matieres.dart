import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/controllers/matieres_controller.dart';
import 'package:vetcam/models/matiere_model.dart';

class Matieres extends StatefulWidget {
  const Matieres({Key? key}) : super(key: key);

  @override
  _MatieresState createState() => _MatieresState();
}

class _MatieresState extends State<Matieres> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codeController;
  late TextEditingController _designationController;
  late TextEditingController _uniteController;
  late TextEditingController _quantiteController;
  late TextEditingController _prixUController;
  late TextEditingController _observationController;

  @override
  void initState() {
    _codeController = TextEditingController(text: "");
    _designationController = TextEditingController(text: "");
    _uniteController = TextEditingController(text: "");
    _quantiteController = TextEditingController(text: "");
    _prixUController = TextEditingController(text: "");
    _observationController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    Hive.box('matieres').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: GFColors.DARK,
        title: const Text("Matieres"),
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
                    text: "Ajouter nouveau matiere",
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
                                      Input(
                                        hint: 'Code',
                                        nomController: _codeController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                      Input(
                                        hint: 'Désignation',
                                        nomController: _designationController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                      Input(
                                        hint: 'Unité',
                                        nomController: _uniteController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                      Input(
                                        hint: 'Quantité',
                                        nomController: _quantiteController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          } else if (double.tryParse(value) ==
                                              null) {
                                            return 'Only numbers are allowed';
                                          }
                                          return null;
                                        },
                                      ),
                                      Input(
                                        hint: 'Prix Unitaire',
                                        nomController: _prixUController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          } else if (double.tryParse(value) ==
                                              null) {
                                            return 'Only numbers are allowed';
                                          }
                                          return null;
                                        },
                                      ),
                                      Input(
                                        hint: 'Observation',
                                        nomController: _observationController,
                                        validator: (value) {
                                          return null;
                                        },
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
                                                final id = getLastMatiereId();
                                                final matiere = MatiereModel()
                                                  ..id = id.toString()
                                                  ..code = _codeController.text
                                                  ..designation =
                                                      _designationController
                                                          .text
                                                  ..unite =
                                                      _uniteController.text
                                                  ..quantite = double.parse(
                                                      _quantiteController.text)
                                                  ..prixU = double.parse(
                                                      _prixUController.text)
                                                  ..observation =
                                                      _observationController
                                                          .text;
                                                await addMatiere(matiere);
                                                await updateLastMatiereId(id);
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
                valueListenable: Boxes.getMatieres().listenable(),
                builder: (BuildContext context, Box<MatiereModel> box, _) {
                  final matieres =
                      box.values.toList().cast<MatiereModel>().toList();
                  return DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blueGrey[100] as Color),
                    headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    columns: [
                      DataColumn(label: Text('N°')),
                      DataColumn(label: Text('Actions')),
                      DataColumn(label: Text('Code produit')),
                      DataColumn(label: Text('Désignation')),
                      DataColumn(label: Text('Unité')),
                      DataColumn(label: Text('Qantité')),
                      DataColumn(label: Text('Prix Unité')),
                      DataColumn(label: Text('Prix Total')),
                      DataColumn(label: Text('Observation')),
                    ],
                    rows: matieres
                        .map(
                          (matiere) {
                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text(matiere.id)),
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
                                            await matiere.delete();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                DataCell(Text(matiere.code)),
                                DataCell(Text(matiere.designation)),
                                DataCell(Text(matiere.unite)),
                                DataCell(Text(matiere.quantite.toString())),
                                DataCell(Text(matiere.prixU.toString())),
                                DataCell(Text((matiere.prixU * matiere.quantite)
                                    .toString())),
                                DataCell(Text(matiere.observation)),
                              ],
                            );
                          },
                        )
                        .toList()
                        .cast<DataRow>(),
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

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required TextEditingController nomController,
    required this.hint,
    required this.validator,
  })  : _nomController = nomController,
        super(key: key);

  final TextEditingController _nomController;
  final String hint;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: FractionallySizedBox(
        widthFactor: 0.4,
        child: TextFormField(
          controller: _nomController,
          decoration: InputDecoration(
            hintText: hint,
          ),
          validator: validator,
        ),
      ),
    );
  }
}
