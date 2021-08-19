import 'package:flutter/cupertino.dart';
import 'package:vetcam/models/workshop_model.dart';

class WorkshopsNotifier with ChangeNotifier {
  WorkshopModel? _currWorkshopModel;
  String _currSection = 'Production';

  WorkshopModel? get currWorkshopModel => _currWorkshopModel;
  String? get currSection => _currSection;

  set currWorkshopModel(WorkshopModel? workshop) {
    _currWorkshopModel = workshop;
    notifyListeners();
  }

  set currSection(String? section) {
    _currSection = section as String;
    notifyListeners();
  }
}