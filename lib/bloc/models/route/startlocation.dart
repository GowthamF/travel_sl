class StartLocation {
  final double lat;
  final double lng;

  StartLocation({this.lat, this.lng});

  double get getLat => lat;
  double get getLng => lng;

  factory StartLocation.fromJson(Map<String, dynamic> json) {
    return StartLocation(lat: json['lat'], lng: json['lng']);
  }
}
