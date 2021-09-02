import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/models/ordre_travail_model.dart';

import 'imprimer.dart';

class OrdresTravail extends StatefulWidget {
  const OrdresTravail({Key? key}) : super(key: key);

  @override
  _OrdresTravailState createState() => _OrdresTravailState();
}

class _OrdresTravailState extends State<OrdresTravail> {
  String _status = "EN COURS";
  String _search = "";

  List<OrdreTravailModel> _selectedOrdres = [];

  Map getStatus(OrdreTravailModel ordre) {
    Color color = GFColors.SUCCESS;
    String text = ordre.status;
    if (ordre.status == "PAUSE") {
      color = GFColors.WARNING;
    } else if (ordre.dateTimeFin != "") {
      text = "COMPLETED";
      color = GFColors.DANGER;
    }
    return {
      'color': color,
      'text': text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: GFColors.DARK,
        title: const Text("Ordres du travail"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GFDropdown<String>(
                        dropdownButtonColor: GFColors.WARNING,
                        items: [
                          DropdownMenuItem<String>(
                            child: Text('EN COURS'),
                            value: 'EN COURS',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('PAUSE'),
                            value: 'PAUSE',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('COMPLETED'),
                            value: 'COMPLETED',
                          ),
                        ],
                        value: _status,
                        onChanged: (dynamic val) {
                          setState(() {
                            _status = val as String;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GFButton(
                        text: "Imprimer les ordres séléctionnées",
                        color: GFColors.DARK,
                        onPressed: () {
                          if(_selectedOrdres.length == 0) {
                            showMessage(context, "Aucun ordre séléctionnées");
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PreviewOrdreTravail(
                                  ordres: _selectedOrdres,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GFButton(
                        text: "Intervenants",
                        onPressed: () {
                          Navigator.pushNamed(context, '/Intervenants');
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GFButton(
                        text: "Ajouter un ordre",
                        onPressed: () {
                          Navigator.pushNamed(context, '/CreateOrdreTravail');
                        },
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 300.0),
                child: Card(
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      onChanged: (String val) {
                        setState(() {
                          _search = val;
                        });
                      },
                      decoration: new InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                valueListenable: Boxes.getOrdres().listenable(),
                builder: (BuildContext context, Box<OrdreTravailModel> box, _) {
                  final ordres = box.values
                      .toList()
                      .cast<OrdreTravailModel>()
                      .where((ordre) => getStatus(ordre)['text'] == _status)
                      .where((ordre) => ordre.demandeur
                          .toLowerCase()
                          .contains(_search.toLowerCase()))
                      .toList();
                  ordres.sort((a, b) => regularDateTime(b.dateTimeDebut)
                      .compareTo(regularDateTime(a.dateTimeDebut)));
                  return DataTable(
                    columnSpacing: 30,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blueGrey[100] as Color),
                    headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    columns: [
                      DataColumn(label: Text('N° ORDER')),
                      DataColumn(label: Text('ACTIONS')),
                      DataColumn(label: Text('STATUS')),
                      DataColumn(label: Text('DEMANDEUR')),
                      DataColumn(label: Text('UNITE')),
                      DataColumn(label: Text('INTERVENANTS')),
                      DataColumn(label: Text('DATE DEBUT')),
                      DataColumn(label: Text('DATE FIN')),
                    ],
                    rows: ordres
                        .map(
                          (ordre) {
                            bool _isCompleted =
                                getStatus(ordre)['text'] == "COMPLETED";
                            return DataRow(
                              selected: _selectedOrdres.contains(ordre),
                              onSelectChanged: (value) {
                                setState(() {
                                  final isAdding =
                                      value != null && value;
                  
                                  isAdding
                                      ? _selectedOrdres.add(ordre)
                                      : _selectedOrdres.remove(ordre);
                                });
                              },
                              cells: <DataCell>[
                                DataCell(Text(ordre.id)),
                                DataCell(Container(
                                  child: Row(
                                    children: [
                                      GFIconButton(
                                        tooltip: "Imprimer",
                                        color: GFColors.DARK,
                                        size: GFSize.SMALL,
                                        icon: Icon(Icons.print),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PreviewOrdreTravail(
                                                ordres: [ordre],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GFIconButton(
                                        tooltip: "Details",
                                        color: GFColors.INFO,
                                        size: GFSize.SMALL,
                                        icon: Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/EditOrdreTravail',
                                            arguments: ordre,
                                          );
                                        },
                                      ),
                                      if (!_isCompleted)
                                        const SizedBox(
                                          width: 5,
                                        ),
                                      if (!_isCompleted)
                                        GFIconButton(
                                          tooltip: ordre.status == "EN COURS"
                                              ? "PAUSE"
                                              : "CONTINUER",
                                          color: ordre.status == "EN COURS"
                                              ? GFColors.WARNING
                                              : GFColors.SUCCESS,
                                          size: GFSize.SMALL,
                                          icon: Icon(ordre.status == "EN COURS"
                                              ? Icons.pause
                                              : Icons.play_arrow),
                                          onPressed: () async {
                                            if (ordre.status == "EN COURS") {
                                              ordre..status = "PAUSE";
                                            } else {
                                              ordre..status = "EN COURS";
                                            }
                                            await ordre.save();
                                          },
                                        ),
                                      if (!_isCompleted)
                                        const SizedBox(
                                          width: 5,
                                        ),
                                      if (!_isCompleted)
                                        GFIconButton(
                                          tooltip: "CLOTURER",
                                          color: GFColors.SECONDARY,
                                          size: GFSize.SMALL,
                                          icon: Icon(Icons.stop),
                                          onPressed: () async {
                                            ordre
                                              ..dateTimeFin = convertToDateTime(
                                                  DateTime.now().toString());
                                            await ordre.save();
                                          },
                                        ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GFIconButton(
                                        tooltip: "Supprimer",
                                        color: GFColors.DANGER,
                                        size: GFSize.SMALL,
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          await ordre.delete();
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                                DataCell(SizedBox(
                                  width: 100,
                                  child: GFBadge(
                                    text: getStatus(ordre)['text'],
                                    size: GFSize.MEDIUM,
                                    color: getStatus(ordre)['color'],
                                  ),
                                )),
                                DataCell(Text(ordre.demandeur)),
                                DataCell(Text(ordre.autreUnite == ""
                                    ? ordre.unite
                                    : ordre.autreUnite as String)),
                                DataCell(Container(
                                  child: Wrap(
                                    children: ordre.intervenants
                                        .map((e) {
                                          return Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Chip(
                                              label: Text(e.nom),
                                            ),
                                          );
                                        })
                                        .toList()
                                        .cast(),
                                  ),
                                )),
                                DataCell(Text(ordre.dateTimeDebut)),
                                DataCell(Text(ordre.dateTimeFin)),
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
