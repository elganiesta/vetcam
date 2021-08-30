import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vetcam/components/input.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/controllers/moules_controller.dart';
import 'package:vetcam/models/moule_model.dart';

class AddMoule extends StatefulWidget {
  const AddMoule({
    Key? key,
  }) : super(key: key);

  @override
  State<AddMoule> createState() => _AddMouleState();
}

class _AddMouleState extends State<AddMoule> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _numeroController = TextEditingController(text: "");
  TextEditingController _nomController = TextEditingController(text: "");
  TextEditingController _marqueController = TextEditingController(text: "");
  TextEditingController _seuilController = TextEditingController(text: "");
  TextEditingController _receptionController = TextEditingController(text: "");

  String _sectionSelected = "ALPHA";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              isExpanded: true,
              items: sections
                  .map((section) {
                    return DropdownMenuItem<String>(
                      child: Text(section),
                      value: section,
                    );
                  })
                  .toList()
                  .cast<DropdownMenuItem<String>>(),
              value: _sectionSelected,
              onChanged: (dynamic val) {
                setState(() {
                  _sectionSelected = val;
                });
              },
            ),
          ),
          Input(
            hint: 'N° Moule',
            nomController: _numeroController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (double.tryParse(value) == null) {
                return 'Only numbers are allowed';
              }
              return null;
            },
          ),
          Input(
            hint: 'Marque',
            nomController: _marqueController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Input(
            hint: 'Nom de moule',
            nomController: _nomController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          // Input(
          //   hint: 'Nombre de planches',
          //   nomController: _planchesController,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter some text';
          //     } else if (double.tryParse(value) == null) {
          //       return 'Only numbers are allowed';
          //     }
          //     return null;
          //   },
          // ),
          Input(
            hint: 'Seuil',
            nomController: _seuilController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (double.tryParse(value) == null) {
                return 'Only numbers are allowed';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: DateTimePicker(
              type: DateTimePickerType.dateTime,
              dateMask: 'd/MM/yyyy HH:mm',
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.event),
              dateLabelText: 'Date de réception',
              timeLabelText: "Hour",
              controller: _receptionController,
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
                  if(_receptionController.text == "") {
                    showMessage(context, "Date réception est obligatoire.");
                  } else if (_formKey.currentState!.validate()) {
                    final id = getLastMouleId();
                    final moule = MouleModel()
                      ..id = id.toString()
                      ..numero = _numeroController.text
                      ..nom = _nomController.text
                      ..marque = _marqueController.text
                      ..planches = 0
                      ..status = statusMoules[0]
                      ..reception = convertToDateTime(_receptionController.text)
                      ..miseEnService = ""
                      ..derniereUtilisation = ""
                      ..rebut = ""
                      ..seuil = double.parse(_seuilController.text)
                      ..unite = _sectionSelected;
                    await addMoule(moule);
                    await updateLastMouleId(id);
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
    );
  }
}
