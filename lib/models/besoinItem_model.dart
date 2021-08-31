import 'package:hive/hive.dart';

part 'besoinItem_model.g.dart';

@HiveType(typeId:6)
class BesoinItem extends HiveObject {
  @HiveField(0)
  late String numero;

  @HiveField(1)
  late String designation;

  @HiveField(2)
  late String quantite;

  @HiveField(3)
  late String observation;
}