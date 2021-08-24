import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:vetcam/models/option_model.dart';
import 'package:vetcam/models/ordre_travail_model.dart';

import '../../const.dart';

class EditOrdreTravail extends StatefulWidget {
  const EditOrdreTravail({Key? key, required this.ordre}) : super(key: key);

  final OrdreTravailModel ordre;

  @override
  State<EditOrdreTravail> createState() => _EditOrdreTravailState();
}

class _EditOrdreTravailState extends State<EditOrdreTravail> {
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

  late OrdreTravailModel _ordre;
  bool modifiable = false;

  @override
  void initState() {
    _ordre = widget.ordre;

    _unites = unites
        .map((unite) {
          var option = OptionItem(unite);
          if (_ordre.unite == option.name) option.isSelected = true;
          return option;
        })
        .toList()
        .cast<OptionItem>();
    _pieces = pieces
        .map((piece) {
          var option = OptionItem(piece);
          var result = _ordre.pieces
              .firstWhere((e) => e == option.name, orElse: () => null);
          if (result != null) option.isSelected = true;
          return option;
        })
        .toList()
        .cast<OptionItem>();
    _types = typesTravail
        .map((type) {
          var option = OptionItem(type);
          var result = _ordre.types
              .firstWhere((e) => e == option.name, orElse: () => null);
          if (result != null) option.isSelected = true;
          return option;
        })
        .toList()
        .cast<OptionItem>();
    _debutController =
        TextEditingController(text: regularDateTime(_ordre.dateTimeDebut));
    _finController =
        TextEditingController(text: regularDateTime(_ordre.dateTimeFin));
    _demandeurController = TextEditingController(text: _ordre.demandeur);
    _travailController = TextEditingController(text: _ordre.travail);
    _commentaireController = TextEditingController(text: _ordre.commentaire);
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
    _ordre
      ..dateTimeDebut = convertToDateTime(_debutController.text)
      ..dateTimeFin = convertToDateTime(_finController.text)
      ..demandeur = _demandeurController.text
      ..unite = _unites.firstWhere((unite) => unite.isSelected == true).name
      ..travail = _commentaireController.text
      ..types = _typesList
      ..pieces = _piecesList
      ..commentaire = _commentaireController.text;
    await _ordre.save();
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
                            enabled: modifiable,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: DateTimePicker(
                            type: DateTimePickerType.dateTime,
                            dateMask: 'd/MM/yyyy HH:mm',
                            firstDate: DateTime.parse(_debutController.text),
                            lastDate: DateTime(2100),
                            icon: Icon(Icons.event),
                            dateLabelText: 'Date',
                            timeLabelText: "Hour",
                            controller: _finController,
                            onChanged: (val) => calculateDuree(),
                            enabled: modifiable,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(_duree),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            enabled: modifiable,
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
                          child: Text(_ordre.id),
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
                                        if (modifiable) {
                                          setState(() {
                                            _unites.forEach((unite) {
                                              unite.isSelected = false;
                                            });
                                            unite.isSelected = value as bool;
                                          });
                                        }
                                      },
                                    ),
                                    Text(unite.name),
                                    if (unite.name == "AUTRE" &&
                                        unite.isSelected)
                                      Container(
                                        width: 250,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: TextField(
                                            enabled: modifiable,
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
                                        if (modifiable) {
                                          setState(() {
                                            type.isSelected = value as bool;
                                          });
                                        }
                                      },
                                    ),
                                    Text(type.name),
                                    if (type.name == "AUTRE" && type.isSelected)
                                      Container(
                                        width: 250,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: TextField(
                                            enabled: modifiable,
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
                            enabled: modifiable,
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
                                        if (modifiable) {
                                          setState(() {
                                            piece.isSelected = value as bool;
                                          });
                                        }
                                      },
                                    ),
                                    Text(piece.name),
                                    if (piece.name == "AUTRE" &&
                                        piece.isSelected)
                                      Container(
                                        width: 250,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: TextField(
                                            enabled: modifiable,
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
                        enabled: modifiable,
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
                        color: modifiable ? GFColors.SECONDARY : GFColors.DANGER,
                        text: modifiable ? "Sauvegarder" : "Modifier",
                        onPressed: () async {
                          if (modifiable) {
                            if (!_formKey.currentState!.validate()) {
                            } else if (!checkBoxValid()) {
                              showMessage(context,
                                  "[UNITE, PIECES, TYPES] Please check at least one option.");
                            } else {
                              await ajouterOrdre();
                              Navigator.pop(context);
                            }
                          } else {
                            setState(() {
                              modifiable = true;
                            });
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
