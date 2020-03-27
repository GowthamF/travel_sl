import 'package:travel_sl/bloc/models/places/geometry.dart';

class Place {
  final Geometry geometry;
  final String placeid;
  final String placename;

  Place({this.geometry, this.placeid, this.placename});

  Geometry get getGeometry => geometry;
  String get getPlaceId => placeid;
  String get getPlaceName => placename;

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      geometry: Geometry.fromJson(json['geometry']),
      placeid: json['place_id'],
      placename: json['name'],
    );
  }
}
