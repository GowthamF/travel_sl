import 'package:travel_sl/models/models.dart';

class BusStations extends Place {
  BusStations({geometry, placeid, placename})
      : super(geometry: geometry, placeid: placeid, placename: placename);

  factory BusStations.fromJson(Map<String, dynamic> json) {
    final Place place = Place.fromJson(json);

    return (BusStations(
        geometry: place.getGeometry,
        placeid: place.getPlaceId,
        placename: place.getPlaceName));
  }
}
