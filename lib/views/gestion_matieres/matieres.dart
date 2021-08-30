import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/models/matiere_model.dart';
import 'package:vetcam/views/gestion_matieres/create.dart';

class Matieres extends StatefulWidget {
  const Matieres({Key? key}) : super(key: key);

  @override
  _MatieresState createState() => _MatieresState();
}

class _MatieresState extends State<Matieres> {

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
                              insetPadding: EdgeInsets.symmetric(horizontal: 400),
                              child: SingleChildScrollView(
                                child: CreateMatiere(),
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
