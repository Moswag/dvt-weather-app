class Wind {
  double speed;
  int deg;
  double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"],
        deg: json["deg"],
        gust: json["gust"],
      );

  @override
  String toString() {
    return 'Wind{speed: $speed, deg: $deg, gust: $gust}';
  }
}
