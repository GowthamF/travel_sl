import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerAddress {
  final String addressLine;
  final LatLng locationLatLng;
  final String displayName;

  MarkerAddress({this.addressLine, this.locationLatLng, this.displayName});
}
