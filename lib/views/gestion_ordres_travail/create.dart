import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:vetcam/controllers/ordres_travail_controller.dart';
import 'package:vetcam/models/option_model.dart';
import 'package:vetcam/models/ordre_travail_model.dart';

import '../../const.dart';

class OrdreTravail extends StatefulWidget {
  const OrdreTravail({Key? key}) : super(key: key);

  @override
  State<OrdreTravail> createState() => _OrdreTravailState();
}

class _OrdreTravailState extends State<OrdreTravail> {
  final _formKey = GlobalKey<FormState>();

  late List<OptionItem> _unites;
  late List<OptionItem> _types;
  late List<OptionItem> _pieces;

  late TextEditingController _debutController;
  late TextEditingController _finController;
  late TextEditingController _demandeurController;
  late TextEditingController _travailController;
  late TextEditingController _commentaireController;
  String _duree = "";
  String _ordreId = "";

  @override
  void initState() {
    _unites =
        unites.map((unite) => OptionItem(unite)).toList().cast<OptionItem>();
    _pieces =
        pieces.map((piece) => OptionItem(piece)).toList().cast<OptionItem>();
    _types = typesTravail
        .map((type) => OptionItem(type))
        .toList()
        .cast<OptionItem>();

    _debutController = TextEditingController(text: DateTime.now().toString());
    _finController = TextEditingController(text: '');
    _demandeurController = TextEditingController(text: "");
    _travailController = TextEditingController(text: "");
    _commentaireController = TextEditingController(text: "");
    _ordreId = getLastId().toString();
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

  bool checkBoxValid() {
    bool _pieceIsValid = _pieces
        .firstWhere((e) => e.isSelected == true, orElse: () => OptionItem(""))
        .isSelected;
    bool _typeIsValid = _types
        .firstWhere((e) => e.isSelected == true, orElse: () => OptionItem(""))
        .isSelected;
    bool _uniteIsValid = _unites
        .firstWhere((e) => e.isSelected == true, orElse: () => OptionItem(""))
        .isSelected;
    if (_pieceIsValid && _typeIsValid && _uniteIsValid) return true;
    return false;
  }

  Future<void> ajouterOrdre() async {
    List _typesList = _types.map((e) {
      if (e.isSelected == true) return e.name;
    }).toList();
    _typesList.removeWhere((e) => e == null);
    List _piecesList = _pieces.map((e) {
      if (e.isSelected == true) return e.name;
    }).toList();
    _piecesList.removeWhere((e) => e == null);
    final ordre = OrdreTravailModel()
      ..id = _ordreId
      ..status = "En Cours"
      ..dateTimeDebut = convertToDateTime(_debutController.text)
      ..dateTimeFin = convertToDateTime(_finController.text)
      ..demandeur = _demandeurController.text
      ..unite = _unites.firstWhere((unite) => unite.isSelected == true).name
      ..travail = _commentaireController.text
      ..types = _typesList
      ..pieces = _piecesList
      ..commentaire = _commentaireController.text;
    await addOrdreTravail(ordre);
    await updateLastOrderId(int.parse(_ordreId));
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Nom et prénom',
                            ),
                            controller: _demandeurController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(_ordreId),
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
                          children: _unites
                              .map((OptionItem unite) {
                                return Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: unite.isSelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _unites.forEach((unite) {
                                            unite.isSelected = false;
                                          });
                                          unite.isSelected = value as bool;
                                        });
                                      },
                                    ),
                                    Text(unite.name),
                                    if (unite.name == "AUTRE" &&
                                        unite.isSelected)
                                      Container(
                                        width: 250,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Tapez ici..',
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              })
                              .toList()
                              .cast<Widget>(),
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
                          children: _types
                              .map((type) {
                                return Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: type.isSelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          type.isSelected = value as bool;
                                        });
                                      },
                                    ),
                                    Text(type.name),
                                    if (type.name == "AUTRE" && type.isSelected)
                                      Container(
                                        width: 250,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Tapez ici..',
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              })
                              .toList()
                              .cast<Widget>(),
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
                  children: [
                    TableRow(
                      children: [
                        CellTitle(text: 'TRAVAIL DEMANDE'),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: TextFormField(
                            maxLines: 5,
                            controller: _travailController,
                            decoration: InputDecoration(
                              hintText: 'Tapez ici..',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
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
                          children: _pieces
                              .map((OptionItem piece) {
                                return Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: piece.isSelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          piece.isSelected = value as bool;
                                        });
                                      },
                                    ),
                                    Text(piece.name),
                                    if (piece.name == "AUTRE" &&
                                        piece.isSelected)
                                      Container(
                                        width: 250,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Tapez ici..',
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              })
                              .toList()
                              .cast<Widget>(),
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
                  children: [
                    Text(
                      'Commentaire :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        controller: _commentaireController,
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
                        color: GFColors.SECONDARY,
                        text: "Sauvegarder",
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                          } else if (!checkBoxValid()) {
                            showMessage(context,
                                "[UNITE, PIECES, TYPES] Please check at least one option.");
                          } else {
                            await ajouterOrdre();
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    // const SizedBox(
                    //   width: 50,
                    // ),
                    // FractionallySizedBox(
                    //   widthFactor: 1 / 6,
                    //   child: GFButton(
                    //     color: GFColors.DARK,
                    //     text: "Imprimer",
                    //     onPressed: () {},
                    //   ),
                    // ),
                  ],
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
