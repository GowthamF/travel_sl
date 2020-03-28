class Location {
  final double lat;
  final double lng;

  Location({this.lat, this.lng});

  double get getLat => lat;
  double get getLng => lng;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(lat: json['lat'], lng: json['lng']);
  }
}
