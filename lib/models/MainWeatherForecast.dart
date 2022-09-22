class MainWeatherForecast {
  num? temp;
  num? feels_like;
  num? temp_min;
  num? temp_max;
  num? pressure;
  num? sea_level;
  num? grnd_level;
  num? humidity;
  num? temp_kf;

  MainWeatherForecast({
    this.temp,
    this.feels_like,
    this.temp_min,
    this.temp_max,
    this.pressure,
    this.sea_level,
    this.grnd_level,
    this.humidity,
    this.temp_kf,
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
        temp_kf: json["temp_kf"],
      );
}
