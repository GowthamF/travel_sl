import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/models/models.dart';

class Location {
  final double lat;
  final double lng;
  final String originPosition;
  final String destinationPosition;

  Location({this.lat, this.lng, this.originPosition, this.destinationPosition});

  double get getLat => lat;
  double get getLng => lng;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(lat: json['lat'], lng: json['lng']);
  }

  factory Location.getLocation(LatLng origin, LatLng destination) {
    return Location(
        originPosition: '${origin.latitude},${origin.longitude}',
        destinationPosition:
            '${destination.latitude},${destination.longitude}');
  }
}
