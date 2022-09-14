import 'package:weather_app/models/Clouds.dart';
import 'package:weather_app/models/MainWeatherForecast.dart';
import 'package:weather_app/models/Sys2.dart';

import '../utils/Utils.dart';
import 'Weather.dart';
import 'Wind.dart';


class WeatherItem {
  int dt;
  MainWeatherForecast main;
  List<Weather> weather;
  Clouds clouds;
  int visibility;
  int pop;
  Sys2 sys;
  String dt_txt;

  WeatherItem(
      {required this.dt,
      required this.main,
      required this.weather,
      required this.clouds,
      required this.visibility,
      required this.pop,
      required this.sys,
      required this.dt_txt});

  factory WeatherItem.fromJson(Map<String, dynamic> json) => WeatherItem(
    dt: json["dt"],
    main: MainWeatherForecast.fromJson(json["main"]),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    clouds: Clouds.fromJson(json["clouds"]),
    visibility: json["visibility"],
    pop: json["pop"],
    sys: Sys2.fromJson(json["sys"]),
    dt_txt: json["dt_txt"],
  );

  @override
  bool operator ==(Object other) => identical(this, other) || other is WeatherItem && runtimeType == other.runtimeType && getDayOfTheWeek(dt) == getDayOfTheWeek(other.dt);

  @override
  int get hashCode => dt.hashCode;


}
