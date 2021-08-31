import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/models/besoin_model.dart';
import 'package:vetcam/views/gestion_besoin/imprimer.dart';

class Besoins extends StatefulWidget {
  const Besoins({Key? key}) : super(key: key);

  @override
  _BesoinsState createState() => _BesoinsState();
}

class _BesoinsState extends State<Besoins> {
  String _status = "EN COURS";

  List<BesoinModel> _selectedBesoins = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: GFColors.DARK,
        title: const Text("Fiches des besoins"),
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
                            child: Text('RECU'),
                            value: 'RECU',
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
                          if (_selectedBesoins.length == 0) {
                            showMessage(context, "Aucun ordre séléctionnées");
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PreviewBesoins(
                                  besoins: _selectedBesoins,
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
                        text: "Produits",
                        onPressed: () {
                          Navigator.pushNamed(context, '/Designations');
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GFButton(
                        text: "Ajouter un besoin",
                        onPressed: () {
                          Navigator.pushNamed(context, '/CreateBesoin');
                        },
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                valueListenable: Boxes.getBesoins().listenable(),
                builder: (BuildContext context, Box<BesoinModel> box, _) {
                  final besoins = box.values
                      .toList()
                      .cast<BesoinModel>()
                      .where((besoin) => besoin.status == _status)
                      .toList();
                  besoins.sort((a, b) => regularDateTime(b.date)
                      .compareTo(regularDateTime(a.date)));
                  return DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blueGrey[100] as Color),
                    headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('ACTIONS')),
                      DataColumn(label: Text('STATUS')),
                      DataColumn(label: Text('SERVICE')),
                      DataColumn(label: Text('URGENT')),
                      DataColumn(label: Text('DATE')),
                    ],
                    rows: besoins
                        .map(
                          (besoin) {
                            bool _isCompleted = besoin.status == "RECU";
                            return DataRow(
                              selected: _selectedBesoins.contains(besoin),
                              onSelectChanged: (value) {
                                setState(() {
                                  final isAdding = value != null && value;

                                  isAdding
                                      ? _selectedBesoins.add(besoin)
                                      : _selectedBesoins.remove(besoin);
                                });
                              },
                              cells: <DataCell>[
                                DataCell(Text(besoin.id)),
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
                                                  PreviewBesoins(
                                                besoins: [besoin],
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
                                            '/ModifyBesoin',
                                            arguments: besoin,
                                          );
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
                                            besoin..status = "RECU";
                                            await besoin.save();
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
                                          await besoin.delete();
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                                DataCell(SizedBox(
                                  width: 100,
                                  child: GFBadge(
                                    text: besoin.status,
                                    size: GFSize.MEDIUM,
                                    color: besoin.status == "RECU"
                                        ? GFColors.SUCCESS
                                        : GFColors.DANGER,
                                  ),
                                )),
                                DataCell(Text(besoin.service)),
                                DataCell(Text(
                                  besoin.urgent ? "URGENT" : "",
                                  style: TextStyle(
                                    color: besoin.urgent
                                        ? GFColors.DANGER
                                        : GFColors.SUCCESS,
                                        fontWeight: FontWeight.bold
                                  ),
                                )),
                                DataCell(Text(besoin.date)),
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
