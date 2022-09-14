import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/views/widget/BusyIndicator.dart';

import '../models/Favorite.dart';
import '../viewmodel/FavouritesModel.dart';
import 'AppDrawer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;

  late LatLng showLocationPosition0;

  Set<Marker> getMarkers(List<Favorite> listFavorites) {
    final Set<Marker> markersMultiple = Set();
    listFavorites.map((fav) => {
          markersMultiple.add(Marker(
            markerId: MarkerId(fav.placeName),
            position: LatLng(fav.lat, fav.lon),
            infoWindow: InfoWindow(
              title: fav.placeName,
              snippet: fav.placeName,
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ))
        });

    return markersMultiple;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteModel>(context, listen: false).loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteModel>(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: const Text('Map for Favorites'),
                centerTitle: true,
              ),
              drawer: const AppDrawer(),
              body: model.isLoading
                  ? const BusyIndicator()
                  : GoogleMap(
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(model.listFavorites[0].lat, model.listFavorites[0].lon), //initial position
                        zoom: 15.0, //initial zoom level
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
