import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            southwest: LatLng(31.035705475323176, 29.783907860678376),
            northeast: LatLng(31.28865257972049, 30.02904029481735))),
        initialCameraPosition: initialCameraPosition);
  }
}
