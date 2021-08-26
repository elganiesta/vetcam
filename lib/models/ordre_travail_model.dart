import 'package:hive/hive.dart';

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
  late List types;

  @HiveField(6)
  late String travail;

  @HiveField(7)
  late List pieces;

  @HiveField(8)
  late String commentaire;

  @HiveField(9)
  late String status;

  @HiveField(10)
  late List<IntervenantModel> intervenants;
}