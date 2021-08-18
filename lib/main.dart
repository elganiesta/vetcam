import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetcam/notifiers/workshops_notifier.dart';
import 'route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WorkshopsNotifier()),
      ],
      child: MaterialApp(
        title: 'Vetcam',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: '/Splash',
      ),
    );
  }
}
