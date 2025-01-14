import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_model.dart';
import 'map_style.dart';
// import 'dart:ui' as ui;

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

  // Future<Uint8List> getImageFromRowData(String image, double width) async {
  //   var imageData = await rootBundle.load(image);
  //   var imageCodec = await ui.instantiateImageCodec(
  //       imageData.buffer.asUint8List(),
  //       targetWidth: width.round());
  //   var imageFrameInfo = await imageCodec.getNextFrame();
  //   var imageByteData =
  //       await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);
  //   return imageByteData!.buffer.asUint8List();
  // }

  void initMarkers() async {
    // var myMarker = Marker(
    //   markerId: MarkerId("1"),
    //   position: LatLng(31.187084851056554, 29.928110526889437),
    // );
    // markers.add(myMarker);
    String iconMarker = "assets/images/locationPin.png";
    // var customMarker =
    //     BitmapDescriptor.bytes(await getImageFromRowData(iconMarker, 35));
    var customMarker =
        await BitmapDescriptor.fromAssetImage(ImageConfiguration(), iconMarker);
    var myMarkers = plasser
        .map(
          (plassModel) => Marker(
            icon: customMarker,
            infoWindow: InfoWindow(title: plassModel.name),
            position: plassModel.latLng,
            markerId: MarkerId(
              plassModel.id.toString(),
            ),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }
}
