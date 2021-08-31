import 'package:vetcam/boxes.dart';
import 'package:vetcam/models/besoin_model.dart';

Future<void> addBesoin(BesoinModel besoin) async {
  final box = Boxes.getBesoins();
  box.add(besoin);
}

int getLastBesoinId() {
  final box = Boxes.getIds();
  var besoins = box.get('besoins');
  if (besoins == null) {
    box.put('besoins', {"id": 1});
    return 1;
  } else {
    return (besoins['id'] + 1) as int;
  }
}

Future<void> updateLastBesoinId(int? id) async {
  final box = Boxes.getIds();
  box.put('besoins', {"id": id});
}