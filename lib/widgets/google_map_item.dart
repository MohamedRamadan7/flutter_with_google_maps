import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_style.dart';

class GoogleMapItem extends StatefulWidget {
  const GoogleMapItem({super.key});

  @override
  State<GoogleMapItem> createState() => _GoogleMapItemState();
}

class _GoogleMapItemState extends State<GoogleMapItem> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 12, target: LatLng(31.187084851056554, 29.928110526889437));
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            zoomControlsEnabled: false,
            style: Utils.mapStyles, // add style wiht json to String
            onMapCreated: (controller) {
              googleMapController = controller;
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
            child: Text("Change Location"),
          ),
        )
      ],
    );
  }
}
