import 'package:flutter/material.dart';

import 'models/ordre_travail_model.dart';
import 'views/gestion_matieres/matieres.dart';
import 'views/gestion_moules/moules.dart';
import 'views/gestion_ordres_travail/create.dart';
import 'views/gestion_ordres_travail/edit.dart';
import 'views/gestion_ordres_travail/intervenants.dart';
import 'views/gestion_ordres_travail/ordres.dart';
import 'views/menu.dart';
import 'views/splash.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => const Splash());
      case '/Menu':
        return MaterialPageRoute(builder: (_) => const Menu());
      case '/OrdresTravail':
        return MaterialPageRoute(builder: (_) => const OrdresTravail());
      case '/CreateOrdreTravail':
        return MaterialPageRoute(builder: (_) => CreateOrdreTravail());
      case '/EditOrdreTravail':
        return MaterialPageRoute(
            builder: (_) => EditOrdreTravail(ordre: args as OrdreTravailModel));
      case '/Intervenants':
        return MaterialPageRoute(builder: (_) => Intervenants());
      case '/Matieres':
        return MaterialPageRoute(builder: (_) => Matieres());
      case '/Moules':
        return MaterialPageRoute(builder: (_) => Moules());
      default:
        return MaterialPageRoute(builder: (_) => const Splash());
    }
  }
}
