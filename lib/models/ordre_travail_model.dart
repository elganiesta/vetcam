import 'package:hive/hive.dart';

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
}