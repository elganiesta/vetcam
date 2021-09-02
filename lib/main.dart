import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vetcam/models/besoinItem_model.dart';
import 'package:vetcam/models/besoin_model.dart';
import 'package:vetcam/models/moule_model.dart';
import 'package:vetcam/models/produit_model.dart';
import 'models/ordre_travail_model.dart';
import 'models/intervenant_model.dart';
import 'models/matiere_model.dart';
import 'route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path + '/vetcam data/database');

  Hive.registerAdapter(OrdreTravailModelAdapter());
  Hive.registerAdapter(IntervenantModelAdapter());
  Hive.registerAdapter(MatiereModelAdapter());
  Hive.registerAdapter(MouleModelAdapter());
  Hive.registerAdapter(BesoinModelAdapter());
  Hive.registerAdapter(BesoinItemAdapter());
  Hive.registerAdapter(ProduitModelAdapter());
  await Hive.openBox<OrdreTravailModel>('ordresTravail');
  await Hive.openBox<IntervenantModel>('intervenants');
  await Hive.openBox<MatiereModel>('matieres');
  await Hive.openBox<MouleModel>('moules');
  await Hive.openBox<BesoinModel>('besoins');
  await Hive.openBox<ProduitModel>('produits');
  await Hive.openBox('ids');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vetcam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: '/Splash',
    );
  }
}
