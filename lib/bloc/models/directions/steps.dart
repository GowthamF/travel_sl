import 'package:travel_sl/bloc/models/directions/distance.dart';
import 'package:travel_sl/bloc/models/directions/durations.dart';
import 'package:travel_sl/bloc/models/directions/location.dart';

class Steps {
  final Distance distance;
  final Durations durations;
  final Location startlocation;
  final Location endLocation;

  Steps({this.distance, this.durations, this.startlocation, this.endLocation});

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
      distance: Distance.fromJson(json['distance']),
      durations: Durations.fromJson(json['duration']),
      endLocation: Location.fromJson(json['end_location']),
      startlocation: Location.fromJson(json['start_location']),
    );
  }
}
