import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:excel/excel.dart';
import 'package:vetcam/boxes.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/controllers/moules_controller.dart';
import 'package:vetcam/models/moule_model.dart';

Future<void> loadMoulesData() async {
  var context = p.Context(style: p.Style.windows);
  var path = context.join(p.current, 'assets\\files');
  var file = "${path}\\moules.xlsx";
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
          await moule.save();
        }
      }
    }
  }
}
