import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/controllers/ordres_travail_controller.dart';
import 'package:vetcam/models/intervenant_model.dart';
import 'package:vetcam/models/matiere_model.dart';
import 'package:vetcam/models/option_model.dart';
import 'package:vetcam/models/ordre_travail_model.dart';

import '../../const.dart';

class CreateOrdreTravail extends StatefulWidget {
  const CreateOrdreTravail({Key? key}) : super(key: key);

  @override
  State<CreateOrdreTravail> createState() => _CreateOrdreTravailState();
}

class _CreateOrdreTravailState extends State<CreateOrdreTravail> {
  final _formKey = GlobalKey<FormState>();

  late List<OptionItem> _unites;
  late List<OptionItem> _types;
  late List<OptionItem> _pieces;
  late List<OptionItem> _intervenants;
  late OptionItem _intervSelected;
  late List<OptionItem> _matieres;
  late OptionItem _matiereSelected;

  late TextEditingController _debutController;
  late TextEditingController _finController;
  late TextEditingController _demandeurController;
  late TextEditingController _travailController;
  late TextEditingController _commentaireController;
  String _duree = "";
  String _ordreId = "";
  String _autreUnite = "";
  String _autreType = "";
  String _autrePiece = "";

  @override
  void initState() {
    _intervenants = Boxes.getIntervenants()
        .values
        .map((intervenant) => OptionItem(intervenant))
        .toList()
        .cast<OptionItem>();
    if (_intervenants.length != 0) _intervSelected = _intervenants[0];
    _matieres = Boxes.getMatieres()
        .values
        .map((matiere) => OptionItem(matiere))
        .toList()
        .cast<OptionItem>();
    if (_matieres.length != 0) _matiereSelected = _matieres[0];

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
    _ordreId = getLastOrdreId().toString();
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

  String calculateTotal(OptionItem option) {
    return (option.item.prixU * option.item.quantite).toString();
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
    bool _intervIsValid = _intervenants
        .firstWhere((e) => e.isSelected == true, orElse: () => OptionItem(""))
        .isSelected;
    bool _matiereIsValid = _matieres
        .firstWhere((e) => e.isSelected == true, orElse: () => OptionItem(""))
        .isSelected;
    if (_pieceIsValid &&
        _typeIsValid &&
        _uniteIsValid &&
        _intervIsValid &&
        _matiereIsValid) return true;
    return false;
  }

  Future<void> ajouterOrdre() async {
    List _typesList = _types.map((e) {
      if (e.isSelected == true) return e.item;
    }).toList();
    _typesList.removeWhere((e) => e == null);
    List _piecesList = _pieces.map((e) {
      if (e.isSelected == true) return e.item;
    }).toList();
    List<IntervenantModel> _intervenantsList = [];
    _intervenants.forEach((e) {
      if (e.isSelected) {
        _intervenantsList.add(e.item);
      }
    });
    List<MatiereModel> _matieresList = [];
    _matieres.forEach((e) {
      if (e.isSelected) {
        _matieresList.add(e.item);
      }
    });
    _piecesList.removeWhere((e) => e == null);
    final ordre = OrdreTravailModel()
      ..id = _ordreId
      ..status = "EN COURS"
      ..dateTimeDebut = convertToDateTime(_debutController.text)
      ..dateTimeFin = convertToDateTime(_finController.text)
      ..demandeur = _demandeurController.text
      ..unite = _unites.firstWhere((unite) => unite.isSelected == true).item
      ..autreUnite = _autreUnite
      ..travail = _travailController.text
      ..types = _typesList
      ..autreType = _autreType
      ..pieces = _piecesList
      ..autrePiece = _autrePiece
      ..intervenants = _intervenantsList
      ..matieres = _matieresList
      ..commentaire = _commentaireController.text;
    await addOrdreTravail(ordre);
    await updateLastOrdreId(int.parse(_ordreId));
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
                            firstDate: DateTime.parse(_debutController.text),
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
                                          if (unite.item != "AUTRE" &&
                                                value == true) {
                                              _autreUnite = "";
                                            }
                                        });
                                      },
                                    ),
                                    Text(unite.item),
                                    if (unite.item == "AUTRE" &&
                                        unite.isSelected)
                                      Container(
                                        width: 250,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: TextFormField(
                                            onChanged: (String val) {
                                              setState(() {
                                                _autreUnite = val;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Tapez ici..',
                                            ),
                                            validator: (value) {
                                              if (unite.item == "AUTRE" && unite.isSelected) {
                                                if(value == null || value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                              }
                                              return null;
                                            },
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
                                          if (type.item == "AUTRE" &&
                                                value == false) {
                                              _autreType = "";
                                            }
                                        });
                                      },
                                    ),
                                    Text(type.item),
                                    if (type.item == "AUTRE" && type.isSelected)
                                      Container(
                                        width: 250,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: TextFormField(
                                            onChanged: (String val) {
                                              setState(() {
                                                _autreType = val;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Tapez ici..',
                                            ),
                                            validator: (value) {
                                              if (type.item == "AUTRE" && type.isSelected) {
                                                if(value == null || value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                              }
                                              return null;
                                            },
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
                Table(
                  border: TableBorder.all(
                    color: Colors.black,
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    const TableRow(
                      children: [
                        CellTitle(text: 'LISTE DES INTERVENANTS'),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 300.0),
                          child: Wrap(
                            children: [
                              DropdownButton<OptionItem>(
                                items: _intervenants
                                    .map((intervenant) {
                                      return DropdownMenuItem<OptionItem>(
                                        child: Text(intervenant.item.nom),
                                        value: intervenant,
                                      );
                                    })
                                    .toList()
                                    .cast<DropdownMenuItem<OptionItem>>(),
                                value: _intervSelected,
                                onChanged: (dynamic val) {
                                  setState(() {
                                    _intervSelected = val;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              FractionallySizedBox(
                                widthFactor: 1 / 3,
                                child: GFButton(
                                  text: "Ajouter",
                                  onPressed: () {
                                    setState(() {
                                      _intervenants.forEach((e) {
                                        if (e.item.id ==
                                            _intervSelected.item.id) {
                                          e.isSelected = true;
                                        }
                                      });
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FractionallySizedBox(
                                widthFactor: 1 / 3,
                                child: GFButton(
                                  text: "Supprimer",
                                  color: GFColors.DANGER,
                                  onPressed: () {
                                    setState(() {
                                      _intervenants.forEach((e) {
                                        if (e.item.id ==
                                            _intervSelected.item.id) {
                                          e.isSelected = false;
                                        }
                                      });
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                //add to LISTE DES INTERVENANTS
                Table(
                  border: TableBorder.all(
                    color: Colors.black,
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        CellTitle(text: 'NOM'),
                        CellTitle(text: 'FONCTION'),
                        CellTitle(text: 'VISA'),
                      ],
                    ),
                    for (var intervenant in _intervenants)
                      if (intervenant.isSelected)
                        TableRow(
                          children: [
                            CellTitle(
                              text: intervenant.item.nom,
                              title: false,
                            ),
                            CellTitle(
                              text: intervenant.item.fonction,
                              title: false,
                            ),
                            CellTitle(
                              text: "",
                              title: false,
                            ),
                          ],
                        ),
                  ],
                ),
                // LISTE DES MATIERES
                Table(
                  border: TableBorder.all(
                    color: Colors.black,
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    const TableRow(
                      children: [
                        CellTitle(text: 'PIECES ET MATIERES CONSOMMEES'),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Wrap(
                            children: [
                              FractionallySizedBox(
                                widthFactor: 0.5,
                                child: DropdownButton<OptionItem>(
                                  items: _matieres
                                      .map((matiere) {
                                        return DropdownMenuItem<OptionItem>(
                                          child: Text(matiere.item.designation),
                                          value: matiere,
                                        );
                                      })
                                      .toList()
                                      .cast<DropdownMenuItem<OptionItem>>(),
                                  value: _matiereSelected,
                                  onChanged: (dynamic val) {
                                    setState(() {
                                      _matiereSelected = val;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.2,
                                child: GFButton(
                                  text: "Ajouter",
                                  onPressed: () {
                                    setState(() {
                                      _matieres.forEach((e) {
                                        if (e.item.code ==
                                            _matiereSelected.item.code) {
                                          e.isSelected = true;
                                        }
                                      });
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.2,
                                child: GFButton(
                                  text: "Supprimer",
                                  color: GFColors.DANGER,
                                  onPressed: () {
                                    setState(() {
                                      _matieres.forEach((e) {
                                        if (e.item.code ==
                                            _matiereSelected.item.code) {
                                          e.isSelected = false;
                                        }
                                      });
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                //add to LISTE DES INTERVENANTS
                Table(
                  border: TableBorder.all(
                    color: Colors.black,
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        CellTitle(text: 'N°'),
                        CellTitle(text: 'Code Produit'),
                        CellTitle(text: 'Désignation'),
                        CellTitle(text: 'Unité'),
                        CellTitle(text: 'Quantité'),
                        CellTitle(text: 'Prix Unité'),
                        CellTitle(text: 'Prix Total'),
                        CellTitle(text: 'Observation'),
                      ],
                    ),
                    for (var matiere in _matieres)
                      if (matiere.isSelected)
                        TableRow(
                          children: [
                            CellTitle(
                              text: matiere.item.id,
                              title: false,
                            ),
                            CellTitle(
                              text: matiere.item.code,
                              title: false,
                            ),
                            CellTitle(
                              text: matiere.item.designation,
                              title: false,
                            ),
                            CellTitle(
                              text: matiere.item.unite,
                              title: false,
                            ),
                            CellTitle(
                              text: matiere.item.quantite.toString(),
                              title: false,
                            ),
                            CellTitle(
                              text: matiere.item.prixU.toString() + ' DH',
                              title: false,
                            ),
                            CellTitle(
                              text: calculateTotal(matiere) + ' DH',
                              title: false,
                            ),
                            CellTitle(
                              text: matiere.item.observation,
                              title: false,
                            ),
                          ],
                        ),
                  ],
                ),
                Table(
                  border: TableBorder.all(
                    color: Colors.black,
                  ),
                  columnWidths: {
                    0: FractionColumnWidth(0.75),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        CellTitle(text: 'TOTAL'),
                        CellTitle(
                          text: _matieres
                              .map((e) {
                                if(e.isSelected) return e.item.prixU * e.item.quantite;
                                else return 0;
                              })
                              .reduce((value, element) => value + element).toString() + ' DH',
                          title: false,
                        ),
                      ],
                    ),
                  ],
                ),
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
                                          if(piece.item == "AUTRE" && value == false) {
                                            _autrePiece = "";
                                          }
                                        });
                                      },
                                    ),
                                    Text(piece.item),
                                    if (piece.item == "AUTRE" &&
                                        piece.isSelected)
                                      Container(
                                        width: 250,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: TextFormField(
                                            onChanged: (String val) {
                                              setState(() {
                                                _autrePiece = val;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Tapez ici..',
                                            ),
                                            validator: (value) {
                                              if (piece.item == "AUTRE" && piece.isSelected) {
                                                if(value == null || value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                              }
                                              return null;
                                            },
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
                FractionallySizedBox(
                  widthFactor: 1 / 6,
                  child: GFButton(
                    color: GFColors.SECONDARY,
                    text: "Sauvegarder",
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                      } else if (!checkBoxValid()) {
                        showMessage(context,
                            "[UNITE, PIECES, TYPES, INTERVENANTS] Please check at least one option.");
                      } else {
                        await ajouterOrdre();
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
