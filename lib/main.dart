import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vetcam/models/ordre_travail_model.dart';
import 'package:vetcam/notifiers/workshops_notifier.dart';
import 'route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(OrdreTravailModelAdapter());
  // await Hive.deleteBoxFromDisk('ordresTravail');
  await Hive.openBox<OrdreTravailModel>('ordresTravail');
  await Hive.openBox<Map<String, dynamic>>('ids');
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
        initialRoute: '/OrdresTravail',
      ),
    );
  }
}
