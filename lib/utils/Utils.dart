import 'package:intl/intl.dart';

String formatTemperature(double temperature){
  return "${temperature.toStringAsFixed(1)}\u00B0";
}

String getDayOfTheWeek(int dt){
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  return DateFormat('EEEE').format(date);
}

String formatToHumanReadableDate(int dt){
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  return DateFormat.yMMMd().format(date);
}