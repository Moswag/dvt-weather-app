import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:weather_app/viewmodel/FavouritesModel.dart';
import 'package:weather_app/viewmodel/HomePageModel.dart';
import '../models/ErrorResponse.dart';

import 'Reply.dart';

GetIt getIt = GetIt.instance;

registerAllViewModels() {
  getIt.registerSingleton<HomePageModel>(HomePageModel());
  getIt.registerSingleton<FavoriteModel>(FavoriteModel());
}

Future<Reply<R>> getReply<R>(
  String url,
  dynamic fromJson, {
  Map<String, dynamic>? queryParameters,
  bool showErrorNotification = true,
}) async {
  Dio dio = Dio();
  Reply<R> r = Reply<R>();
  try {
    var resp = await dio.get<String>(
      url,
      queryParameters: queryParameters,
    );
    if (resp.statusCode == 200) {
      if (fromJson != null) {
        r.data = await compute(fromJson, resp.data.toString());
      } else {
        r.data = resp.data as R;
      }
    }
    r.statusCode = resp.statusCode!;
  } on DioError catch (error) {
    r.statusCode = error.response!.statusCode!;
    ErrorResponse errorResponse = errorResponseFromJson(error.response.toString());

    if (showErrorNotification) {
      showSimpleNotification(Text(errorResponse.message), background: Colors.green, duration: const Duration(seconds: 10));
    }
  }
  return r;
}
