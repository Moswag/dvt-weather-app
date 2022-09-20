import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/models/Favorite.dart';

import '../utils/Utils.dart';

class SingleLocationMapScreen extends StatefulWidget {
  Favorite favorite;

  SingleLocationMapScreen({required this.favorite, Key? key}) : super(key: key);

  @override
  State<SingleLocationMapScreen> createState() => _SingleLocationMapScreenState();
}

class _SingleLocationMapScreenState extends State<SingleLocationMapScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  late LatLng showLocation;

  @override
  void initState() {
    super.initState();
    showLocation = LatLng(widget.favorite.lat, widget.favorite.lon);
    markers.add(Marker(
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: widget.favorite.placeName,
        snippet: 'Temp: ${formatTemperature(widget.favorite.temp)} on ${widget.favorite.date}',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.favorite.placeName} on Map"),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: showLocation,
          zoom: 10.0,
        ),
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}
