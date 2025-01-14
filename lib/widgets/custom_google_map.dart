import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_style.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 12, target: LatLng(31.187084851056554, 29.928110526889437));
    initMarkers();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            markers: markers,
            // add style wiht json to String
            style: Utils.mapStyles,
            onMapCreated: (controller) {
              googleMapController = controller;
              // add style wiht json in googleMapController
              // initMapStyle();
            },
            initialCameraPosition: initialCameraPosition),
        Positioned(
            bottom: 16,
            right: 16,
            left: 16,
            child: ElevatedButton(
                onPressed: () {
                  googleMapController.animateCamera(CameraUpdate.newLatLng(
                      LatLng(31.158887525900187, 31.482723748533026)));
                  setState(() {});
                },
                child: Text("Change Location")))
      ],
    );
  }

  void initMapStyle() async {
    var nightMApStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_styles/night_map_style.json");
    googleMapController.setMapStyle(nightMApStyle);
  }

  void initMarkers() {
    var myMarker = Marker(
      markerId: MarkerId("1"),
      position: LatLng(31.187084851056554, 29.928110526889437),
    );
    markers.add(myMarker);
  }
}
