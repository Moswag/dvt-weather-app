class Sys2{
  String? pod;

  Sys2({this.pod});

  factory Sys2.fromJson(Map<String, dynamic> json) => Sys2(
    pod: json["pod"]
  );
}