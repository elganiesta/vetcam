import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdreTravail extends StatefulWidget {
  const OrdreTravail({Key? key}) : super(key: key);

  @override
  State<OrdreTravail> createState() => _OrdreTravailState();
}

class _OrdreTravailState extends State<OrdreTravail> {
  String _uniteSelected = 'ALPHA';
  String _travailSelected = 'CONCEPTION MECANIQUE';

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
                          decoration: InputDecoration(
                            hintText: 'dd-MM-yyyy'
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'HH:mm:ss'
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'dd-MM-yyyy'
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'HH:mm:ss'
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('Durée calculé'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Nom et prénom'
                          ),
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
                      CellTitle(text: 'TYPE DE TRAVAIL'),
                    ],
                  ),
                  TableRow(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Radio(
                            value: "CONCEPTION MECANIQUE",
                            groupValue: _travailSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _travailSelected = value as String;
                              });
                            },
                          ),
                          const Text("CONCEPTION MECANIQUE"),
                          Radio(
                            value: "REPARATION",
                            groupValue: _uniteSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _uniteSelected = value as String;
                              });
                            },
                          ),
                          const Text("REPARATION"),
                          Radio(
                            value: "REGLAGE",
                            groupValue: _uniteSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _uniteSelected = value as String;
                              });
                            },
                          ),
                          const Text("REGLAGE"),
                          Radio(
                            value: "MAINTENANCE PREVENTIVE",
                            groupValue: _uniteSelected,
                            onChanged: (String? value) {
                              setState(() {
                                _uniteSelected = value as String;
                              });
                            },
                          ),
                          const Text("MAINTENANCE PREVENTIVE"),
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
