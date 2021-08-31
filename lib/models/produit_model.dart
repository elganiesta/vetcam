import 'package:hive/hive.dart';

part 'produit_model.g.dart';

@HiveType(typeId:5)
class ProduitModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String nom;

  @HiveField(2)
  late String type;
}