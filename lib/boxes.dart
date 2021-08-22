import 'package:hive/hive.dart';

import 'models/ordre_travail_model.dart';

class Boxes {
  static Box<OrdreTravailModel> getOrdres() =>
      Hive.box<OrdreTravailModel>('ordresTravail');
}
