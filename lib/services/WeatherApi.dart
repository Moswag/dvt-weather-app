import 'package:weather_app/models/ForecastResponse.dart';
import 'package:weather_app/utils/Reply.dart';

import '../models/Coordinates.dart';
import '../models/WeatherResponse.dart';

abstract class WeatherApi {

  Future<Coordinates?> getUserLocation();

  Future<Reply<WeatherResponse>> getCurrentWeather(Coordinates coordinates);

  Future<Reply<ForecastResponse>> getForecast(Coordinates coordinates);

}
