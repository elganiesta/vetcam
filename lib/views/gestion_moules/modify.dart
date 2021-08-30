import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vetcam/components/input.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/models/moule_model.dart';

class ModifyMoule extends StatefulWidget {
  final MouleModel moule;

  ModifyMoule({Key? key, required this.moule}) : super(key: key);

  @override
  State<ModifyMoule> createState() => _ModifyMouleState();
}

class _ModifyMouleState extends State<ModifyMoule> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nbrController = TextEditingController(text: "0");
  final TextEditingController _rebutController =
      TextEditingController(text: "");
  late String _statusSelected;
  late MouleModel _moule;

  @override
  void initState() {
    _moule = widget.moule;
    _statusSelected = _moule.status;
    super.initState();
  }

  Future<void> _saveModification() async {
    if (_formKey.currentState!.validate()) {
      double nbrPlanches = double.parse(_nbrController.text);
      nbrPlanches = double.parse(nbrPlanches.toStringAsFixed(0));
      if (_moule.planches == 0 && nbrPlanches != 0) {
        _moule.miseEnService = convertToDateTime(DateTime.now().toString());
      }
      _moule
        ..planches += nbrPlanches
        ..derniereUtilisation = convertToDateTime(DateTime.now().toString())
        ..status = _statusSelected;
      if (_rebutController.text != "") {
        _moule.rebut = convertToDateTime(_rebutController.text);
      }
      await _moule.save();
      _formKey.currentState!.reset();
      Navigator.pop(context);
    }
  }

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
              items: statusMoules
                  .map((status) {
                    return DropdownMenuItem<String>(
                      child: Text(status),
                      value: status,
                    );
                  })
                  .toList()
                  .cast<DropdownMenuItem<String>>(),
              value: _statusSelected,
              onChanged: (dynamic val) {
                setState(() {
                  _statusSelected = val;
                });
              },
            ),
          ),
          Input(
            hint: 'Nombre de planches',
            nomController: _nbrController,
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
              dateLabelText: 'Date mise en rebut',
              timeLabelText: "Hour",
              controller: _rebutController,
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
                onPressed: _saveModification,
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
