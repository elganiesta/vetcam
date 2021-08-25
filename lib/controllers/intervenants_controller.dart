import 'package:vetcam/boxes.dart';
import 'package:vetcam/models/intervenant_model.dart';

Future<void> addIntervenant(IntervenantModel intervenant) async {
  final box = Boxes.getIntervenants();
  box.add(intervenant);
}

int getLastIntervId() {
  final box = Boxes.getIds();
  var intervenants = box.get('intervenants');
  if (intervenants == null) {
    box.put('intervenants', {"id": 1});
    return 1;
  } else {
    return (intervenants['id'] + 1) as int;
  }
}

Future<void> updateLastInterId(int? id) async {
  final box = Boxes.getIds();
  box.put('intervenants', {"id": id});
}