import 'package:weather_app/models/ErrorResponse.dart';

class Reply<R> {
  late int statusCode;
  late R data;
  late ErrorResponse error;
  dynamic responseData;

  bool get isSuccess =>
      this != null &&
          statusCode != null &&
          statusCode >= 200 &&
          statusCode < 300;

  bool get isSuccess200Only =>
      this != null && this.statusCode != null && statusCode == 200;
}