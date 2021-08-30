import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vetcam/components/input.dart';
import 'package:vetcam/controllers/matieres_controller.dart';
import 'package:vetcam/models/matiere_model.dart';

class CreateMatiere extends StatefulWidget {
  const CreateMatiere({Key? key}) : super(key: key);

  @override
  _CreateMatiereState createState() => _CreateMatiereState();
}

class _CreateMatiereState extends State<CreateMatiere> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _codeController = TextEditingController(text: "");
  TextEditingController _designationController =
      TextEditingController(text: "");
  TextEditingController _uniteController = TextEditingController(text: "");
  TextEditingController _quantiteController = TextEditingController(text: "");
  TextEditingController _prixUController = TextEditingController(text: "");
  TextEditingController _observationController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Input(
            hint: 'Code',
            nomController: _codeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Input(
            hint: 'Désignation',
            nomController: _designationController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Input(
            hint: 'Unité',
            nomController: _uniteController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Input(
            hint: 'Quantité',
            nomController: _quantiteController,
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
            hint: 'Prix Unitaire',
            nomController: _prixUController,
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
            hint: 'Observation',
            nomController: _observationController,
            validator: (value) {
              return null;
            },
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
                  if (_formKey.currentState!.validate()) {
                    final id = getLastMatiereId();
                    final matiere = MatiereModel()
                      ..id = id.toString()
                      ..code = _codeController.text
                      ..designation = _designationController.text
                      ..unite = _uniteController.text
                      ..quantite = double.parse(_quantiteController.text)
                      ..prixU = double.parse(_prixUController.text)
                      ..observation = _observationController.text;
                    await addMatiere(matiere);
                    await updateLastMatiereId(id);
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
