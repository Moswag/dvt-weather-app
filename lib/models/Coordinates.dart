class Coordinates {
  double lon;
  double lat;

  Coordinates({required this.lon, required this.lat});

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(lon: json["lon"], lat: json["lat"]);

  @override
  String toString() {
    return 'Coordinates{lon: $lon, lat: $lat}';
  }
}
