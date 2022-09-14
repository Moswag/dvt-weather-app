import 'dart:convert';

import 'package:weather_app/models/MainWeatherCurrent.dart';

import 'Clouds.dart';
import 'Coordinates.dart';
import 'Sys.dart';
import 'Weather.dart';
import 'Wind.dart';



WeatherResponse weatherResponseFromJson(String str) => WeatherResponse.fromJson(json.decode(str));


class WeatherResponse {
  Coordinates coord;
  List<Weather> weather;
  String base;
  MainWeatherCurrent main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  WeatherResponse(
      {required this.coord,
      required this.weather,
      required this.base,
      required this.main,
      required this.visibility,
      required this.wind,
      required this.clouds,
      required this.dt,
      required this.sys,
      required this.timezone,
      required this.id,
      required this.name,
      required this.cod});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => WeatherResponse(
    coord: Coordinates.fromJson(json["coord"]),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    base: json["base"],
    main: MainWeatherCurrent.fromJson(json["main"]),
    visibility: json["visibility"],
    wind: Wind.fromJson(json["wind"]),
    clouds: Clouds.fromJson(json["clouds"]),
    dt: json["dt"],
    sys: Sys.fromJson(json["sys"]),
    timezone: json["timezone"],
    id: json["id"],
    name: json["name"],
    cod: json["cod"],
  );
}
