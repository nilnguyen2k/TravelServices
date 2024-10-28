import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCustom extends StatefulWidget {
  final String text;
  final String title;
  const MapCustom({Key? key, required this.text, required this.title}) : super(key: key);
  @override
  State<MapCustom> createState() => MapCustomState();
}

class MapCustomState extends State<MapCustom> {

  late Future<Map<String, double>> latlng;

  @override
  void initState() {
    latlng = getAddressFromText();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: latlng,
      builder: (context, snapshot){
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return const SizedBox.shrink();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return const SizedBox.shrink();
          case ConnectionState.done:
            final List<Marker> markers = <Marker>[
              Marker(
                markerId: const MarkerId(''),
                position: LatLng(snapshot.data!['latitude']!, snapshot.data!['longitude']!),
                infoWindow: InfoWindow(
                  title: widget.title
                )
              )
            ];
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(snapshot.data!['latitude']!, snapshot.data!['longitude']!),
                zoom: 22,
              ),
              markers: Set<Marker>.of(markers)
            );
        }
      } 
    );
  }

  Future<Map<String, double>> getAddressFromText() async {

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    List<Location> locations = await locationFromAddress(widget.text);

    return {
      "latitude" : locations.first.latitude,
      "longitude" : locations.first.longitude
    };
  }


}