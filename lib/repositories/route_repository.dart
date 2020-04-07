import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';

class RouteRepository {
  final RouteApiClient routeApiClient = RouteApiClient();

  Future<List<Routes>> getRoutes(
      dynamic origin, dynamic destination, dynamic mode) async {
    return await routeApiClient.getRoute(origin, destination, mode);
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<MarkerAddress>> getLocationAddress(
      Coordinates coordinates) async {
    List<Address> _address = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(coordinates.latitude, coordinates.longitude));
    List<MarkerAddress> _markerAddress = _address
        .map((f) => MarkerAddress(
            addressLine: f.addressLine,
            locationLatLng:
                LatLng(f.coordinates.latitude, f.coordinates.longitude)))
        .toList();
    return _markerAddress;
  }
}
