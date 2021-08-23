import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:vetcam/controllers/ordres_travail_controller.dart';
import 'package:vetcam/models/ordre_travail_model.dart';

import '../../const.dart';

class OrdreTravail extends StatefulWidget {
  const OrdreTravail({Key? key}) : super(key: key);

  @override
  State<OrdreTravail> createState() => _OrdreTravailState();
}

class _OrdreTravailState extends State<OrdreTravail> {
  String _uniteSelected = 'ALPHA';
  List<bool> _travailSelected = [false, false, false, false, false];
  List<bool> _piecesSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  late TextEditingController _debutController;
  late TextEditingController _finController;
  late TextEditingController _demandeurController;
  String _duree = "";

  @override
  void initState() {
    _debutController = TextEditingController(text: DateTime.now().toString());
    _finController = TextEditingController(text: '');
    _demandeurController = TextEditingController(text: "");
    calculateDuree();
    super.initState();
  }

  void calculateDuree() {
    if (_finController.text != "") {
      DateTime _dateTimeDebut = DateTime.parse(_debutController.text);
      DateTime _dateTimeFin = DateTime.parse(_finController.text);
      setState(() {
        _duree = (_dateTimeFin.difference(_dateTimeDebut)).toString();
      });
    }
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
                          "ORDRE DU TRAVAIL",
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
                      CellTitle(text: 'DEBUT'),
                      CellTitle(text: 'FIN'),
                      CellTitle(text: 'DUREE'),
                      CellTitle(text: 'DEMANDEUR'),
                      CellTitle(text: 'N° ORDRE'),
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
                          controller: _debutController,
                          onChanged: (val) => calculateDuree(),
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
                          controller: _finController,
                          onChanged: (val) => calculateDuree(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(_duree),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Nom et prénom',
                          ),
                          controller: _demandeurController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('14'),
                      ),
                    ],
                  ),
                ],
              ),
              // Unite
              Table(
                border: TableBorder.all(
                  color: Colors.black,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  const TableRow(
                    children: [
                      CellTitle(text: 'UNITE BENIFICIARE'),
                    ],
                  ),
                  TableRow(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Radio(
                            value: "ALPHA",
                            groupValue: _uniteSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _uniteSelected = value as String;
                              });
                            },
                          ),
                          const Text("ALPHA"),
                          Radio(
                            value: "TENSYLAND",
                            groupValue: _uniteSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _uniteSelected = value as String;
                              });
                            },
                          ),
                          const Text("TENSYLAND"),
                          Radio(
                            value: "POLISSAGE",
                            groupValue: _uniteSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _uniteSelected = value as String;
                              });
                            },
                          ),
                          const Text("POLISSAGE"),
                          Radio(
                            value: "P. ENROBEE",
                            groupValue: _uniteSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _uniteSelected = value as String;
                              });
                            },
                          ),
                          const Text("P. ENROBEE"),
                          Radio(
                            value: "MOBILIER URBAIN",
                            groupValue: _uniteSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _uniteSelected = value as String;
                              });
                            },
                          ),
                          const Text("MOBILIER URBAIN"),
                          Radio(
                            value: "BPE",
                            groupValue: _uniteSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _uniteSelected = value as String;
                              });
                            },
                          ),
                          const Text("BPE"),
                          Radio(
                            value: "AUTRE",
                            groupValue: _uniteSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _uniteSelected = value as String;
                              });
                            },
                          ),
                          const Text("AUTRE"),
                          if (_uniteSelected == "AUTRE")
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Tapez ici..',
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Type du travail
              Table(
                border: TableBorder.all(
                  color: Colors.black,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  const TableRow(
                    children: [
                      CellTitle(text: 'TYPE DU TRAVAIL'),
                    ],
                  ),
                  TableRow(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Checkbox(
                            value: _travailSelected[0],
                            onChanged: (bool? value) {
                              setState(() {
                                _travailSelected[0] = value as bool;
                              });
                            },
                          ),
                          const Text("CONCEPTION MECANIQUE"),
                          Checkbox(
                            value: _travailSelected[1],
                            onChanged: (bool? value) {
                              setState(() {
                                _travailSelected[1] = value as bool;
                              });
                            },
                          ),
                          const Text("REPARATION"),
                          Checkbox(
                            value: _travailSelected[2],
                            onChanged: (bool? value) {
                              setState(() {
                                _travailSelected[2] = value as bool;
                              });
                            },
                          ),
                          const Text("REGLAGE"),
                          Checkbox(
                            value: _travailSelected[3],
                            onChanged: (bool? value) {
                              setState(() {
                                _travailSelected[3] = value as bool;
                              });
                            },
                          ),
                          const Text("MAINTENANCE PREVENTIVE"),
                          Checkbox(
                            value: _travailSelected[4],
                            onChanged: (bool? value) {
                              setState(() {
                                _travailSelected[4] = value as bool;
                              });
                            },
                          ),
                          const Text("AUTRE"),
                          if (_travailSelected[4] == true)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Tapez ici..',
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Travail demande
              Table(
                border: TableBorder.all(
                  color: Colors.black,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: const [
                  TableRow(
                    children: [
                      CellTitle(text: 'TRAVAIL DEMANDE'),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Tapez ici..',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // LISTE DES INTERVENANTS
              // Table(
              //   border: TableBorder.all(
              //     color: Colors.black,
              //   ),
              //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              //   children: [
              //     const TableRow(
              //       children: [
              //         CellTitle(text: 'LISTE DES INTERVENANTS'),
              //       ],
              //     ),
              //     TableRow(
              //       children: [
              //         FractionallySizedBox(
              //           widthFactor: 1 / 5,
              //           child: GFButton(
              //             text: "Ajouter",
              //             onPressed: () {
              //               showDialog(
              //                 context: context,
              //                 builder: (context) {
              //                   return Dialog(
              //                     child: SingleChildScrollView(
              //                       child: Column(
              //                         children: [
              //                           const Padding(
              //                             padding: EdgeInsets.symmetric(
              //                                 horizontal: 12.0),
              //                             child: FractionallySizedBox(
              //                               widthFactor: 0.4,
              //                               child: TextField(
              //                                 decoration: InputDecoration(
              //                                     hintText: 'Nom'),
              //                               ),
              //                             ),
              //                           ),
              //                           const Padding(
              //                             padding: EdgeInsets.symmetric(
              //                                 horizontal: 12.0),
              //                             child: FractionallySizedBox(
              //                               widthFactor: 0.4,
              //                               child: TextField(
              //                                 decoration: InputDecoration(
              //                                     hintText: 'Fonction'),
              //                               ),
              //                             ),
              //                           ),
              //                           const SizedBox(
              //                             height: 20,
              //                           ),
              //                           Wrap(
              //                             children: [
              //                               GFButton(
              //                                 text: "Enregistrer",
              //                                 color: GFColors.SUCCESS,
              //                                 onPressed: () {},
              //                               ),
              //                               const SizedBox(
              //                                 width: 20,
              //                               ),
              //                               GFButton(
              //                                 text: "Annuler",
              //                                 color: GFColors.DANGER,
              //                                 onPressed: () {
              //                                   Navigator.pop(context);
              //                                 },
              //                               ),
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               );
              //             },
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // add to LISTE DES INTERVENANTS
              // Table(
              //   border: TableBorder.all(
              //     color: Colors.black,
              //   ),
              //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              //   children: const [
              //     TableRow(
              //       children: [
              //         CellTitle(text: 'NOM'),
              //         CellTitle(text: 'FONCTION'),
              //         CellTitle(text: 'VISA'),
              //       ],
              //     ),
              //     TableRow(
              //       children: [
              //         Center(
              //           child: Text(
              //             "Nom prenom",
              //           ),
              //         ),
              //         Center(
              //           child: Text(
              //             "Fonction",
              //           ),
              //         ),
              //         Center(
              //           child: Text(
              //             "Signature",
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // PIECES JOINTES
              Table(
                border: TableBorder.all(
                  color: Colors.black,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  const TableRow(
                    children: [
                      CellTitle(text: 'PIECES JOINTES'),
                    ],
                  ),
                  TableRow(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Checkbox(
                            value: _piecesSelected[0],
                            onChanged: (bool? value) {
                              setState(() {
                                _piecesSelected[0] = value as bool;
                              });
                            },
                          ),
                          const Text("RAPPORT D'INTERVENTION"),
                          Checkbox(
                            value: _piecesSelected[1],
                            onChanged: (bool? value) {
                              setState(() {
                                _piecesSelected[1] = value as bool;
                              });
                            },
                          ),
                          const Text("FACTURE"),
                          Checkbox(
                            value: _piecesSelected[2],
                            onChanged: (bool? value) {
                              setState(() {
                                _piecesSelected[2] = value as bool;
                              });
                            },
                          ),
                          const Text("DEVIS"),
                          Checkbox(
                            value: _piecesSelected[3],
                            onChanged: (bool? value) {
                              setState(() {
                                _piecesSelected[3] = value as bool;
                              });
                            },
                          ),
                          const Text("DESSIN"),
                          Checkbox(
                            value: _piecesSelected[4],
                            onChanged: (bool? value) {
                              setState(() {
                                _piecesSelected[4] = value as bool;
                              });
                            },
                          ),
                          const Text("SCHEMA"),
                          Checkbox(
                            value: _piecesSelected[5],
                            onChanged: (bool? value) {
                              setState(() {
                                _piecesSelected[5] = value as bool;
                              });
                            },
                          ),
                          const Text("FICHE TECHNIQUE"),
                          Checkbox(
                            value: _piecesSelected[6],
                            onChanged: (bool? value) {
                              setState(() {
                                _piecesSelected[6] = value as bool;
                              });
                            },
                          ),
                          const Text("AUTRE"),
                          if (_piecesSelected[6] == true)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Tapez ici..',
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Commentaire
              Column(
                children: const [
                  Text(
                    'Commentaire :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tapez ici..',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              // Actions
              Wrap(
                children: [
                  FractionallySizedBox(
                    widthFactor: 1 / 6,
                    child: GFButton(
                      color: GFColors.SUCCESS,
                      text: "Sauvegarder",
                      onPressed: () {
                        final ordre = OrdreTravailModel()
                          ..id = "5"
                          ..dateTimeDebut = convertToDateTime(_debutController.text)
                          ..dateTimeFin = convertToDateTime(_finController.text)
                          ..demandeur = _demandeurController.text;
                        addOrdreTravail(ordre);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1 / 6,
                    child: GFButton(
                      color: GFColors.DARK,
                      text: "Imprimer",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
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
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
