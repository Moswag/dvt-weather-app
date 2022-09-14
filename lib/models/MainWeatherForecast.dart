class MainWeatherForecast {
  double temp;
  double feels_like;
  double temp_min;
  double temp_max;
  int pressure;
  int sea_level;
  int grnd_level;
  int humidity;
  //double temp_kf;

  MainWeatherForecast(
      {required this.temp,
      required this.feels_like,
      required this.temp_min,
      required this.temp_max,
      required this.pressure,
      required this.sea_level,
      required this.grnd_level,
      required this.humidity,
      });

  factory MainWeatherForecast.fromJson(Map<String, dynamic> json) => MainWeatherForecast(
        temp: json["temp"],
        feels_like: json["feels_like"],
        temp_min: json["temp_min"],
        temp_max: json["temp_max"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        sea_level: json["sea_level"],
        grnd_level: json["grnd_level"],

      );


}
