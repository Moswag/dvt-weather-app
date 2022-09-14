class MainWeatherCurrent {
  double temp;
  double feels_like;
  double temp_min;
  double temp_max;
  int pressure;
  int humidity;


  MainWeatherCurrent(
      {required this.temp,
      required this.feels_like,
      required this.temp_min,
      required this.temp_max,
      required this.pressure,
      required this.humidity});

  factory MainWeatherCurrent.fromJson(Map<String, dynamic> json) => MainWeatherCurrent(
        temp: json["temp"],
        feels_like: json["feels_like"],
        temp_min: json["temp_min"],
        temp_max: json["temp_max"],
        pressure: json["pressure"],
        humidity: json["humidity"],
      );


}
