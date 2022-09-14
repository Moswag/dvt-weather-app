import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

class ErrorResponse {
  int cod;
  String message;

  ErrorResponse({required this.cod, required this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(cod: json["cod"], message: json["message"]);

  @override
  String toString() {
    return 'ErrorResponse{cod: $cod, message: $message}';
  }
}
