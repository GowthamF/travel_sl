import 'package:travel_sl/models/models.dart';

class Steps {
  final Distance distance;
  final Durations durations;
  final Location startlocation;
  final Location endLocation;
  final TransitDetails transitDetails;

  Steps(
      {this.distance,
      this.durations,
      this.startlocation,
      this.endLocation,
      this.transitDetails});

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
        distance: Distance.fromJson(json['distance']),
        durations: Durations.fromJson(json['duration']),
        endLocation: Location.fromJson(json['end_location']),
        startlocation: Location.fromJson(json['start_location']),
        transitDetails: json['transit_details'] != null
            ? TransitDetails.fromJson(json['transit_details'])
            : TransitDetails(vehicleType: VehicleType.Driving));
  }
}
