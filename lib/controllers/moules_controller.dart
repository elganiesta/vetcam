import 'package:vetcam/boxes.dart';
import 'package:vetcam/models/moule_model.dart';

Future<void> addMoule(MouleModel moule) async {
  final box = Boxes.getMoules();
  box.add(moule);
}

int getLastMouleId() {
  final box = Boxes.getIds();
  var moules = box.get('moules');
  if (moules == null) {
    box.put('moules', {"id": 1});
    return 1;
  } else {
    return (moules['id'] + 1) as int;
  }
}

Future<void> updateLastMouleId(int? id) async {
  final box = Boxes.getIds();
  box.put('moules', {"id": id});
}