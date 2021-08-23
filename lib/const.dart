import 'package:intl/intl.dart';

const workshops = [
  'Alpha',
  'Tensyland',
  'NovaBloc'
];

const sections = [
  'Production',
  'Maintenacne'
];

const services = [
  'ORDRE DU TRAVAIL'
];

String convertToDateTime(String dateTime) {
  if(dateTime != "") return DateFormat('d/M/y HH:mm').format(DateTime.parse(dateTime));
  return "";
}