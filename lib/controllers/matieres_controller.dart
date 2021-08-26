import 'package:vetcam/boxes.dart';
import 'package:vetcam/models/matiere_model.dart';

Future<void> addMatiere(MatiereModel matiere) async {
  final box = Boxes.getMatieres();
  box.add(matiere);
}

int getLastMatiereId() {
  final box = Boxes.getIds();
  var matieres = box.get('matieres');
  if (matieres == null) {
    box.put('matieres', {"id": 1});
    return 1;
  } else {
    return (matieres['id'] + 1) as int;
  }
}

Future<void> updateLastMatiereId(int? id) async {
  final box = Boxes.getIds();
  box.put('matieres', {"id": id});
}