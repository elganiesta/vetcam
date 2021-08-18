import 'package:flutter/material.dart';

import 'views/splash.dart';
import 'views/test_excel.dart';
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
      case '/test':
        return MaterialPageRoute(builder: (_) => const TestExcel());
      default:
        return MaterialPageRoute(builder: (_) => const Splash());
    }
  }
}