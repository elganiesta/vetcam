import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';

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
              Table(
                border: TableBorder.all(
                  color: Colors.black,
                  width: 1,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: const [
                  TableRow(
                    children: [
                      CellTitle(text: 'DATE DEBUT'),
                      CellTitle(text: 'HEURE DEBUT'),
                      CellTitle(text: 'DATE FIN'),
                      CellTitle(text: 'HEURE FIN'),
                      CellTitle(text: 'DUREE'),
                      CellTitle(text: 'DEMANDEUR'),
                      CellTitle(text: 'N° ORDRE'),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'dd-MM-yyyy'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'HH:mm:ss'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'dd-MM-yyyy'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'HH:mm:ss'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('Durée calculé'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          decoration:
                              InputDecoration(hintText: 'Nom et prénom'),
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
                      FractionallySizedBox(
                        widthFactor: 1 / 5,
                        child: GFButton(
                          text: "Ajouter",
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: FractionallySizedBox(
                                            widthFactor: 0.4,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  hintText: 'Nom'),
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: FractionallySizedBox(
                                            widthFactor: 0.4,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  hintText: 'Fonction'),
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
                                              onPressed: () {},
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
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Table(
                border: TableBorder.all(
                  color: Colors.black,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: const [
                  TableRow(
                    children: [
                      CellTitle(text: 'NOM'),
                      CellTitle(text: 'FONCTION'),
                      CellTitle(text: 'VISA'),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(
                        child: Text(
                          "Nom prenom",
                        ),
                      ),
                      Center(
                        child: Text(
                          "Fonction",
                        ),
                      ),
                      Center(
                        child: Text(
                          "Signature",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
              Wrap(
                children: [
                  FractionallySizedBox(
                    widthFactor: 1 / 6,
                    child: GFButton(
                      color: GFColors.SUCCESS,
                      text: "Sauvegarder",
                      onPressed: () {
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
