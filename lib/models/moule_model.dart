import 'package:hive/hive.dart';

part 'moule_model.g.dart';

@HiveType(typeId:3)
class MouleModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String numero;

  @HiveField(2)
  late String nom;

  @HiveField(3)
  late String marque;

  @HiveField(4)
  late double planches;

  @HiveField(5)
  late String status;

  @HiveField(6)
  late String reception;

  @HiveField(7)
  String? miseEnService;

  @HiveField(8)
  String? derniereUtilisation;

  @HiveField(9)
  String? rebut;

  @HiveField(10)
  late double seuil;

  @HiveField(11)
  late String unite;
}