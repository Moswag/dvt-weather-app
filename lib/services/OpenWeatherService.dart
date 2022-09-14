import 'package:weather_app/models/ForecastResponse.dart';
import 'package:weather_app/models/WeatherResponse.dart';
import 'package:weather_app/utils/Reply.dart';

import 'WeatherApi.dart';

class OpenWeatherService{
  final WeatherApi weatherApi;
  OpenWeatherService(this.weatherApi);

  Future<Reply<WeatherResponse>> getCurrentWeather() async {
    final location = await weatherApi.getUserLocation();
    return await weatherApi.getCurrentWeather(location!);
  }

  Future<Reply<ForecastResponse>> getForecast() async {
    final location = await weatherApi.getUserLocation();
    return await weatherApi.getForecast(location!);
  }
}