import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> unites = [
  "ALPHA",
  "TENSYLAND",
  "NOVABLOC",
  "POLISSAGE",
  "P. ENROBEE",
  "MOBILIER URBAIN",
  "BPE",
  "AUTRE",
];

List<String> typesTravail = [
  "CONCEPTION MECANIQUE",
  "REPARATION",
  "REGLAGE",
  "MAINTENANCE PREVENTIVE",
  "AUTRE",
];

List<String> pieces = [
  "RAPPORT D'INTERVENTION",
  "FACTURE",
  "DEVIS",
  "DESSIN",
  "SCHEMA",
  "FICHE TECHNIQUE",
  "AUTRE",
];

List<String> sections = ['ALPHA', 'TENSYLAND', 'NOVABLOC'];
List<String> statusMoules = ['NEUF', 'EN BONNE ETAT', 'REPARE', 'USE'];

String convertToDateTime(String dateTime) {
  if (dateTime != "")
    return DateFormat('d/M/y HH:mm').format(DateTime.parse(dateTime));
  return "";
}

String regularDateTime(String dateTime) {
  final DateFormat displayFormater = DateFormat('d/M/y HH:mm');
  final DateFormat serverFormater = DateFormat('yyyy-MM-d HH:mm:ss.S');
  if(dateTime != "") {
    final DateTime displayDate = displayFormater.parse(dateTime);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  return "";
}

showMessage(context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    new SnackBar(
      content: Text(message.toString()),
      duration: new Duration(seconds: 5),
    ),
  );
}
