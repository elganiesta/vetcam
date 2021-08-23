import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/models/ordre_travail_model.dart';

class OrdresTravail extends StatefulWidget {
  const OrdresTravail({Key? key}) : super(key: key);

  @override
  _OrdresTravailState createState() => _OrdresTravailState();
}

class _OrdresTravailState extends State<OrdresTravail> {
  final List<OrdreTravailModel> ordres = [];

  @override
  void dispose() {
    Hive.box('ordresTravail').close();
    super.dispose();
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
              ValueListenableBuilder(
                valueListenable: Boxes.getOrdres().listenable(),
                builder: (BuildContext context, Box<OrdreTravailModel> box, _) {
                  final ordres = box.values.toList().cast<OrdreTravailModel>();
                  return OrdresTable(ordres: ordres);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrdresTable extends StatelessWidget {
  const OrdresTable({
    Key? key,
    required this.ordres,
  }) : super(key: key);

  final List<OrdreTravailModel> ordres;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith(
          (states) => Colors.blueGrey[100] as Color),
      headingTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      columns: [
        DataColumn(label: Text('N° ORDER')),
        DataColumn(label: Text('ACTIONS')),
        DataColumn(label: Text('STATUS')),
        DataColumn(label: Text('DEMANDEUR')),
        DataColumn(label: Text('UNITE')),
        DataColumn(label: Text('DATE DEBUT')),
        DataColumn(label: Text('DATE FIN')),
      ],
      rows: ordres
          .map(
            (ordre) {
              return DataRow(
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
                          onPressed: () {},
                        ),
                        const SizedBox(width: 5,),
                        GFIconButton(
                          tooltip: "Modifier",
                          color: GFColors.INFO,
                          size: GFSize.SMALL,
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 5,),
                        GFIconButton(
                          tooltip: "Pause",
                          color: GFColors.WARNING,
                          size: GFSize.SMALL,
                          icon: Icon(Icons.pause),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 5,),
                        GFIconButton(
                          tooltip: "Continuer",
                          color: GFColors.SUCCESS,
                          size: GFSize.SMALL,
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 5,),
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
                      text: "En cours",
                      size: GFSize.MEDIUM,
                      color: GFColors.SUCCESS,
                    ),
                  )),
                  DataCell(Text(ordre.demandeur)),
                  DataCell(Text(ordre.unite)),
                  DataCell(Text(ordre.dateTimeDebut)),
                  DataCell(Text(ordre.dateTimeFin)),
                ],
              );
            },
          )
          .toList()
          .cast<DataRow>(),
    );
  }
}
