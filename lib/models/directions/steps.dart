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

  Steps(
      {this.distance,
      this.durations,
      this.startlocation,
      this.endLocation,
      this.transitDetails,
      this.steps,
      this.travelMode,
      this.instruction});

  factory Steps.fromJson(Map<String, dynamic> json, TravelMode travelMode) {
    List<Steps> _steps = [];

    if (json.containsKey('steps')) {
      for (var i = 0; i < json['steps'].length; i++) {
        if (json['steps'][i]['travel_mode'] == 'WALKING') {
          travelMode = TravelMode.Walking;
        }
        _steps.add(
          Steps.fromJson(json['steps'][i], travelMode),
        );
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
      steps: _steps,
      travelMode: travelMode,
      instruction: json['html_instructions'],
    );
  }
}
