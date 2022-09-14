import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/Favorite.dart';
import 'package:weather_app/viewmodel/FavouritesModel.dart';
import 'package:weather_app/viewmodel/HomePageModel.dart';
import 'package:weather_app/views/SplashScreen.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(FavoriteAdapter());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageModel>(
          create: (_) => HomePageModel(),
        ),
        ChangeNotifierProvider<FavoriteModel>(
          create: (_) => FavoriteModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child:MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
