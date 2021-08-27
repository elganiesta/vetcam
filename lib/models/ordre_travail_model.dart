import 'package:hive/hive.dart';
import 'package:vetcam/models/matiere_model.dart';

import 'intervenant_model.dart';

part 'ordre_travail_model.g.dart';

@HiveType(typeId:0)
class OrdreTravailModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String dateTimeDebut;

  @HiveField(2)
  late String dateTimeFin;

  @HiveField(3)
  late String demandeur;

  @HiveField(4)
  late String unite;

  @HiveField(5)
  String? autreUnite;

  @HiveField(6)
  late List types;

  @HiveField(7)
  String? autreType;

  @HiveField(8)
  late String travail;

  @HiveField(9)
  late List pieces;

  @HiveField(10)
  String? autrePiece;

  @HiveField(11)
  late String commentaire;

  @HiveField(12)
  late String status;

  @HiveField(13)
  late List<IntervenantModel> intervenants;

  @HiveField(14)
  late List<MatiereModel> matieres;

  
}