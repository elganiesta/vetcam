import 'package:flutter/material.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vetcam/views/gestion_ordres_travail/ordre_travail.dart';

class OrdresTravail extends StatelessWidget {
  const OrdresTravail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        title: const Text("Ordres du travail"),
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
                    text: "Ajouter un ordre",
                    onPressed: () {
                      Navigator.pushNamed(context, '/OrdreTravail');
                    },
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
                columnWidths: const {
                  0: FixedColumnWidth(100),
                  2: FixedColumnWidth(150),
                  5: FixedColumnWidth(300),
                },
                children: [
                  TableRow(
                    children: [
                      CellTitle(text: "N°"),
                      CellTitle(text: "ACTIONS"),
                      CellTitle(text: "STATUS"),
                      CellTitle(text: "DEMANDEUR"),
                      CellTitle(text: "UNITE"),
                      CellTitle(text: "TYPE DU TRAVAIL"),
                      CellTitle(text: "DATE DEBUT"),
                      CellTitle(text: "DATE FIN"),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("5"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GFBadge(
                          size: GFSize.MEDIUM,
                          text: "Completed",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Flan"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Alpha"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Chip(
                                label: Text("REPARATION"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Chip(
                                label: Text("REGLAGE"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Chip(
                                label: Text("AUTRE"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("19-08-2021"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("20-08-2021"),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
