import 'package:hive/hive.dart';

import 'models/ordre_travail_model.dart';

class Boxes {
  static Box<OrdreTravailModel> getOrdres() =>
      Hive.box<OrdreTravailModel>('ordresTravail');
  static Box<Map<String, dynamic>> getIds() =>
      Hive.box<Map<String, dynamic>>('ids');
}
