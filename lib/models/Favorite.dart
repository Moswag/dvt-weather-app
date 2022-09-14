
import 'package:hive/hive.dart';
import 'package:weather_app/models/WeatherResponse.dart';

import '../utils/Utils.dart';

part 'Favorite.g.dart';

@HiveType(typeId: 1,adapterName: "FavoriteAdapter")
class Favorite extends HiveObject{
  @HiveField(0)
  String placeName;

  @HiveField(1)
  String weatherCondition;

  @HiveField(2)
  String date;

  @HiveField(3)
  double lat;

  @HiveField(4)
  double lon;

  @HiveField(5)
  double temp;

  Favorite({required this.placeName, required this.weatherCondition, required this.date, required this.lat, required this.lon, required this.temp});


}