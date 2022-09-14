class Sys {
  String country;
  int sunrise;
  int sunset;

  Sys({required this.country, required this.sunrise, required this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  @override
  String toString() {
    return 'Sys{country: $country, sunrise: $sunrise, sunset: $sunset}';
  }
}
