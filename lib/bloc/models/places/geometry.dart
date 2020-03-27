import 'package:travel_sl/bloc/models/directions/location.dart';

class Geometry {
  final Location location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(
        json['location'],
      ),
    );
  }
}
