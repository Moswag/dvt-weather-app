import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:weather_app/models/ForecastResponse.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/services/OpenWeatherService.dart';
import 'package:weather_app/utils/Constants.dart';

import '../models/Coordinates.dart';
import '../models/WeatherItem.dart';
import '../models/WeatherResponse.dart';
import '../repository/OpenWeatherMapWeatherApi.dart';
import '../utils/Reply.dart';

class HomePageModel with ChangeNotifier {
  String backgroundImage = '';
  late Coordinates coordinates;

  late WeatherResponse weatherResponse;
  late List<WeatherItem> weatherItems;
  late String weatherCondition;
  bool isRequestPending = false;
  bool isWeatherLoaded = false;
  bool isRequestError = false;
  late OpenWeatherService openWeatherService;
  late Color backgroundColor;

  HomePageModel() {
    openWeatherService = OpenWeatherService(OpenWeatherMapWeatherApi());
  }

  setBackgroundImage(WeatherResponse weatherResponse) {
    if (weatherResponse.weather[0].main == "Clouds") {
      backgroundImage = "assets/images/forest_cloudy.png";
    } else if (weatherResponse.weather[0].main == "Rain") {
      backgroundImage = "assets/images/forest_rainy.png";
    } else if (weatherResponse.weather[0].main == "Clear") {
      backgroundImage = "assets/images/forest_sunny.png";
    }
  }

  setBackgroundColor(WeatherResponse weatherResponse) {
    if (weatherResponse.weather[0].main == "Clouds") {
      backgroundColor = Constants.COLOR_CLOUDY;
    } else if (weatherResponse.weather[0].main == "Rain") {
      backgroundColor = Constants.COLOR_RAINY;
    } else if (weatherResponse.weather[0].main == "Clear") {
      backgroundColor = Constants.COLOR_SUNNY;
    }
  }

  String getWeatherConditionIcon(String weatherCondition) {
    if (weatherCondition == "Clouds") {
      return "assets/icons/partlysunny@3x.png";
    } else if (weatherCondition == "Rain") {
      return "assets/icons/rain@3x.png";
    } else if (weatherCondition == "Clear") {
      return "assets/icons/clear@3x.png";
    } else {
      return "assets/icons/clear@3x.png";
    }
  }

  setWeatherCondition(WeatherResponse weatherResponse) {
    if (weatherResponse.weather[0].main == "Clear") {
      weatherCondition = "SUNNY";
    } else if (weatherResponse.weather[0].main == "Clouds") {
      weatherCondition = "CLOUDY";
    } else {
      weatherCondition = weatherResponse.weather[0].main.toUpperCase();
    }
  }

  List<WeatherItem> filterList(ForecastResponse forecastResponse) {
    var currentWeatherItem = forecastResponse.list[0];
    var subSequence = currentWeatherItem.dt_txt.substring(11, currentWeatherItem.dt_txt.length);
    return forecastResponse.list.where((item) => item.dt_txt.contains(subSequence)).toList();
  }

  void setRequestPendingState(bool isPending) {
    isRequestPending = isPending;
    notifyListeners();
  }

  Future<WeatherResponse?> getLatestWeather() async {
    setRequestPendingState(true);
    isRequestError = false;
    late WeatherResponse weatherResponse;
    late List<WeatherItem> weatherItemsFiltered;
    try {
      Reply<WeatherResponse> weatherResponseReply = await openWeatherService.getCurrentWeather().catchError((onError) => isRequestError = true);
      if (weatherResponseReply.isSuccess200Only) {
        weatherResponse = weatherResponseReply.data;
      }
      Reply<ForecastResponse> forecastResponseReply = await openWeatherService.getForecast().catchError((onError) => isRequestError = true);
      if (forecastResponseReply.isSuccess200Only) {
        ForecastResponse forecastResponse = forecastResponseReply.data;
        weatherItemsFiltered = filterList(forecastResponse);
      }
    } catch (e) {
      isRequestError = true;
    }

    isWeatherLoaded = true;
    updateModel(weatherResponse, weatherItemsFiltered);
    setWeatherCondition(weatherResponse);
    setBackgroundImage(weatherResponse);
    setBackgroundColor(weatherResponse);
    setRequestPendingState(false);
    notifyListeners();
    return weatherResponse;
  }

  void updateModel(WeatherResponse weatherResponseX, List<WeatherItem> weatherItemsX) {
    if (isRequestError) return;
    weatherResponse = weatherResponseX;
    weatherItems = weatherItemsX;
  }
}