import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/models/moule_model.dart';

import 'create.dart';
import 'modify.dart';

class Moules extends StatefulWidget {
  const Moules({Key? key}) : super(key: key);

  @override
  _MoulesState createState() => _MoulesState();
}

class _MoulesState extends State<Moules> {
  String _uniteSelected = sections[0];

  Color getStatus(MouleModel moule) {

    switch (moule.status) {
      case "NEUF":
        return GFColors.SECONDARY;
      case "EN BONNE ETAT":
        return GFColors.SUCCESS;
      case "REPARE":
        return GFColors.DANGER;
      case "USE":
        return GFColors.DARK;
      default:
      return GFColors.PRIMARY;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: GFColors.DARK,
        title: const Text("Moules"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GFDropdown<String>(
                    dropdownButtonColor: GFColors.WARNING,
                    items: sections
                        .map(
                          (e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList()
                        .cast<DropdownMenuItem<String>>(),
                    value: _uniteSelected,
                    onChanged: (dynamic val) {
                      setState(() {
                        _uniteSelected = val as String;
                      });
                    },
                  ),
                  GFButton(
                    text: "Ajouter nouveau moule",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding:
                                  EdgeInsets.symmetric(horizontal: 400),
                              child: SingleChildScrollView(
                                child: AddMoule(),
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
                valueListenable: Boxes.getMoules().listenable(),
                builder: (BuildContext context, Box<MouleModel> box, _) {
                  final moules = box.values
                      .toList()
                      .cast<MouleModel>()
                      .where(
                          (moule) => moule.unite.compareTo(_uniteSelected) == 0)
                      .toList();
                  return DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blueGrey[100] as Color),
                    headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    columns: [
                      DataColumn(label: Text('Actions')),
                      DataColumn(label: Text('Numero')),
                      DataColumn(label: Text('Nom')),
                      DataColumn(label: Text('Marque')),
                      DataColumn(label: Text('Planches')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Réception')),
                      DataColumn(label: Text('Debut')),
                      DataColumn(label: Text('Modifié le',)),
                      DataColumn(label: Text('Rebut')),
                      DataColumn(label: Text('Seuil')),
                    ],
                    rows: moules
                        .map(
                          (moule) {
                            return DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Container(
                                    child: Row(
                                      children: [
                                        GFIconButton(
                                          tooltip: "Modifier",
                                          color: GFColors.INFO,
                                          size: GFSize.SMALL,
                                          icon: Icon(Icons.edit),
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 400),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: ModifyMoule(
                                                        moule: moule,
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        GFIconButton(
                                          tooltip: "Supprimer",
                                          color: GFColors.DANGER,
                                          size: GFSize.SMALL,
                                          icon: Icon(Icons.delete),
                                          onPressed: () async {
                                            await moule.delete();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                DataCell(Text(moule.numero)),
                                DataCell(Text(moule.nom)),
                                DataCell(Text(moule.marque)),
                                DataCell(
                                    Text(moule.planches.toStringAsFixed(0))),
                                    DataCell(SizedBox(
                                  width: 100,
                                  child: GFBadge(
                                    text: moule.status,
                                    size: GFSize.MEDIUM,
                                    color: getStatus(moule),
                                  ),
                                )),
                                DataCell(Text(moule.reception)),
                                DataCell(Text(moule.miseEnService.toString())),
                                DataCell(Text(moule.derniereUtilisation.toString())),
                                DataCell(Text(moule.rebut.toString()),),
                                DataCell(Text(moule.seuil.toStringAsFixed(0))),
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
