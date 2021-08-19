import 'package:flutter/material.dart';

import 'views/ordre_travail.dart';
import 'views/sections.dart';
import 'views/services.dart';
import 'views/splash.dart';
import 'views/workshops.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => const Splash());
      case '/Workshops':
        return MaterialPageRoute(builder: (_) => const Workshops());
      case '/Sections':
        return MaterialPageRoute(builder: (_) => const Sections());
      case '/Services':
        return MaterialPageRoute(builder: (_) => const Services());
      case '/OrdreTravail':
        return MaterialPageRoute(builder: (_) => const OrdreTravail());
      default:
        return MaterialPageRoute(builder: (_) => const Splash());
    }
  }
}