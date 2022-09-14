import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/Favorite.dart';
import 'package:weather_app/viewmodel/FavouritesModel.dart';
import 'package:weather_app/viewmodel/HomePageModel.dart';
import 'package:weather_app/views/AppDrawer.dart';
import 'package:weather_app/views/widget/BusyIndicator.dart';
import '../utils/Globals.dart';
import '../utils/Utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FavoriteModel get favoriteModel => getIt<FavoriteModel>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<HomePageModel>(
      builder: (context, model, child) => Scaffold(
        key: _scaffoldKey,
        drawer: const AppDrawer(),
        body: buildHomeView(context, size),
      ),
    );
  }

  Widget buildHomeView(BuildContext context, Size size) {
    return Consumer<HomePageModel>(
        builder: (context, weatherViewModel, child) => weatherViewModel.isRequestPending
            ? const BusyIndicator()
            : weatherViewModel.isRequestError
                ? const Center(
                    child: Text(
                      'Ooops...something went wrong',
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  )
                : Center(
                    child: Container(
                      width: size.width,
                      height: size.height,
                      color: weatherViewModel.isRequestPending ? Colors.white : weatherViewModel.backgroundColor,
                      child: SafeArea(
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: RefreshIndicator(
                                color: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                onRefresh: () => refreshWeather(weatherViewModel, context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: size.height / 2.5,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage(weatherViewModel.backgroundImage), fit: BoxFit.cover),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: size.height * 0.01,
                                              horizontal: size.width * 0.05,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                IconButton(
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.bars,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    _scaffoldKey.currentState?.openDrawer();
                                                  },
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    icon: const FaIcon(
                                                      FontAwesomeIcons.heart,
                                                      color: Colors.white,
                                                      size: 40,
                                                    ),
                                                    onPressed: () async{
                                                      //Save location
                                                      Favorite favorite = Favorite(
                                                          placeName: weatherViewModel.weatherResponse.name,
                                                          temp: weatherViewModel.weatherResponse.main.temp,
                                                          weatherCondition: weatherViewModel.weatherResponse.weather[0].main,
                                                          lat: weatherViewModel.weatherResponse.coord.lat,
                                                          lon: weatherViewModel.weatherResponse.coord.lon,
                                                          date: formatToHumanReadableDate(weatherViewModel.weatherResponse.dt));
                                                      favoriteModel.saveFavorite(favorite);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.03,
                                            ),
                                            child: Align(
                                              child: Text(
                                                formatTemperature(weatherViewModel.weatherResponse.main.temp),
                                                style: GoogleFonts.questrial(
                                                  color: Colors.white,
                                                  fontSize: size.height * 0.1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.005,
                                            ),
                                            child: Align(
                                              child: Text(
                                                weatherViewModel.weatherCondition,
                                                style: GoogleFonts.questrial(color: Colors.white, fontSize: size.height * 0.03, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(size.width * 0.005),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                buildForecastToday(
                                                    formatTemperature(weatherViewModel.weatherResponse.main.temp_min),
                                                    "min",
                                                    size),
                                                buildForecastToday(
                                                  formatTemperature(weatherViewModel.weatherResponse.main.temp),
                                                  "Current",
                                                  size,
                                                ),
                                                buildForecastToday(
                                                  formatTemperature(weatherViewModel.weatherResponse.main.temp_max),
                                                  "max",
                                                  size,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.05,
                                          vertical: size.height * 0.02,
                                        ),
                                        child: Column(
                                            children: weatherViewModel.weatherItems
                                                .map((item) => buildFiveDayForecast(
                                                      getDayOfTheWeek(item.dt), //day
                                                      weatherViewModel.getWeatherConditionIcon(item.weather[0].main), //min temperature
                                                      formatTemperature(item.main.temp),
                                                      size,
                                                    ))
                                                .toList())),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
  }

  Widget buildForecastToday(String temp, String time, size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.025),
      child: Column(
        children: [
          Text(
            temp,
            style: GoogleFonts.questrial(
              color: Colors.white,
              fontSize: size.height * 0.025,
            ),
          ),
          Text(
            time,
            style: GoogleFonts.questrial(
              color: Colors.white,
              fontSize: size.height * 0.02,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFiveDayForecast(String day, String icon, String temp, size) {
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                  ),
                  child: Text(
                    day,
                    style: GoogleFonts.questrial(
                      color: Colors.white,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ImageIcon(
                  AssetImage(icon),
                  color: Colors.white,
                  size: size.height * 0.025,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  temp,
                  style: GoogleFonts.questrial(
                    color: Colors.white,
                    fontSize: size.height * 0.025,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> refreshWeather(HomePageModel homePageModel, BuildContext context) {
    return homePageModel.getLatestWeather();
  }
}
