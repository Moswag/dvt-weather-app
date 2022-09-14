import 'dart:convert';

import 'City.dart';
import 'WeatherItem.dart';

ForecastResponse forecastResponseFromJson(String str) => ForecastResponse.fromJson(json.decode(str));


class ForecastResponse {
  String cod;
  int message;
  int cnt;
  List<WeatherItem> list;
  City city;

  ForecastResponse({required this.cod, required this.message, required this.cnt, required this.list, required this.city});

  factory ForecastResponse.fromJson(Map<String, dynamic> json) => ForecastResponse(
    cod: json["cod"],
    message: json["message"],
    cnt: json["cnt"],
    list: List<WeatherItem>.from(json["list"].map((x) => WeatherItem.fromJson(x))),
    city: City.fromJson(json["city"]),
  );
}
