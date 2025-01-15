import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/location_service%20.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_style.dart';

class GoogleMapItem extends StatefulWidget {
  const GoogleMapItem({super.key});

  @override
  State<GoogleMapItem> createState() => _GoogleMapItemState();
}

class _GoogleMapItemState extends State<GoogleMapItem> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  late LocationService locationService;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 1, target: LatLng(31.187084851056554, 29.928110526889437));
    locationService = LocationService();
    updateMyLocation();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
  bool isFristCal = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            zoomControlsEnabled: false,
            markers: markers,
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
              googleMapController!.animateCamera(CameraUpdate.newLatLng(
                  LatLng(31.158887525900187, 31.482723748533026)));
              setState(() {});
            },
            child: Text("Change Location"),
          ),
        )
      ],
    );
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    bool hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) {
        LatLng position =
            LatLng(locationData.latitude!, locationData.longitude!);
        setMyLocationMarkers(position);
        updateMyCamera(position);
      });
    } else {
      //ToDo: show error bar No permission
    }
  }

  void updateMyCamera(LatLng position) {
    if (isFristCal) {
      CameraPosition cameraPosition =
          CameraPosition(target: position, zoom: 12);
      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } else {
      googleMapController?.animateCamera(CameraUpdate.newLatLng(position));
    }
  }

  void setMyLocationMarkers(LatLng position) {
    var myLocationMarker =
        Marker(markerId: MarkerId("my_location_marker"), position: position);
    markers.add(myLocationMarker);
    setState(() {});
  }
}
