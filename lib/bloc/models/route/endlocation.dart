class EndLocation {
  final double lat;
  final double lng;

  EndLocation({this.lat, this.lng});

  double get getLat => lat;
  double get getLng => lng;

  factory EndLocation.fromJson(Map<String, dynamic> json) {
    return EndLocation(lat: json['lat'], lng: json['lng']);
  }
}
