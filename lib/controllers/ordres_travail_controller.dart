
import 'package:vetcam/boxes.dart';
import 'package:vetcam/models/ordre_travail_model.dart';

Future<void> addOrdreTravail(OrdreTravailModel ordre) async {
  final box = Boxes.getOrdres();
  box.add(ordre);
}