import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/controllers/matieres_controller.dart';
import 'package:vetcam/controllers/moules_controller.dart';
import 'package:vetcam/models/matiere_model.dart';
import 'package:vetcam/models/moule_model.dart';

Future<void> loadMoulesData() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  var file = appDocDir.path + '/vetcam data/files/moules.xlsx';
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    if (excel.tables.keys.contains("moules")) {
      for (var row in excel.tables[table]!.rows) {
        if (row[0]?.rowIndex == 0) continue;
        final moules =
            Boxes.getMoules().values.toList().cast<MouleModel>().toList();
        var moule = moules.firstWhere(
            (moule) => moule.numero == row[0]?.value.toString(),
            orElse: () => MouleModel()..id = "");
        moule
          ..numero = row[0]?.value.toString() ?? ""
          ..nom = row[1]?.value.toString() ?? ""
          ..marque = row[2]?.value.toString() ?? ""
          ..seuil = double.tryParse(row[3]?.value.toString() as String) ?? 0
          ..unite = row[2]?.value.toString() ?? "";
        if (moule.id == "") {
          moule
            ..id = getLastMouleId().toString()
            ..planches = 0
            ..status = statusMoules[1]
            ..reception = ""
            ..miseEnService = ""
            ..derniereUtilisation = ""
            ..rebut = "";
          await addMoule(moule);
        } else {
          await updateLastMouleId(getLastMouleId());
          await moule.save();
        }
      }
    }
  }
}

Future<void> loadPDRData() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  var file = appDocDir.path + '/vetcam data/files/pdr.xlsx';
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    if (sections.contains(table)) {
      for (var row in excel.tables[table]!.rows) {
        if (row[0]?.rowIndex == 0) continue;
        final matieres =
            Boxes.getMatieres().values.toList().cast<MatiereModel>().toList();
        var matiere = matieres.firstWhere(
            (matiere) => matiere.code == row[2]?.value.toString(),
            orElse: () => MatiereModel()..id = "");
        matiere
          ..code = row[2]?.value.toString() ?? ""
          ..designation = row[3]?.value.toString() ?? ""
          ..unite = row[4]?.value.toString() ?? ""
          ..prixU = double.tryParse(row[6]?.value.toStringAsFixed(1) as String) ?? 0;
        if (matiere.id == "") {
          var id = getLastMatiereId();
          matiere
            ..id = id.toString()
            ..observation = ""
            ..quantite = 0;
          await updateLastMatiereId(id);
          await addMatiere(matiere);
        } else {
          matiere.save();
        }
      }
    }
  }
}
