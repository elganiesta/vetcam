import 'package:vetcam/boxes.dart';
import 'package:vetcam/models/ordre_travail_model.dart';

Future<void> addOrdreTravail(OrdreTravailModel ordre) async {
  final box = Boxes.getOrdres();
  box.add(ordre);
}

int getLastOrdreId() {
  final box = Boxes.getIds();
  var orders = box.get('orders');
  if (orders == null) {
    box.put('orders', {"id": 1});
    return 1;
  } else {
    return (orders['id'] + 1) as int;
  }
}

Future<void> updateLastOrdreId(int? id) async {
  final box = Boxes.getIds();
  box.put('orders', {"id": id});
}
