class Clouds {
  int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );
}
