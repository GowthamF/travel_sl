import 'package:travel_sl/models/models.dart';

class Steps {
  final Distance distance;
  final Durations durations;
  final Location startlocation;
  final Location endLocation;
  final TransitDetails transitDetails;
  final List<Steps> steps;
  final TravelMode travelMode;
  final String instruction;
  final PolyLine polyLine;

  Steps(
      {this.distance,
      this.durations,
      this.startlocation,
      this.endLocation,
      this.transitDetails,
      this.steps,
      this.travelMode,
      this.instruction,
      this.polyLine});

  factory Steps.fromJson(Map<String, dynamic> json, TravelMode travelMode) {
    if (json.containsKey('steps')) {
      for (var i = 0; i < json['steps'].length; i++) {
        if (json['steps'][i]['travel_mode'] == 'WALKING') {
          travelMode = TravelMode.Walking;
        }
      }
    }
    return Steps(
      distance: Distance.fromJson(json['distance']),
      durations: Durations.fromJson(json['duration']),
      endLocation: Location.fromJson(json['end_location']),
      startlocation: Location.fromJson(json['start_location']),
      transitDetails: json['transit_details'] != null
          ? TransitDetails.fromJson(json['transit_details'])
          : TransitDetails(vehicleType: VehicleType.Driving),
      travelMode: travelMode,
      instruction: json['html_instructions'],
      polyLine: PolyLine.fromJson(json['polyline']),
    );
  }
}
