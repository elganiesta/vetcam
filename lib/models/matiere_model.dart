import 'package:hive/hive.dart';

part 'matiere_model.g.dart';

@HiveType(typeId:2)
class MatiereModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String code;

  @HiveField(2)
  late String designation;

  @HiveField(3)
  late String unite;

  @HiveField(4)
  late double quantite;

  @HiveField(5)
  late double prixU;

  @HiveField(6)
  late String observation;
}