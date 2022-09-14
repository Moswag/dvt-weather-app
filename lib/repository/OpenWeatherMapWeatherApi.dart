import 'package:location/location.dart';
import 'package:weather_app/models/WeatherResponse.dart';

import '../models/Coordinates.dart';
import '../models/ForecastResponse.dart';
import '../services/WeatherApi.dart';
import '../utils/Constants.dart';
import '../utils/Endpoints.dart';
import '../utils/Globals.dart';
import '../utils/Reply.dart';

class OpenWeatherMapWeatherApi extends WeatherApi {
  static String fullUrl(endpoint) => '${Constants.BASE_URL}/$endpoint';

  @override
  Future<Reply<WeatherResponse>> getCurrentWeather(Coordinates coordinates) async => await getReply(
      fullUrl(
        Endpoints.weather,
      ),
      weatherResponseFromJson,
      queryParameters: {
        "lat": coordinates.lat,
        "lon": coordinates.lon,
        "appid": Constants.API_KEY,
        "units": Constants.TEMP_UNITS,
      });

  @override
  Future<Reply<ForecastResponse>> getForecast(Coordinates coordinates)  async => await getReply(
      fullUrl(
        Endpoints.forecast,
      ),
      forecastResponseFromJson,
      queryParameters: {
        "lat": coordinates.lat,
        "lon": coordinates.lon,
        "appid": Constants.API_KEY,
        "units": Constants.TEMP_UNITS,
      });

  @override
  Future<Coordinates?> getUserLocation() async {
    Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;

    // Check if location service is enable
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check if permission is granted
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    final locationData = await location.getLocation();
    return Coordinates(lon: locationData.longitude!, lat: locationData.latitude!);
  }
}