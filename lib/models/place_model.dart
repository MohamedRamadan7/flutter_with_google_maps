import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlassModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlassModel(this.id, this.name, this.latLng);
}

List<PlassModel> plasser = [
  PlassModel(
      1, "مستشفى طلعت مصطفى", LatLng(31.192458737307962, 29.942154308731336)),
  PlassModel(2, "مستشفى احمد عبد العزيز",
      LatLng(31.188981177320567, 29.921632900261105)),
  PlassModel(3, "مستشفى اليتا", LatLng(31.17188485797739, 29.943591026703064)),
];
