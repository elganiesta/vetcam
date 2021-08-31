import 'package:hive/hive.dart';
import 'besoinItem_model.dart';

part 'besoin_model.g.dart';

@HiveType(typeId:4)
class BesoinModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late List<BesoinItem> besoins;

  @HiveField(2)
  late String service;

  @HiveField(3)
  late String date;

  @HiveField(4)
  late bool urgent;

  @HiveField(5)
  String? status = "EN COURS";
}