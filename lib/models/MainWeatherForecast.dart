class MainWeatherForecast {
  double? temp;
  double? feels_like;
  double? temp_min;
  double? temp_max;
  int? pressure;
  int? sea_level;
  int? grnd_level;
  int? humidity;

  //double temp_kf;

  MainWeatherForecast({
     this.temp,
     this.feels_like,
     this.temp_min,
     this.temp_max,
     this.pressure,
     this.sea_level,
     this.grnd_level,
     this.humidity,
  });

  factory MainWeatherForecast.fromJson(Map<String, dynamic> json) => MainWeatherForecast(
        temp: json["temp"],
        feels_like: json["feels_like"],
        temp_min: json["temp_min"],
        temp_max: json["temp_max"],
        pressure: json["pressure"],
        sea_level: json["sea_level"],
        grnd_level: json["grnd_level"],
        humidity: json["humidity"],
      );
}
