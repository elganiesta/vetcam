import 'package:hive/hive.dart';
import 'package:vetcam/models/besoin_model.dart';
import 'package:vetcam/models/intervenant_model.dart';
import 'package:vetcam/models/matiere_model.dart';
import 'package:vetcam/models/moule_model.dart';
import 'package:vetcam/models/produit_model.dart';

import 'models/ordre_travail_model.dart';

class Boxes {
  static Box<OrdreTravailModel> getOrdres() =>
      Hive.box<OrdreTravailModel>('ordresTravail');
  static Box<IntervenantModel> getIntervenants() =>
      Hive.box<IntervenantModel>('intervenants');
  static Box<MatiereModel> getMatieres() =>
      Hive.box<MatiereModel>('matieres');
  static Box<MouleModel> getMoules() =>
      Hive.box<MouleModel>('moules');
  static Box<BesoinModel> getBesoins() =>
      Hive.box<BesoinModel>('besoins');
  static Box<ProduitModel> getProduits() =>
      Hive.box<ProduitModel>('produits');
  static Box getIds() =>
      Hive.box('ids');
}
