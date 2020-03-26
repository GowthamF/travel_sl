import 'package:google_maps_flutter/google_maps_flutter.dart';

class Places {
  final String placeid;
  final String placename;
  final LatLng placelocation;

  Places({this.placeid, this.placename, this.placelocation});

  String get placeId => placeid;
  String get placeName => placename;
  LatLng get placeLocation => placelocation;

  factory Places.fromJson(Map<String, dynamic> json) {}
}
