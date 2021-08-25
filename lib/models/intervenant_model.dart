import 'package:hive/hive.dart';

part 'intervenant_model.g.dart';

@HiveType(typeId:1)
class IntervenantModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String nom;

  @HiveField(2)
  late String fonction;
}