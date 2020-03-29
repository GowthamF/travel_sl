import 'package:geolocator/geolocator.dart';

class Location {
  static final Location _location = Location._internal();

  Location._internal();

  static Location getInstance() => _location;

  Position currentLocation;
}
