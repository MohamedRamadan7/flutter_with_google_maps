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
    initPolyLine();
    initPolyGon();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
  Set<Polyline> plylines = {};
  Set<Polygon> plygons = {};
  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            zoomControlsEnabled: false,
            // polylines: plylines,
            polygons: plygons,
            // markers: markers,
            style: Utils.mapStyles, // add style wiht json to String
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
  void initPolyLine() async {
    var myPlylines = Polyline(
      color: Colors.red,
      width: 5,
      zIndex: 2,
      startCap: Cap.roundCap,
      points: [
        LatLng(31.156292947997493, 29.869536284746005),
        LatLng(31.16740687294844, 29.877001334100342),
        LatLng(31.178207943132684, 29.91408381581429),
        LatLng(31.196691531759672, 29.92816423496481),
      ],
      polylineId: PolylineId('1'),
    );
    var myPlylines2 = Polyline(
      zIndex: 1,
      width: 5,
      startCap: Cap.roundCap,
      points: [
        LatLng(31.14790066695592, 29.91529764510305),
        LatLng(31.186745224764937, 29.896058452864683),
      ],
      polylineId: PolylineId('2'),
    );
    plylines.add(myPlylines);
    plylines.add(myPlylines2);
  }

  void initPolyGon() async {
    var myPlyGon = Polygon(
        strokeWidth: 3,
        fillColor: Colors.black.withOpacity(.5),
        holes: [
          [
            LatLng(31.181651139080422, 29.905358279958918),
            LatLng(31.179081028394208, 29.908126319493967),
            LatLng(31.18418446561954, 29.9093708644012),
          ]
        ],
        points: [
          LatLng(31.16740687294844, 29.877001334100342),
          LatLng(31.178207943132684, 29.91408381581429),
          LatLng(31.196691531759672, 29.92816423496481),
        ],
        polygonId: PolygonId('1'));
    plygons.add(myPlyGon);
  }

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
