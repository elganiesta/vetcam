import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/controllers/intervenants_controller.dart';
import 'package:vetcam/models/intervenant_model.dart';

class Intervenants extends StatefulWidget {
  const Intervenants({Key? key}) : super(key: key);

  @override
  _IntervenantsState createState() => _IntervenantsState();
}

class _IntervenantsState extends State<Intervenants> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _fonctionController;

  @override
  void initState() {
    _nomController = TextEditingController(text: "");
    _fonctionController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    Hive.box('intervenants').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: GFColors.DARK,
        title: const Text("Intervenants"),
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
                    text: "Ajouter un intervenant",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: FractionallySizedBox(
                                          widthFactor: 0.4,
                                          child: TextFormField(
                                            controller: _nomController,
                                            decoration: InputDecoration(
                                              hintText: 'Nom',
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: FractionallySizedBox(
                                          widthFactor: 0.4,
                                          child: TextFormField(
                                            controller: _fonctionController,
                                            decoration: InputDecoration(
                                              hintText: 'Fonction',
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
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
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final id = getLastIntervId();
                                                final intervenant =
                                                    IntervenantModel()
                                                      ..id = id.toString()
                                                      ..nom =
                                                          _nomController.text
                                                      ..fonction =
                                                          _fonctionController
                                                              .text;
                                                await addIntervenant(
                                                    intervenant);
                                                await updateLastInterId(id);
                                                _formKey.currentState!.reset();
                                                Navigator.pop(context);
                                              }
                                            },
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
                valueListenable: Boxes.getIntervenants().listenable(),
                builder: (BuildContext context, Box<IntervenantModel> box, _) {
                  final intervenants =
                      box.values.toList().cast<IntervenantModel>().toList();
                  return DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blueGrey[100] as Color),
                    headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    columns: [
                      DataColumn(label: Text('N°')),
                      DataColumn(label: Text('ACTIONS')),
                      DataColumn(label: Text('NOM')),
                      DataColumn(label: Text('FONCTION')),
                    ],
                    rows: intervenants
                        .map(
                          (intervenant) {
                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text(intervenant.id)),
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
                                            await intervenant.delete();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                DataCell(Text(intervenant.nom)),
                                DataCell(Text(intervenant.fonction)),
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
