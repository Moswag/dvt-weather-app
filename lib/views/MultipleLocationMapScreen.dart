import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/Utils.dart';
import 'package:weather_app/views/widget/BusyIndicator.dart';

import '../models/Favorite.dart';
import '../viewmodel/FavouritesModel.dart';
import 'AppDrawer.dart';

class MultipleLocationMapScreen extends StatefulWidget {
  const MultipleLocationMapScreen({Key? key}) : super(key: key);

  @override
  State<MultipleLocationMapScreen> createState() => _MultipleLocationMapScreenState();
}

class _MultipleLocationMapScreenState extends State<MultipleLocationMapScreen> {
  GoogleMapController? mapController;

  Set<Marker> getMarkers(List<Favorite> listFavorites) {
    final Set<Marker> markersMultiple = {};
    for (var i = 0; i < listFavorites.length; i++) {
      var position = LatLng(listFavorites[i].lat, listFavorites[i].lon);
      markersMultiple.add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(
          title: listFavorites[i].placeName,
          snippet: 'Temp: ${formatTemperature(listFavorites[i].temp)} on ${listFavorites[i].date}',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }
    return markersMultiple;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoriteModel>(context, listen: false).loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteModel>(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: const Text('Map for Favourites'),
                centerTitle: true,
              ),
              drawer: const AppDrawer(),
              body: model.isLoading
                  ? const BusyIndicator()
                  : model.listFavorites.isEmpty
                      ? const Center(
                          child: Text('No favourites added to view on map'),
                        )
                      : GoogleMap(
                          zoomGesturesEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(model.listFavorites[0].lat, model.listFavorites[0].lon), //initial position
                            zoom: 10.0,
                          ),
                          markers: getMarkers(model.listFavorites),
                          mapType: MapType.normal,
                          onMapCreated: (controller) {
                            setState(() {
                              mapController = controller;
                            });
                          },
                        ),
            ));
  }
}
