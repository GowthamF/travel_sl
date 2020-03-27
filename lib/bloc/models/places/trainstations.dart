import 'package:travel_sl/bloc/models/places/place.dart';

class TrainStations extends Place {
  TrainStations({geometry, placeid, placename})
      : super(geometry: geometry, placeid: placeid, placename: placename);

  factory TrainStations.fromJson(Map<String, dynamic> json) {
    final Place place = Place.fromJson(json);

    return (TrainStations(
        geometry: place.getGeometry,
        placeid: place.getPlaceId,
        placename: place.getPlaceName));
  }
}
