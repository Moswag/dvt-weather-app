import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/Favorite.dart';
import 'package:weather_app/utils/Utils.dart';
import 'package:weather_app/viewmodel/FavouritesModel.dart';
import 'package:weather_app/viewmodel/HomePageModel.dart';
import 'package:weather_app/views/widget/BusyIndicator.dart';
import '../utils/Globals.dart';
import 'AppDrawer.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  HomePageModel get homePageModel => getIt<HomePageModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider
        .of<FavoriteModel>(context, listen: false).loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteModel>(
        builder: (context, model, child) =>
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: const Text('Favorites'),
                centerTitle: true,
              ),
              drawer: const AppDrawer(),
              body: model.isLoading
                  ? const BusyIndicator()
                  :
                  ListView.builder(
                  itemCount: model.listFavorites.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(model.listFavorites[index].placeName),
                      subtitle: Text('${model.listFavorites[index].weatherCondition} on ${model.listFavorites[index].date}'),
                      leading: ImageIcon(
                        AssetImage(homePageModel.getWeatherConditionIcon(model.listFavorites[index].weatherCondition)),
                        color: Colors.black,
                        size: 30,
                      ),
                      trailing: Text(
                        formatTemperature(model.listFavorites[index].temp),
                      ),
                    );
                  }),
            ));
  }
}
